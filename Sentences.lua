-- Sentences.lua
-- Manages a queue of motivational sentences, showing each randomly
-- Once all are shown, reshuffles and starts a new set

-- Load sentences from external file (MySentences.lua)
-- This keeps personal quotes separate and gitignored
local function loadSentences()
    local scriptPath = SKIN:GetVariable('CURRENTPATH')
    local filePath = scriptPath .. 'MySentences.lua'
    
    -- Try to load the personal sentences file
    local chunk, err = loadfile(filePath)
    if chunk then
        local success, result = pcall(chunk)
        if success and type(result) == 'table' and #result > 0 then
            return result
        end
    end
    
    -- Fallback: default sentences if MySentences.lua doesn't exist
    return {
        "Copy MySentences.lua.example to MySentences.lua and add your quotes!"
    }
end

local sentences = {}  -- Will be loaded on Initialize
local queue = {}       -- Current shuffled queue
local currentIndex = 0 -- Position in current queue
local setNumber = 0    -- Which set we're on

-- Fisher-Yates shuffle algorithm
function shuffle(t)
    local shuffled = {}
    for i = 1, #t do
        shuffled[i] = t[i]
    end
    for i = #shuffled, 2, -1 do
        local j = math.random(1, i)
        shuffled[i], shuffled[j] = shuffled[j], shuffled[i]
    end
    return shuffled
end

-- Initialize the script
function Initialize()
    math.randomseed(os.time())
    
    -- Load sentences from external file
    sentences = loadSentences()
    
    -- Shuffle and start fresh
    queue = shuffle(sentences)
    currentIndex = 1
    setNumber = 1
    
    -- Set initial values
    SKIN:Bang('!SetVariable', 'CurrentSentence', queue[currentIndex])
    SKIN:Bang('!SetVariable', 'SetNumber', setNumber)
    SKIN:Bang('!SetVariable', 'SentenceIndex', currentIndex .. '/' .. #queue)
end

-- Called every update cycle (20 seconds)
function Update()
    currentIndex = currentIndex + 1
    
    -- If we've shown all sentences, reshuffle for new set
    if currentIndex > #queue then
        queue = shuffle(sentences)
        currentIndex = 1
        setNumber = setNumber + 1
    end
    
    -- Update Rainmeter variables
    SKIN:Bang('!SetVariable', 'CurrentSentence', queue[currentIndex])
    SKIN:Bang('!SetVariable', 'SetNumber', setNumber)
    SKIN:Bang('!SetVariable', 'SentenceIndex', currentIndex .. '/' .. #queue)
    
    return queue[currentIndex]
end

-- Get current sentence (for inline Lua)
function GetSentence()
    if #queue == 0 then
        return sentences[1]
    end
    return queue[currentIndex] or sentences[1]
end

# Rainmeter skin - Sentence/Quote shuffler

A minimalist Rainmeter skin that displays sentences desktop. Sentences rotate randomly at configurable intervals, ensuring each sentence is shown once before the cycle repeats.

![Rainmeter](https://img.shields.io/badge/Rainmeter-4.0+-blue?style=flat-square)
![License](https://img.shields.io/badge/License-MIT-green?style=flat-square)

## Features

- **Smart Rotation**: Shows sentences randomly, but ensures all sentences are displayed before repeating
- **Configurable Timing**: Default 20-second interval (easily adjustable)

## Installation

1. Install [Rainmeter](https://www.rainmeter.net/) (4.0 or newer recommended)
2. Download/clone this repository to your Rainmeter Skins folder:
   ```
   Documents\Rainmeter\Skins\<name_of_your_skin>
   ```
3. Copy `MySentences.lua.example` to `MySentences.lua`
4. Edit `MySentences.lua` to add your own sentences
5. Load the skin from the Rainmeter Manage window

## Configuration

### Adding Your Own Sentences

Edit `MySentences.lua` and add your sentences:

```lua
return {
    "Your first sentence here.",
    "Another sentence.",
    "Keep adding more sentences!",
}
```

### Customizing Appearance

Edit `text.ini` and modify the `[Variables]` section:

| Variable | Default | Description |
|----------|---------|-------------|
| `TextColor` | `255,255,255` | RGB color for text |
| `FontName` | `Segoe UI Variable Display` | Font family |
| `TextSize` | `10` | Font size in pixels |
| `UpdateInterval` | `20000` | Rotation interval in ms (20s) |

### Changing Rotation Speed

In `text.ini`, modify:
- `UpdateInterval` in `[Variables]` for display timing
- `UpdateDivider` in `[MeasureLua]` (should match `UpdateInterval / 1000`)

## How It Works

1. On load, the script reads all sentences from `MySentences.lua`
2. Sentences are shuffled using the Fisher-Yates algorithm
3. Each sentence is displayed once in random order
4. When all sentences have been shown, a new shuffle occurs
5. The cycle continues indefinitely

## License

MIT License - Feel free to modify and share!

---


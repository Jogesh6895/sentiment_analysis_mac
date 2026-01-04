# LiveSentimentAnalysis

A hybrid macOS application that combines Swift (Cocoa UI) with Python (TextBlob sentiment analysis backend) for real-time and on-demand sentiment analysis of text.

## Features

- **Real-time Sentiment Analysis**: Analyze text as you type via live text field updates
- **On-demand Analysis**: Submit button for explicit sentiment analysis requests
- **Visual Feedback**: Color-coded results based on sentiment polarity:
  - 🔴 Red: Negative sentiment (score < 0)
  - 🟡 Yellow: Neutral sentiment (score = 0)
  - 🟢 Green: Positive sentiment (score > 0)
- **Hybrid Architecture**: Swift UI layer with Python backend processing
- **TextBlob Integration**: Uses Python's TextBlob library for accurate sentiment analysis

## Architecture

The application follows a client-server architecture:

```
┌─────────────────────┐         ┌──────────────────────┐
│   Swift UI Layer    │  IPC    │  Python Backend      │
│   (Cocoa/AppKit)    │ ------> │  (TextBlob)          │
│                     │         │                      │
│  - ViewController   │         │  - Sentiment_Analysis│
│  - NSTextField      │         │  - get_sentiment_    │
│  - Color updates    │         │    score()           │
└─────────────────────┘         └──────────────────────┘
```

### Components

- **AppDelegate.swift**: Application lifecycle management
- **ViewController.swift**: Main UI controller handling user interactions and Python subprocess execution
- **sentiment_analysis.py**: Python sentiment analysis module using TextBlob
- **Info.plist**: Application configuration and metadata

## Installation

### Prerequisites

- macOS 10.15+ (Catalina or later)
- Xcode 11.0 or later
- Python 3 with TextBlob library

### Setup

1. Clone the repository:
```bash
git clone <repository-url>
cd sentiment_analysis_mac
```

2. Install Python dependencies:
```bash
pip3 install textblob
```

3. Ensure Python 3 is available at `/usr/local/bin/python3` or update the path in `ViewController.swift:34` and `ViewController.swift:71`

## Building

### Using Xcode

1. Open `LiveSentimentAnalysis.xcodeproj` in Xcode
2. Select the `LiveSentimentAnalysis` scheme
3. Press `Cmd+B` to build or `Cmd+R` to build and run

### Using Command Line

```bash
# Build the project
xcodebuild -project LiveSentimentAnalysis.xcodeproj -scheme LiveSentimentAnalysis build

# Clean and build
xcodebuild -project LiveSentimentAnalysis.xcodeproj -scheme LiveSentimentAnalysis clean build
```

## Usage

### Running the Application

1. Launch the built application from Xcode or open the `.app` bundle from the build products directory
2. Enter text in either text field:
   - **Dynamic Text Field**: Real-time analysis as you type
   - **Main Text Field**: Analysis on button click
3. Observe the sentiment score and color-coded result

### Testing Python Script Independently

```bash
python3 sentiment_analysis.py "This is a wonderful day!"
# Output: 0.50

python3 sentiment_analysis.py "I hate this terrible experience"
# Output: -0.80
```

## Sentiment Scoring

The sentiment analysis returns a polarity score between -1.0 and 1.0:

| Score Range | Sentiment | Color |
|-------------|-----------|-------|
| < 0.0       | Negative  | Red   |
| = 0.0       | Neutral   | Yellow|
| > 0.0       | Positive  | Green |

The score is rounded to 2 decimal places for display.

## Development

### Code Style

See [AGENTS.md](AGENTS.md) for detailed code style guidelines including:
- Swift conventions (naming, imports, type safety, error handling)
- Python conventions (naming, structure, imports)
- Build and test commands

### File Structure

```
LiveSentimentAnalysis/
├── AppDelegate.swift          # App lifecycle management
├── ViewController.swift        # Main UI controller and Python subprocess handling
├── sentiment_analysis.py      # Sentiment analysis backend
├── Info.plist                  # App configuration
├── Assets.xcassets/           # App resources and icons
└── Base.lproj/
    └── Main.storyboard       # UI layout
```

### Modifying the Application

1. **UI Changes**: Edit `ViewController.swift` or `Main.storyboard`
2. **Sentiment Logic**: Modify `sentiment_analysis.py`
3. **Python Path**: Update the path in `ViewController.swift` if Python is installed elsewhere
4. **Color Scheme**: Modify color assignments in `ViewController.swift:39-45` and `ViewController.swift:75-82`

## Troubleshooting

### Python Script Not Found

If the app displays "Python script not found":
- Ensure `sentiment_analysis.py` is included in the app bundle target
- Check the build phases in Xcode to verify the Python script is copied to bundle resources

### Import Error

If TextBlob import fails:
- Install TextBlob: `pip3 install textblob`
- Ensure the correct Python interpreter is used (check the path in ViewController.swift)

### Build Errors

If Xcode build fails:
- Clean the build folder: `Product > Clean Build Folder` (Cmd+Shift+K)
- Verify Xcode command-line tools are installed: `xcode-select --install`

## License

Copyright © 2020 Jogesh Ghadai. All rights reserved.

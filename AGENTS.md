# Agent Guidelines for LiveSentimentAnalysis

This is a hybrid macOS application combining Swift (Cocoa UI) and Python (sentiment analysis backend).

## Build Commands

```bash
# Build the Xcode project
xcodebuild -project LiveSentimentAnalysis.xcodeproj -scheme LiveSentimentAnalysis build

# Clean and build
xcodebuild -project LiveSentimentAnalysis.xcodeproj -scheme LiveSentimentAnalysis clean build

# Run from Xcode
# Open the project in Xcode and press Cmd+R to run
```

## Test Commands

This project currently has no test targets configured. When adding tests:

```bash
# Run all tests (after adding test target)
xcodebuild test -project LiveSentimentAnalysis.xcodeproj -scheme LiveSentimentAnalysis -destination 'platform=macOS'

# Run specific test (example after adding test target)
xcodebuild test -project LiveSentimentAnalysis.xcodeproj -scheme LiveSentimentAnalysis -destination 'platform=macOS' -only-testing:LiveSentimentAnalysisTests/TestCaseName/testMethodName
```

## Python Dependencies

The Python script requires TextBlob. Install via:
```bash
pip3 install textblob
```

## Code Style Guidelines

### Swift

**File Header:**
All Swift files must include the standard copyright header:
```swift
//
//  FileName.swift
//  LiveSentimentAnalysis
//
//  Created by [Author Name] on [Date].
//  Copyright © 2020 Jogesh Ghadai. All rights reserved.
//
```

**Imports:**
- Use framework imports only (Cocoa, Foundation, etc.)
- Place imports at the top of the file after the header

**Naming Conventions:**
- Classes: PascalCase (e.g., `ViewController`, `AppDelegate`)
- Variables/Functions: camelCase (e.g., `text_box_outlet`, `executeCommand`)
- IBOutlets: snake_case with `_outlet` suffix (e.g., `text_box_outlet`)
- IBActions: Descriptive names (e.g., `submit`)

**Type Safety:**
- Use explicit types where possible
- Prefer guard statements for optional unwrapping
- Avoid force unwrapping except when absolutely necessary
- Use `let` for immutable values, `var` only when mutation is needed

**Error Handling:**
- Use `guard` statements for early returns
- Use `try-catch` for error propagation
- Print meaningful error messages for debugging

**Code Organization:**
- Use MARK comments to organize code sections
- Place IBOutlets at the top of the class
- Place IBActions after outlets
- Keep helper methods at the bottom

### Python

**Imports:**
- Keep imports minimal and at the top
- Use standard library imports first, then third-party

**Naming Conventions:**
- Classes: PascalCase (e.g., `Sentiment_Analysis`)
- Functions/Variables: snake_case (e.g., `get_sentiment_score`)
- Constants: UPPER_SNAKE_CASE

**Code Structure:**
- Use `if __name__ == "__main__":` guard for script entry point
- Use docstrings for classes and major functions
- Round floating point numbers to 2 decimal places for output

## Architecture Notes

- Swift acts as the UI layer, delegating to Python for sentiment analysis
- Python script is bundled in the app bundle and executed via Process
- Sentiment scores: negative (red), zero (yellow), positive (green)
- Real-time analysis via `controlTextDidChange` delegate method
- On-demand analysis via submit button

## File Structure

```
LiveSentimentAnalysis/
├── AppDelegate.swift          # App lifecycle management
├── ViewController.swift        # Main UI controller
├── sentiment_analysis.py      # Python sentiment analysis backend
├── Info.plist                  # App configuration
└── Assets.xcassets/           # App resources
```

## Development Workflow

1. Modify Swift code for UI/logic changes
2. Modify Python script for sentiment algorithm changes
3. Rebuild via Xcode or xcodebuild
4. Test Python script independently: `python3 sentiment_analysis.py "text"`

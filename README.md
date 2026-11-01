# Image Splitter: a before-and-after slider in SwiftUI

A tutorial-sized SwiftUI app that compares two images with a draggable divider, the kind of "before and after" view used for photo edits. Each image also has its own zoom slider. The same code runs on iPhone, iPad, Mac and Apple Vision Pro.

<img width="182" alt="Image Splitter on iPhone" src="https://github.com/user-attachments/assets/226908c6-c1bc-45ae-b54e-c25abb52d603" />

<img width="1495" alt="Image Splitter on Mac" src="https://github.com/user-attachments/assets/78fb7f92-fdfd-4b2d-9ae0-765c7eb7bd92" />

## What it shows

- **A clip mask driven by a gesture.** The top image is clipped by a custom `Shape` whose width follows a `DragGesture`. The drag runs in a named coordinate space and is held in `@GestureState`, so the divider snaps cleanly when you let go.
- **A divider with its own hit area.** The handle uses a separate `contentShape`, so it is easy to grab without blocking the images. It widens and fades while you drag.
- **Independent zoom.** Two sliders scale each image with `scaleEffect`, so you can compare details at different magnifications.
- **Responsive sizing.** A `GeometryReader` keeps a 3:4 frame and passes the size down to the comparison view.
- **Pinch to zoom.** `MagnificatioTesting.swift` tries the same images with `MagnifyGesture`.

## Requirements

- Xcode 16.4 or later
- iOS 18.5, iPadOS 18.5, macOS 15.5 or visionOS 2.5

## Run it

1. Open `ImageSplitter-tut1.xcodeproj` in Xcode.
2. Choose an iPhone, Mac or Vision Pro destination.
3. Press Run, then drag the white divider.

## Project layout

| File | Purpose |
| --- | --- |
| `ContentView.swift` | Frame, coordinate space and the clip shapes |
| `ImageViews.swift` | The two stacked images, drag gesture, divider and zoom sliders |
| `MagnificatioTesting.swift` | Pinch-to-zoom experiment |

## License

Code: [MIT](LICENSE) © 2025 Jeevanjot Singh Vital. Replace the sample images in the asset catalog before reusing them in your own app.

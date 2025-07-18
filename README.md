# MoSlider
<div align="center">
<img src="https://github.com/user-attachments/assets/1a8eccf4-42fd-4f74-b42e-0c1c264a6787" width="300" alt="Before">
</div>

[![Swift](https://img.shields.io/badge/Swift-5.7-orange.svg)](https://swift.org)
[![iOS](https://img.shields.io/badge/iOS-15.0+-blue.svg)](https://developer.apple.com/ios/)
[![macOS](https://img.shields.io/badge/macOS-12.0+-blue.svg)](https://developer.apple.com/macos/)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![SPM](https://img.shields.io/badge/SPM-compatible-brightgreen.svg)](https://swift.org/package-manager/)

A powerful and flexible SwiftUI component for creating interactive before/after comparison sliders. Perfect for showcasing image transformations, UI state changes, data visualizations, and any visual comparisons with **11 advanced features** and smooth animations.

## ✨ Features

### 🎯 **Core Features**
- 🎨 **Universal Content Support** - Works with any SwiftUI View, not just images
- 🖼️ **Multiple Content Types** - Images, custom views, charts, UI states, and more
- 🌍 **RTL Language Support** - Automatic right-to-left language adaptation
- 📱 **Intuitive Interactions** - Drag the slider or tap anywhere to compare
- ✨ **Smooth Animations** - Natural spring animations and transitions
- 🎯 **Modern SwiftUI** - Built for iOS 15+ with latest SwiftUI features
- 🔄 **Responsive Design** - Adapts to any screen size and orientation
- 🧩 **Simple API** - Clean ViewBuilder syntax for easy integration

### 🚀 **Advanced Features**
- 🎬 **Start Animation** - Eye-catching intro animation that showcases the comparison
- 🎨 **Full Customization** - Colors, sizes, labels, and animations
- 📐 **Orientation Support** - Horizontal and vertical layouts
- 🔄 **Haptic Feedback** - Enhanced user experience with tactile responses
- ♿ **Accessibility** - Complete VoiceOver support with increment/decrement actions
- 🎯 **Drag Sensitivity** - Customizable gesture responsiveness
- 🖱️ **Tap Controls** - Enable/disable tap-to-move functionality
- 📍 **Initial Position** - Set custom starting slider position
- 🎪 **Display Mode** - Static display without user interaction
- 🏷️ **Custom Labels** - Personalize "Before" and "After" text
- 🎭 **Animation Styles** - Choose from various animation types

## 📱 Screenshots

<div align="center">
  <table>
    <tr>
      <td align="center">
        <h3>📱 Before</h3>
        <img src="https://github.com/user-attachments/assets/3a07d86a-95f6-400a-90dc-6840d67db44d" width="200" alt="Before">
      </td>
      <td align="center">
        <h3>📱 After</h3>
        <img src="https://github.com/user-attachments/assets/ca27f7a3-c122-4468-88ba-a500735f6b7f" width="200" alt="After">
      </td>
      <td align="center">
        <h3>👀 Preview</h3>
        <img src="https://github.com/user-attachments/assets/f3eea9c6-4c0e-480a-b89d-ae1b7633268a" width="200" alt="Preview">
      </td>
    </tr>
  </table>
</div>

<div align="center">
  <h3>🎬 Demo</h3>
  <img src="https://github.com/user-attachments/assets/8fa35f1b-07b1-4cf0-87b4-107828ccd798" width="350" alt="MoSlider Demo">
</div>

## 🚀 Installation

### Swift Package Manager

#### Xcode

1. **File → Add Package Dependencies**
2. **Enter URL**: `https://github.com/mkhasson97/MoSlider.git`
3. **Add Package**

#### Package.swift

```swift
dependencies: [
    .package(url: "https://github.com/mkhasson97/MoSlider.git", from: "1.0.0")
]
```

## 💡 Usage

### Basic Example

```swift
import SwiftUI
import MoSlider

struct ContentView: View {
    var body: some View {
        BeforeAfterSlider {
            // Before content
            Rectangle()
                .fill(.red.gradient)
                .overlay(Text("BEFORE").foregroundColor(.white))
        } afterContent: {
            // After content
            Rectangle()
                .fill(.blue.gradient)
                .overlay(Text("AFTER").foregroundColor(.white))
        }
        .frame(height: 300)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}
```

### Image Comparison with Start Animation

```swift
BeforeAfterSlider {
    Image("before_photo")
        .resizable()
        .aspectRatio(contentMode: .fill)
} afterContent: {
    Image("after_photo")
        .resizable()
        .aspectRatio(contentMode: .fill)
}
.showStartAnimation(true)
.sliderColor(.blue)
.customLabels(before: "Original", after: "Enhanced")
.frame(height: 400)
```

### Vertical Orientation

```swift
BeforeAfterSlider {
    Rectangle()
        .fill(.purple.gradient)
        .overlay(Text("TOP").foregroundColor(.white))
} afterContent: {
    Rectangle()
        .fill(.orange.gradient)
        .overlay(Text("BOTTOM").foregroundColor(.white))
}
.orientation(.vertical)
.sliderColor(.yellow)
.sliderWidth(6)
.handleSize(50)
.frame(height: 300)
```

### All Features Combined

```swift
BeforeAfterSlider {
    VStack {
        Image(systemName: "sun.max")
            .font(.system(size: 40))
            .foregroundColor(.yellow)
        Text("Day Mode")
            .font(.title3)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(.yellow.opacity(0.1))
} afterContent: {
    VStack {
        Image(systemName: "moon.stars")
            .font(.system(size: 40))
            .foregroundColor(.blue)
        Text("Night Mode")
            .font(.title3)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(.blue.opacity(0.1))
}
.sliderColor(.purple)
.sliderWidth(4)
.handleSize(55)
.customLabels(before: "☀️ Day", after: "🌙 Night")
.showStartAnimation(true)
.initialPosition(0.2)
.animationStyle(.spring(response: 0.6, dampingFraction: 0.8))
.enableHapticFeedback(true)
.allowTapToMove(true)
.dragSensitivity(1.2)
.frame(height: 250)
```

### Image Convenience Method

```swift
BeforeAfterSlider.withImages(
    beforeImage: Image("original"),
    afterImage: Image("enhanced"),
    showStartAnimation: true
)
.sliderColor(.mint)
.customLabels(before: "Before AI", after: "After AI")
.frame(height: 300)
```

### UI State Comparison

```swift
BeforeAfterSlider {
    // Loading state
    VStack {
        ProgressView()
            .scaleEffect(2)
        Text("Loading...")
            .font(.title2)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(.gray.opacity(0.3))
} afterContent: {
    // Loaded state
    VStack {
        Image(systemName: "checkmark.circle.fill")
            .font(.system(size: 80))
            .foregroundColor(.green)
        Text("Complete!")
            .font(.title2)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(.green.opacity(0.2))
}
.showStartAnimation(true)
.customLabels(before: "Loading", after: "Loaded")
```

## 🛠️ Customization API

### Style Modifiers

| Modifier | Description | Example |
|----------|-------------|---------|
| `.sliderColor(_:)` | Sets slider and handle color | `.sliderColor(.blue)` |
| `.sliderWidth(_:)` | Sets line thickness | `.sliderWidth(4)` |
| `.handleSize(_:)` | Sets handle diameter | `.handleSize(50)` |
| `.customLabels(before:after:)` | Custom label text | `.customLabels(before: "Old", after: "New")` |

### Behavior Modifiers

| Modifier | Description | Example |
|----------|-------------|---------|
| `.showStartAnimation(_:)` | Intro animation | `.showStartAnimation(true)` |
| `.initialPosition(_:)` | Starting position (0-1) | `.initialPosition(0.3)` |
| `.enableHapticFeedback(_:)` | Haptic feedback | `.enableHapticFeedback(true)` |
| `.allowTapToMove(_:)` | Enable tap-to-move | `.allowTapToMove(false)` |
| `.dragSensitivity(_:)` | Gesture sensitivity | `.dragSensitivity(1.5)` |

### Layout Modifiers

| Modifier | Description | Example |
|----------|-------------|---------|
| `.orientation(_:)` | Layout direction | `.orientation(.vertical)` |
| `.animationStyle(_:)` | Animation type | `.animationStyle(.spring())` |

### Special Modes

```swift
// Display only mode (no interaction)
BeforeAfterSlider(noDrag: true) { ... } afterContent: { ... }
    .initialPosition(0.7)

// High sensitivity mode
BeforeAfterSlider { ... } afterContent: { ... }
    .dragSensitivity(2.0)

// No labels mode
BeforeAfterSlider(showLabels: false) { ... } afterContent: { ... }
```

## 🎯 Advanced Use Cases

### Theme Comparison

```swift
BeforeAfterSlider {
    AppPreview()
        .preferredColorScheme(.light)
} afterContent: {
    AppPreview()
        .preferredColorScheme(.dark)
}
.customLabels(before: "Light Theme", after: "Dark Theme")
.showStartAnimation(true)
```

### Data Visualization Comparison

```swift
BeforeAfterSlider {
    BarChart(data: oldData, color: .red)
        .overlay(Text("Q3 2024"), alignment: .topLeading)
} afterContent: {
    BarChart(data: newData, color: .green)
        .overlay(Text("Q4 2024"), alignment: .topLeading)
}
.customLabels(before: "Previous Quarter", after: "Current Quarter")
.sliderColor(.blue)
```

### Performance Visualization

```swift
BeforeAfterSlider {
    LoadingSpinner(slow: true)
        .overlay(
            VStack {
                Text("Slow")
                Text("3.2s")
                    .font(.caption)
            }
            .foregroundColor(.red)
        )
} afterContent: {
    LoadingSpinner(fast: true)
        .overlay(
            VStack {
                Text("Fast")
                Text("0.8s")
                    .font(.caption)
            }
            .foregroundColor(.green)
        )
}
.customLabels(before: "Before Optimization", after: "After Optimization")
.showStartAnimation(true)
```

## ♿ Accessibility

MoSlider includes comprehensive accessibility support:

- **VoiceOver** - Descriptive labels and position announcements
- **Gesture Support** - Increment/decrement actions for VoiceOver users
- **Semantic Markup** - Proper accessibility traits and roles
- **Custom Labels** - Meaningful content descriptions
- **Position Feedback** - Current slider position announcements

## 📱 Platform Support

- **iOS 15.0+**
- **macOS 12.0+**
- **tvOS 15.0+**
- **watchOS 8.0+**
- **Swift 5.7+**
- **Xcode 14.0+**

## 🔧 Technical Features

- **RTL Language Support** - Automatic adaptation for right-to-left languages
- **Smooth Animations** - 60fps performance with optimized rendering
- **Memory Efficient** - Minimal resource usage and smart clipping
- **Gesture Recognition** - Advanced touch handling with customizable sensitivity
- **Responsive Design** - Adapts to any screen size and orientation

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request. For major changes, please open an issue first to discuss what you would like to change.

### Development Setup

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

```
MIT License

Copyright (c) 2025 Mohammad Alhasson

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

## 👨‍💻 Author

**Mohammad Alhasson**

- Website: [mkhasson97.com](https://mkhasson97.com)
- GitHub: [@mkhasson97](https://github.com/mkhasson97)
- X: [@mkhasson97](https://x.com/mkhasson97)

## 🙏 Acknowledgments

- Built with ❤️ using SwiftUI
- Inspired by the need for flexible comparison tools in iOS development
- Thanks to the SwiftUI community for feedback and inspiration

## 📊 Usage Stats

If you're using MoSlider in your project, I'd love to hear about it! Feel free to:

- ⭐ Star this repository
- 🐛 Report issues
- 💡 Suggest new features
- 📢 Share your implementations

---

**Made with ❤️ in Swift** • **11 Advanced Features** • **Production Ready**

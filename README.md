# MoSlider

[![Swift](https://img.shields.io/badge/Swift-5.9-orange.svg)](https://swift.org)
[![iOS](https://img.shields.io/badge/iOS-17.0+-blue.svg)](https://developer.apple.com/ios/)
[![macOS](https://img.shields.io/badge/macOS-14.0+-blue.svg)](https://developer.apple.com/macos/)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![SPM](https://img.shields.io/badge/SPM-compatible-brightgreen.svg)](https://swift.org/package-manager/)

A powerful and flexible SwiftUI component for creating interactive before/after comparison sliders. Perfect for showcasing image transformations, UI state changes, data visualizations, and any visual comparisons.

## ✨ Features

- 🎨 **Universal Content Support** - Works with any SwiftUI View, not just images
- 🖼️ **Multiple Content Types** - Images, custom views, charts, UI states, and more
- 🌍 **RTL Language Support** - Automatic right-to-left language adaptation
- 📱 **Intuitive Interactions** - Drag the slider or tap anywhere to compare
- ✨ **Smooth Animations** - Natural spring animations and transitions
- 🎯 **Modern SwiftUI** - Built for iOS 17+ with latest SwiftUI features
- 🔄 **Responsive Design** - Adapts to any screen size and orientation
- 🧩 **Simple API** - Clean ViewBuilder syntax for easy integration

## 📱 Screenshots

![Before](https://github.com/user-attachments/assets/3a07d86a-95f6-400a-90dc-6840d67db44d)

![After](https://github.com/user-attachments/assets/ca27f7a3-c122-4468-88ba-a500735f6b7f)

![Preview](https://github.com/user-attachments/assets/f3eea9c6-4c0e-480a-b89d-ae1b7633268a)

![Demo] (https://github.com/user-attachments/assets/d3e5c2f7-0d8d-418a-ae74-66e3a13a7323)

## 🚀 Installation

### Swift Package Manager

#### Xcode
1. **File → Add Package Dependencies**
2. **Enter URL**: `https://github.com/mkhasson97/MoSlider.git`
3. **Add Package**

#### Package.swift
```swift
dependencies: [
    .package(url: "https://github.com/yourusername/MoSlider.git", from: "1.0.0")
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

### Image Comparison
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
.frame(height: 400)
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
```

### Data Visualization Comparison
```swift
BeforeAfterSlider {
    BarChart(data: oldData, color: .red)
} afterContent: {
    BarChart(data: newData, color: .green)
}
```

### System Images
```swift
BeforeAfterSlider {
    Image(systemName: "photo")
        .resizable()
        .aspectRatio(contentMode: .fit)
        .foregroundColor(.secondary)
} afterContent: {
    Image(systemName: "photo.fill")
        .resizable()
        .aspectRatio(contentMode: .fit)
        .foregroundColor(.primary)
}
.frame(height: 200)
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
```

### Performance Visualization
```swift
BeforeAfterSlider {
    LoadingSpinner(slow: true)
        .overlay(Text("Slow").foregroundColor(.red))
} afterContent: {
    LoadingSpinner(fast: true)
        .overlay(Text("Fast").foregroundColor(.green))
}
```

### Layout Comparison
```swift
BeforeAfterSlider {
    ListView(items: items)
} afterContent: {
    GridView(items: items)
}
```

## 🛠️ Customization

The slider automatically adapts to your content and provides:

- **Automatic RTL Support** - Works seamlessly with right-to-left languages
- **Responsive Labels** - "Original" and "Processed" labels that fade based on position
- **Smooth Interactions** - Natural drag gestures and tap-to-position
- **Flexible Sizing** - Adapts to any frame size you provide

## 📋 Requirements

- **iOS 17.0+**
- **macOS 14.0+**
- **Swift 5.9+**
- **Xcode 15.0+**

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

**Made with ❤️ in Swift**
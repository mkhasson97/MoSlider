//
//  Extensions.swift
//  MoSlider
//
//  Created by Mohammad Alhasson on 18.07.25.
//

import SwiftUI

#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

// MARK: - Color Extension for Contrast
extension Color {
    /// Returns a contrasting color (black or white) based on the luminance of the current color
    func contrastColor() -> Color {
        // Convert to platform-specific color to get RGB values
        #if canImport(UIKit)
        guard let components = UIColor(self).cgColor.components else {
            return .black
        }
        #elseif canImport(AppKit)
        guard let nsColor = NSColor(self).usingColorSpace(.deviceRGB) else {
            return .black
        }
        let components = [nsColor.redComponent, nsColor.greenComponent, nsColor.blueComponent]
        #endif
        
        let red = components[0]
        let green = components[1]
        let blue = components[2]
        
        // Calculate luminance using the standard formula
        let luminance = 0.299 * red + 0.587 * green + 0.114 * blue
        
        // Return black for light colors, white for dark colors
        return luminance > 0.5 ? .black : .white
    }
}

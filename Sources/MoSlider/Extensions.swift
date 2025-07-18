//
//  Extensions.swift
//  MoSlider
//
//  Created by Mohammad Alhasson on 18.07.25.
//

import SwiftUI

// MARK: - Color Extension for Contrast
extension Color {
    /// Returns a contrasting color (black or white) based on the luminance of the current color
    func contrastColor() -> Color {
        // Convert to UIColor to get RGB values
        let uiColor = UIColor(self)
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        // Calculate luminance using the standard formula
        let luminance = 0.299 * red + 0.587 * green + 0.114 * blue
        
        // Return black for light colors, white for dark colors
        return luminance > 0.5 ? .black : .white
    }
}

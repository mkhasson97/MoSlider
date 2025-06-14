//
//  SliderControl.swift
//  MoSlider
//
//  Created by Mohammad Alhasson on 20.04.25.
//

import SwiftUI

public struct SliderControl: View {
    let position: CGFloat
    let isDragging: Bool
    
    public init(position: CGFloat, isDragging: Bool) {
        self.position = position
        self.isDragging = isDragging
    }
    
    public var body: some View {
        ZStack {
            // Vertical Line
            Rectangle()
                .fill(.white)
                .frame(width: 3)
                .shadow(radius: 2)
            
            // Handle
            Circle()
                .fill(.white)
                .frame(width: isDragging ? 50 : 40, height: isDragging ? 50 : 40)
                .shadow(radius: 3)
                .animation(.spring(response: 0.2), value: isDragging)
            
            // Drag Indicators
            HStack(spacing: 1) {
                Image(systemName: "chevron.left")
                    .foregroundColor(.gray)
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
            .font(.system(size: 14, weight: .bold))
            .opacity(isDragging ? 0.5 : 1)
            .scaleEffect(isDragging ? 1.2 : 1)
            .animation(.spring(response: 0.2), value: isDragging)
        }
    }
}

#Preview {
    SliderControl(position: 0.5, isDragging: true)
}

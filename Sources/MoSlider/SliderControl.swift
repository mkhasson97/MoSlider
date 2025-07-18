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
    let noDrag: Bool
    let sliderColor: Color
    let sliderWidth: CGFloat
    let handleSize: CGFloat
    let orientation: SliderOrientation
    
    public init(
        position: CGFloat,
        isDragging: Bool,
        noDrag: Bool,
        sliderColor: Color = .white,
        sliderWidth: CGFloat = 3,
        handleSize: CGFloat = 40,
        orientation: SliderOrientation = .horizontal
    ) {
        self.position = position
        self.isDragging = isDragging
        self.noDrag = noDrag
        self.sliderColor = sliderColor
        self.sliderWidth = sliderWidth
        self.handleSize = handleSize
        self.orientation = orientation
    }
    
    public var body: some View {
        ZStack {
            
            // Line (Vertical for horizontal slider, Horizontal for vertical slider)
            Rectangle()
                .fill(sliderColor)
                .frame(
                    width: orientation == .horizontal ? sliderWidth : nil,
                    height: orientation == .vertical ? sliderWidth : nil
                )
                .shadow(color: .black.opacity(0.3), radius: 2)
            
            if !noDrag {
                // Handle
                Circle()
                    .fill(sliderColor)
                    .frame(
                        width: isDragging ? handleSize + 10 : handleSize,
                        height: isDragging ? handleSize + 10 : handleSize
                    )
                    .shadow(color: .black.opacity(0.3), radius: 3)
                    .overlay(
                        Circle()
                            .stroke(Color.black.opacity(0.1), lineWidth: 1)
                    )
                
                // Drag Indicators
                dragIndicators
            }
        }
        .animation(.easeInOut(duration: 0.2), value: isDragging)
    }
    
    @ViewBuilder
    private var dragIndicators: some View {
        if orientation == .horizontal {
            HStack(spacing: 1) {
                Image(systemName: "chevron.left")
                    .foregroundColor(sliderColor.contrastColor())
                Image(systemName: "chevron.right")
                    .foregroundColor(sliderColor.contrastColor())
            }
            .font(.system(size: 14, weight: .bold))
            .opacity(isDragging ? 0.5 : 1)
            .scaleEffect(isDragging ? 1.2 : 1)
        } else {
            VStack(spacing: 1) {
                Image(systemName: "chevron.up")
                    .foregroundColor(sliderColor.contrastColor())
                Image(systemName: "chevron.down")
                    .foregroundColor(sliderColor.contrastColor())
            }
            .font(.system(size: 14, weight: .bold))
            .opacity(isDragging ? 0.5 : 1)
            .scaleEffect(isDragging ? 1.2 : 1)
        }
    }
}



#Preview {
    VStack(spacing: 20) {
        // Horizontal controls
        HStack(spacing: 20) {
            SliderControl(
                position: 0.5,
                isDragging: false,
                noDrag: false,
                sliderColor: .white,
                orientation: .horizontal
            )
            
            SliderControl(
                position: 0.5,
                isDragging: true,
                noDrag: false,
                sliderColor: .blue,
                orientation: .horizontal
            )
            
            SliderControl(
                position: 0.5,
                isDragging: false,
                noDrag: false,
                sliderColor: .red,
                sliderWidth: 5,
                handleSize: 50,
                orientation: .horizontal
            )
        }
        .frame(height: 100)
        
        // Vertical controls
        HStack(spacing: 20) {
            SliderControl(
                position: 0.5,
                isDragging: false,
                noDrag: false,
                sliderColor: .white,
                orientation: .vertical
            )
            
            SliderControl(
                position: 0.5,
                isDragging: true,
                noDrag: false,
                sliderColor: .green,
                orientation: .vertical
            )
            
            SliderControl(
                position: 0.5,
                isDragging: false,
                noDrag: false,
                sliderColor: .purple,
                sliderWidth: 5,
                handleSize: 50,
                orientation: .vertical
            )
        }
        .frame(height: 100)
    }
    .padding()
    .background(Color.gray.opacity(0.2))
}

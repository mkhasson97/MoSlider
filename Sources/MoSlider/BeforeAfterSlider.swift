//
//  BeforeAfterSlider.swift
//  MoSlider
//
//  Created by Mohammad Alhasson on 31.03.25.
//

import SwiftUI

public struct BeforeAfterSlider<BeforeContent: View, AfterContent: View>: View {
    let beforeContent: BeforeContent
    let afterContent: AfterContent
    
    @State private var sliderPosition: CGFloat = 0.5
    @State private var isDragging: Bool = false
    
    @Environment(\.layoutDirection) private var layoutDirection
    
    // Generic initializer for any Views
    public init(@ViewBuilder beforeContent: () -> BeforeContent, @ViewBuilder afterContent: () -> AfterContent) {
        self.beforeContent = beforeContent()
        self.afterContent = afterContent()
    }
    
    public var body: some View {
        GeometryReader { geometry in
            let size = geometry.size
            let isRTL = layoutDirection == .rightToLeft
            
            // Always map finger movement directly to position (0...1)
            let effectiveSlider = sliderPosition
            
            ZStack {
                // After content: full
                afterContent
                    .frame(width: size.width, height: size.height)
                    .clipped()
                
                // Before content: clipped
                beforeContent
                    .frame(width: size.width, height: size.height)
                    .clipped()
                    .mask(
                        Rectangle()
                            .frame(width: isRTL ? (1 - effectiveSlider) * size.width : effectiveSlider * size.width)
                            .alignmentGuide(.leading, computeValue: { _ in 0 })
                            .position(x: (isRTL ? (1 - effectiveSlider) * size.width : effectiveSlider * size.width) / 2, y: size.height / 2)
                    )
                
                // Slider control
                SliderControl(position: effectiveSlider, isDragging: isDragging)
                    .frame(height: size.height)
                    .offset(x: (effectiveSlider - 0.5) * size.width * (isRTL ? -1 : 1))
                
                // Labels
                if !isDragging {
                    VStack {
                        HStack {
                            // BEFORE
                            Text("Original")
                                .font(.caption)
                                .padding(6)
                                .background(Color.black.opacity(0.6))
                                .foregroundColor(.white)
                                .cornerRadius(4)
                                .opacity(effectiveSlider > 0.1 ? 1 : 0)
                                .offset(x: (isRTL ? 1 : -1) * size.width * 0.3)

                            Spacer()

                            // AFTER
                            Text("Processed")
                                .font(.caption)
                                .padding(6)
                                .background(Color.black.opacity(0.6))
                                .foregroundColor(.white)
                                .cornerRadius(4)
                                .opacity(effectiveSlider < 0.9 ? 1 : 0)
                                .offset(x: (isRTL ? -1 : 1) * size.width * 0.3)
                        }
                        .frame(width: size.width)
                        .padding(.top, 8)

                        Spacer()
                    }
                    .frame(width: size.width, height: size.height)
                    .animation(.easeInOut(duration: 0.2), value: effectiveSlider)
                }

            }
            .frame(width: size.width, height: size.height)
            .clipped()
            .contentShape(Rectangle())
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { value in
                        isDragging = true
                        let pos = value.location.x / size.width
                        sliderPosition = min(max(pos, 0), 1)
                    }
                    .onEnded { _ in
                        isDragging = false
                    }
            )
            .onTapGesture { location in
                let pos = location.x / size.width
                withAnimation(.spring()) {
                    sliderPosition = min(max(pos, 0), 1)
                }
            }
        }
    }
}

#Preview {
    BeforeAfterSlider {
        Rectangle()
            .fill(.red.gradient)
            .overlay(
                Text("BEFORE")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            )
    } afterContent: {
        Rectangle()
            .fill(.blue.gradient)
            .overlay(
                Text("AFTER")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            )
    }
}

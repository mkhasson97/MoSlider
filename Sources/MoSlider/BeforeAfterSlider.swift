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
    let showLabels: Bool
    let noDrag: Bool
    let sliderColor: Color
    let sliderWidth: CGFloat
    let handleSize: CGFloat
    let beforeLabel: String
    let afterLabel: String
    let animationStyle: Animation
    let initialPosition: CGFloat
    let orientation: SliderOrientation
    let allowTapToMove: Bool
    let dragSensitivity: CGFloat
    let enableHapticFeedback: Bool
    let showStartAnimation: Bool
    
    @State private var sliderPosition: CGFloat = 0.5
    @State private var isDragging: Bool = false
    @State private var hasPlayedStartAnimation: Bool = false
    
    @Environment(\.layoutDirection) private var layoutDirection
    
    // Generic initializer for any Views
    public init(
        showLabels: Bool = true,
        noDrag: Bool = false,
        sliderColor: Color = .white,
        sliderWidth: CGFloat = 3,
        handleSize: CGFloat = 40,
        beforeLabel: String = "Before",
        afterLabel: String = "After",
        animationStyle: Animation = .easeInOut(duration: 0.3),
        initialPosition: CGFloat = 0.5,
        orientation: SliderOrientation = .horizontal,
        allowTapToMove: Bool = true,
        dragSensitivity: CGFloat = 1.0,
        enableHapticFeedback: Bool = true,
        showStartAnimation: Bool = false,
        @ViewBuilder beforeContent: () -> BeforeContent,
        @ViewBuilder afterContent: () -> AfterContent
    ) {
        self.showLabels = showLabels
        self.noDrag = noDrag
        self.sliderColor = sliderColor
        self.sliderWidth = sliderWidth
        self.handleSize = handleSize
        self.beforeLabel = beforeLabel
        self.afterLabel = afterLabel
        self.animationStyle = animationStyle
        self.initialPosition = max(0, min(1, initialPosition))
        self.orientation = orientation
        self.allowTapToMove = allowTapToMove
        self.dragSensitivity = dragSensitivity
        self.enableHapticFeedback = enableHapticFeedback
        self.showStartAnimation = showStartAnimation
        self.beforeContent = beforeContent()
        self.afterContent = afterContent()
    }
    
    public var body: some View {
        GeometryReader { geometry in
            let size = geometry.size
            let isRTL = layoutDirection == .rightToLeft
            let isVertical = orientation == .vertical
            
            // Always map finger movement directly to position (0...1)
            let effectiveSlider = sliderPosition
            
            ZStack {
                if isVertical {
                    verticalSliderView(size: size, effectiveSlider: effectiveSlider)
                } else {
                    horizontalSliderView(size: size, isRTL: isRTL, effectiveSlider: effectiveSlider)
                }
            }
            .frame(width: size.width, height: size.height)
            .clipped()
            .contentShape(Rectangle())
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { value in
                        guard !noDrag else { return }
                        isDragging = true
                        
                        let pos = isVertical ?
                            value.location.y / size.height :
                            value.location.x / size.width
                        
                        let adjustedPos = pos * dragSensitivity
                        sliderPosition = min(max(adjustedPos, 0), 1)
                        
                        // Haptic feedback
                        if enableHapticFeedback {
                            let impactFeedback = UIImpactFeedbackGenerator(style: .light)
                            impactFeedback.impactOccurred()
                        }
                    }
                    .onEnded { _ in
                        isDragging = false
                    }
            )
            .onTapGesture { location in
                guard allowTapToMove && !noDrag else { return }
                
                let pos = isVertical ?
                    location.y / size.height :
                    location.x / size.width
                
                withAnimation(animationStyle) {
                    sliderPosition = min(max(pos, 0), 1)
                }
            }
            .allowsHitTesting(!noDrag)
        }
        .accessibilityLabel("\(beforeLabel) \(afterLabel) comparison slider")
        .accessibilityValue("Position \(Int(sliderPosition * 100)) percent")
        .accessibilityAdjustableAction { direction in
            withAnimation(animationStyle) {
                switch direction {
                case .increment:
                    sliderPosition = min(sliderPosition + 0.1, 1.0)
                case .decrement:
                    sliderPosition = max(sliderPosition - 0.1, 0.0)
                default:
                    break
                }
            }
        }
        .onAppear {
            sliderPosition = initialPosition
            
            if showStartAnimation && !hasPlayedStartAnimation {
                hasPlayedStartAnimation = true
                playStartAnimation()
            }
        }
    }
    
    @ViewBuilder
    private func horizontalSliderView(size: CGSize, isRTL: Bool, effectiveSlider: CGFloat) -> some View {
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
        SliderControl(
            position: effectiveSlider,
            isDragging: isDragging,
            noDrag: noDrag,
            sliderColor: sliderColor,
            sliderWidth: sliderWidth,
            handleSize: handleSize,
            orientation: orientation
        )
        .frame(height: size.height)
        .offset(x: (effectiveSlider - 0.5) * size.width * (isRTL ? -1 : 1))
        
        // Labels
        if !isDragging && showLabels {
            horizontalLabels(size: size, effectiveSlider: effectiveSlider)
        }
    }
    
    @ViewBuilder
    private func verticalSliderView(size: CGSize, effectiveSlider: CGFloat) -> some View {
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
                    .frame(width: size.width, height: effectiveSlider * size.height)
                    .alignmentGuide(.top, computeValue: { _ in 0 })
                    .position(x: size.width / 2, y: (effectiveSlider * size.height) / 2)
            )
        
        // Slider control
        SliderControl(
            position: effectiveSlider,
            isDragging: isDragging,
            noDrag: noDrag,
            sliderColor: sliderColor,
            sliderWidth: sliderWidth,
            handleSize: handleSize,
            orientation: orientation
        )
        .frame(width: size.width)
        .offset(y: (effectiveSlider - 0.5) * size.height)
        
        // Labels
        if !isDragging && showLabels {
            verticalLabels(size: size, effectiveSlider: effectiveSlider)
        }
    }
    
    @ViewBuilder
    private func horizontalLabels(size: CGSize, effectiveSlider: CGFloat) -> some View {
        VStack {
            HStack {
                // BEFORE
                Text(beforeLabel)
                    .font(.caption)
                    .padding(6)
                    .background(Color.black.opacity(0.6))
                    .foregroundColor(.white)
                    .cornerRadius(4)
                    .opacity(effectiveSlider > 0.1 ? 1 : 0)
                    .padding(2)
                
                Spacer()
                
                // AFTER
                Text(afterLabel)
                    .font(.caption)
                    .padding(6)
                    .background(Color.black.opacity(0.6))
                    .foregroundColor(.white)
                    .cornerRadius(4)
                    .opacity(effectiveSlider < 0.9 ? 1 : 0)
                    .padding(2)
            }
            .frame(width: size.width)
            .padding(2)
            
            Spacer()
        }
        .frame(width: size.width, height: size.height)
    }
    
    @ViewBuilder
    private func verticalLabels(size: CGSize, effectiveSlider: CGFloat) -> some View {
        VStack {
            // BEFORE
            Text(beforeLabel)
                .font(.caption)
                .padding(6)
                .background(Color.black.opacity(0.6))
                .foregroundColor(.white)
                .cornerRadius(4)
                .opacity(effectiveSlider > 0.1 ? 1 : 0)
                .padding(2)
            
            Spacer()
            
            // AFTER
            Text(afterLabel)
                .font(.caption)
                .padding(6)
                .background(Color.black.opacity(0.6))
                .foregroundColor(.white)
                .cornerRadius(4)
                .opacity(effectiveSlider < 0.9 ? 1 : 0)
                .padding(2)
        }
        .frame(width: size.width, height: size.height)
    }
    
    private func playStartAnimation() {
        let sequence = [0.2, 0.8, 0.5] // Go left, then right, then center
        
        for (index, position) in sequence.enumerated() {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * 0.8) {
                withAnimation(.easeInOut(duration: 0.6)) {
                    sliderPosition = position
                }
            }
        }
    }
}

// MARK: - View Modifiers
extension BeforeAfterSlider {
    /// Sets the slider color
    public func sliderColor(_ color: Color) -> BeforeAfterSlider {
        BeforeAfterSlider(
            showLabels: showLabels,
            noDrag: noDrag,
            sliderColor: color,
            sliderWidth: sliderWidth,
            handleSize: handleSize,
            beforeLabel: beforeLabel,
            afterLabel: afterLabel,
            animationStyle: animationStyle,
            initialPosition: initialPosition,
            orientation: orientation,
            allowTapToMove: allowTapToMove,
            dragSensitivity: dragSensitivity,
            enableHapticFeedback: enableHapticFeedback,
            showStartAnimation: showStartAnimation,
            beforeContent: { beforeContent },
            afterContent: { afterContent }
        )
    }
    
    /// Sets the slider line width
    public func sliderWidth(_ width: CGFloat) -> BeforeAfterSlider {
        BeforeAfterSlider(
            showLabels: showLabels,
            noDrag: noDrag,
            sliderColor: sliderColor,
            sliderWidth: width,
            handleSize: handleSize,
            beforeLabel: beforeLabel,
            afterLabel: afterLabel,
            animationStyle: animationStyle,
            initialPosition: initialPosition,
            orientation: orientation,
            allowTapToMove: allowTapToMove,
            dragSensitivity: dragSensitivity,
            enableHapticFeedback: enableHapticFeedback,
            showStartAnimation: showStartAnimation,
            beforeContent: { beforeContent },
            afterContent: { afterContent }
        )
    }
    
    /// Sets the handle size
    public func handleSize(_ size: CGFloat) -> BeforeAfterSlider {
        BeforeAfterSlider(
            showLabels: showLabels,
            noDrag: noDrag,
            sliderColor: sliderColor,
            sliderWidth: sliderWidth,
            handleSize: size,
            beforeLabel: beforeLabel,
            afterLabel: afterLabel,
            animationStyle: animationStyle,
            initialPosition: initialPosition,
            orientation: orientation,
            allowTapToMove: allowTapToMove,
            dragSensitivity: dragSensitivity,
            enableHapticFeedback: enableHapticFeedback,
            showStartAnimation: showStartAnimation,
            beforeContent: { beforeContent },
            afterContent: { afterContent }
        )
    }
    
    /// Sets custom labels
    public func customLabels(before: String, after: String) -> BeforeAfterSlider {
        BeforeAfterSlider(
            showLabels: showLabels,
            noDrag: noDrag,
            sliderColor: sliderColor,
            sliderWidth: sliderWidth,
            handleSize: handleSize,
            beforeLabel: before,
            afterLabel: after,
            animationStyle: animationStyle,
            initialPosition: initialPosition,
            orientation: orientation,
            allowTapToMove: allowTapToMove,
            dragSensitivity: dragSensitivity,
            enableHapticFeedback: enableHapticFeedback,
            showStartAnimation: showStartAnimation,
            beforeContent: { beforeContent },
            afterContent: { afterContent }
        )
    }
    
    /// Sets animation style
    public func animationStyle(_ animation: Animation) -> BeforeAfterSlider {
        BeforeAfterSlider(
            showLabels: showLabels,
            noDrag: noDrag,
            sliderColor: sliderColor,
            sliderWidth: sliderWidth,
            handleSize: handleSize,
            beforeLabel: beforeLabel,
            afterLabel: afterLabel,
            animationStyle: animation,
            initialPosition: initialPosition,
            orientation: orientation,
            allowTapToMove: allowTapToMove,
            dragSensitivity: dragSensitivity,
            enableHapticFeedback: enableHapticFeedback,
            showStartAnimation: showStartAnimation,
            beforeContent: { beforeContent },
            afterContent: { afterContent }
        )
    }
    
    /// Sets initial position
    public func initialPosition(_ position: CGFloat) -> BeforeAfterSlider {
        BeforeAfterSlider(
            showLabels: showLabels,
            noDrag: noDrag,
            sliderColor: sliderColor,
            sliderWidth: sliderWidth,
            handleSize: handleSize,
            beforeLabel: beforeLabel,
            afterLabel: afterLabel,
            animationStyle: animationStyle,
            initialPosition: position,
            orientation: orientation,
            allowTapToMove: allowTapToMove,
            dragSensitivity: dragSensitivity,
            enableHapticFeedback: enableHapticFeedback,
            showStartAnimation: showStartAnimation,
            beforeContent: { beforeContent },
            afterContent: { afterContent }
        )
    }
    
    /// Sets orientation
    public func orientation(_ orientation: SliderOrientation) -> BeforeAfterSlider {
        BeforeAfterSlider(
            showLabels: showLabels,
            noDrag: noDrag,
            sliderColor: sliderColor,
            sliderWidth: sliderWidth,
            handleSize: handleSize,
            beforeLabel: beforeLabel,
            afterLabel: afterLabel,
            animationStyle: animationStyle,
            initialPosition: initialPosition,
            orientation: orientation,
            allowTapToMove: allowTapToMove,
            dragSensitivity: dragSensitivity,
            enableHapticFeedback: enableHapticFeedback,
            showStartAnimation: showStartAnimation,
            beforeContent: { beforeContent },
            afterContent: { afterContent }
        )
    }
    
    /// Sets whether tap to move is allowed
    public func allowTapToMove(_ enabled: Bool) -> BeforeAfterSlider {
        BeforeAfterSlider(
            showLabels: showLabels,
            noDrag: noDrag,
            sliderColor: sliderColor,
            sliderWidth: sliderWidth,
            handleSize: handleSize,
            beforeLabel: beforeLabel,
            afterLabel: afterLabel,
            animationStyle: animationStyle,
            initialPosition: initialPosition,
            orientation: orientation,
            allowTapToMove: enabled,
            dragSensitivity: dragSensitivity,
            enableHapticFeedback: enableHapticFeedback,
            showStartAnimation: showStartAnimation,
            beforeContent: { beforeContent },
            afterContent: { afterContent }
        )
    }
    
    /// Sets drag sensitivity
    public func dragSensitivity(_ sensitivity: CGFloat) -> BeforeAfterSlider {
        BeforeAfterSlider(
            showLabels: showLabels,
            noDrag: noDrag,
            sliderColor: sliderColor,
            sliderWidth: sliderWidth,
            handleSize: handleSize,
            beforeLabel: beforeLabel,
            afterLabel: afterLabel,
            animationStyle: animationStyle,
            initialPosition: initialPosition,
            orientation: orientation,
            allowTapToMove: allowTapToMove,
            dragSensitivity: sensitivity,
            enableHapticFeedback: enableHapticFeedback,
            showStartAnimation: showStartAnimation,
            beforeContent: { beforeContent },
            afterContent: { afterContent }
        )
    }
    
    /// Sets haptic feedback
    public func enableHapticFeedback(_ enabled: Bool) -> BeforeAfterSlider {
        BeforeAfterSlider(
            showLabels: showLabels,
            noDrag: noDrag,
            sliderColor: sliderColor,
            sliderWidth: sliderWidth,
            handleSize: handleSize,
            beforeLabel: beforeLabel,
            afterLabel: afterLabel,
            animationStyle: animationStyle,
            initialPosition: initialPosition,
            orientation: orientation,
            allowTapToMove: allowTapToMove,
            dragSensitivity: dragSensitivity,
            enableHapticFeedback: enabled,
            showStartAnimation: showStartAnimation,
            beforeContent: { beforeContent },
            afterContent: { afterContent }
        )
    }
    
    /// Sets start animation
    public func showStartAnimation(_ enabled: Bool) -> BeforeAfterSlider {
        BeforeAfterSlider(
            showLabels: showLabels,
            noDrag: noDrag,
            sliderColor: sliderColor,
            sliderWidth: sliderWidth,
            handleSize: handleSize,
            beforeLabel: beforeLabel,
            afterLabel: afterLabel,
            animationStyle: animationStyle,
            initialPosition: initialPosition,
            orientation: orientation,
            allowTapToMove: allowTapToMove,
            dragSensitivity: dragSensitivity,
            enableHapticFeedback: enableHapticFeedback,
            showStartAnimation: enabled,
            beforeContent: { beforeContent },
            afterContent: { afterContent }
        )
    }
}

// MARK: - Image Convenience Functions
extension BeforeAfterSlider where BeforeContent == Image, AfterContent == Image {
    /// Creates a BeforeAfterSlider with images
    public static func withImages(
        beforeImage: Image,
        afterImage: Image,
        showLabels: Bool = true,
        noDrag: Bool = false,
        sliderColor: Color = .white,
        sliderWidth: CGFloat = 3,
        handleSize: CGFloat = 40,
        beforeLabel: String = "Before",
        afterLabel: String = "After",
        animationStyle: Animation = .easeInOut(duration: 0.3),
        initialPosition: CGFloat = 0.5,
        orientation: SliderOrientation = .horizontal,
        allowTapToMove: Bool = true,
        dragSensitivity: CGFloat = 1.0,
        enableHapticFeedback: Bool = true,
        showStartAnimation: Bool = false
    ) -> BeforeAfterSlider<Image, Image> {
        BeforeAfterSlider<Image, Image>(
            showLabels: showLabels,
            noDrag: noDrag,
            sliderColor: sliderColor,
            sliderWidth: sliderWidth,
            handleSize: handleSize,
            beforeLabel: beforeLabel,
            afterLabel: afterLabel,
            animationStyle: animationStyle,
            initialPosition: initialPosition,
            orientation: orientation,
            allowTapToMove: allowTapToMove,
            dragSensitivity: dragSensitivity,
            enableHapticFeedback: enableHapticFeedback,
            showStartAnimation: showStartAnimation,
            beforeContent: { beforeImage },
            afterContent: { afterImage }
        )
    }
}

#Preview {
    VStack(spacing: 20) {
        // Horizontal with start animation
        BeforeAfterSlider(showLabels: true) {
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
        .sliderColor(.white)
        .sliderWidth(2)
        .handleSize(30)
        .showStartAnimation(true)
        .customLabels(before: "Old", after: "New")
        .frame(height: 200)
        
        // Vertical orientation
        BeforeAfterSlider(showLabels: true) {
            Rectangle()
                .fill(.green.gradient)
                .overlay(
                    Text("TOP")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                )
        } afterContent: {
            Rectangle()
                .fill(.purple.gradient)
                .overlay(
                    Text("BOTTOM")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                )
        }
        .orientation(.vertical)
        .sliderColor(.orange)
        .frame(height: 200)
        
        // Using static method for images
        BeforeAfterSlider.withImages(
            beforeImage: Image(systemName: "photo"),
            afterImage: Image(systemName: "photo.fill"),
            showStartAnimation: true
        )
        .sliderColor(.mint)
        .frame(height: 150)
    }
    .padding()
}

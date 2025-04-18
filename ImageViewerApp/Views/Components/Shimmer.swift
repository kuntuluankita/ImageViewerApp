//
//  Shimmer.swift
//  ImageViewerApp
//
//  Created by Kuntulu Ankita on 18/04/25.
//

import SwiftUI

struct Shimmer: ViewModifier {
    @State private var phase: CGFloat = -300

    func body(content: Content) -> some View {
        content
            .overlay(
                shimmerGradient
                    .rotationEffect(.degrees(20))
                    .offset(x: phase)
                    .blendMode(.plusLighter)
            )
            .mask(content)
            .onAppear {
                withAnimation(.linear(duration: 0.9).repeatForever(autoreverses: false)) {
                    phase = 300
                }
            }
    }

    private var shimmerGradient: LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: [
                .gray.opacity(0.3),
                .gray.opacity(0.1),
                .gray.opacity(0.3)
            ]),
            startPoint: .leading,
            endPoint: .trailing
        )
    }
}

extension View {
    func shimmer() -> some View {
        self.modifier(Shimmer())
    }
}

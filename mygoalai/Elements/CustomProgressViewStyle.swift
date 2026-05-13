//
//  CustomProgressViewStyle.swift
//  mygoalai
//
//  Created by Alexander Orlov on 27.10.2025.
//

import SwiftUI
import Combine

struct CustomProgressViewStyle: ProgressViewStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .leading) {
            Text((configuration.fractionCompleted ?? 0.0 < 1.0) ? "\(Int((configuration.fractionCompleted ?? 0) * 100))% из 100%" : "Цель достигнута!")
                .font(.system(.footnote, design: .default, weight: .medium))
                .foregroundStyle(Color.black)
            if configuration.fractionCompleted ?? 0.0 < 1.0 {
                ProgressView(value: configuration.fractionCompleted)
                    .progressViewStyle(.linear)
                    .tint(generateColor(configuration.fractionCompleted ?? 0.0))
            }
        }
    }
    
    func generateColor(_ progress: CGFloat) -> Color {
        switch (progress) {
            case 0..<0.5:
            return .red
        case 0.5..<0.9:
            return .orange
        default:
            return .green
        }
    }
}

//
//  TopCreateView.swift
//  mygoalai
//
//  Created by Alexander Orlov on 27.10.2025.
//

import SwiftUI
import Combine
import SafeSFSymbols

struct TopCreateView: View {
    @StateObject var viewModel: GoalCreateViewModel
    @State var title: String = ""
    @FocusState private var isFocused: Bool
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        HStack(spacing: 0) {
            TextField("Новая цель", text: $title, axis: .vertical)
                .font(.system(.title2, weight: .bold))
                .foregroundStyle(Color.white)
                .submitLabel(.done)
                .lineLimit(1...)
                .focused($isFocused)
            if isFocused {
                Image(.checkmark.circle)
                    .resizable()
                    .renderingMode(.template)
                    .tint(Color.green)
                    .frame(width: 25, height: 25)
                    .onTapGesture {
                        isFocused = false
                        viewModel.changeTitle(title)
                    }
            } else {
                Image(.xmark.circleFill)
                    .resizable()
                    .renderingMode(.template)
                    .foregroundStyle(Color.white)
                    .frame(width: 25, height: 25)
                    .onTapGesture {
                        dismiss.callAsFunction()
                    }
            }
//            Text(title)
//                .font(.system(.title2, weight: .bold))
//                .foregroundStyle(Color.white)
//            Spacer()
        }
        .padding(.leading, 16)
        .padding(.trailing, 16)
        .background(Color.green)
        .onAppear {
            title = viewModel.goal?.title ?? ""
        }
    }
}

#Preview {
    TopCreateView(viewModel: .init(nil))
}

//
//  TopInfoView.swift
//  mygoalai
//
//  Created by Alexander Orlov on 29.10.2025.
//


import SwiftUI
import Combine
import SafeSFSymbols
struct TopInfoView: View {
    @ObservedObject var viewModel: GoalInfoViewModel
    @State var title: String = ""
    @FocusState private var isFocused: Bool
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        HStack(spacing: 0) {
            if !isFocused {
                withAnimation {
                    Image(.arrow.left)
                        .resizable()
                        .renderingMode(.template)
                        .foregroundStyle(Color.white)
                        .frame(width: 25, height: 25)
                        .onTapGesture {
                            dismiss.callAsFunction()
                        }
                        .padding(.trailing, 10)
                }
            }
            TextField("Новая цель", text: $title, axis: .vertical)
                .font(.system(.title2, weight: .bold))
                .foregroundStyle(Color.white)
                .submitLabel(.done)
                .lineLimit(1...)
                .focused($isFocused)
            if isFocused {
                withAnimation {
                    Image(.checkmark.circle)
                        .resizable()
                        .renderingMode(.template)
                        .foregroundStyle(Color.white)
                        .frame(width: 25, height: 25)
                        .onTapGesture {
                            isFocused = false
                        }
                }
            }
        }
        .padding(.leading, 16)
        .padding(.trailing, 16)
        .background(Color.green)
        .animation(.easeIn(duration: 0.15), value: isFocused)
        .onAppear {
            title = viewModel.goal?.title ?? ""
        }
    }
}

#Preview {
    TopInfoView(viewModel: .init(.init(title: "Накопить на машину")))
}

//
//  GoalCreateRowView.swift
//  mygoalai
//
//  Created by Alexander Orlov on 27.10.2025.
//

import SwiftUI
import Combine
import SafeSFSymbols

struct GoalCreateRowView: View {
    @StateObject var viewModel: GoalCreateViewModel
    @State var item: GoalSteps = .init()
    @State private var text: String = ""
    @State private var isOn: Bool = false
    @FocusState private var isFocused: Bool
    
    var striker: AttributedString {
        var result = AttributedString(text)
        result.font = .body
        result.strikethroughStyle = .single
        return result
    }
    
    var body: some View {
        VStack {
            HStack {
                if item.isTemplate && text.isEmpty {
                    Image(.plus)
                        .renderingMode(.template)
                        .resizable()
                        .foregroundStyle(Color.black)
                        .frame(width: 25, height: 25)
                } else {
                    Button {
                        item.isCompleted.toggle()
                        viewModel.changeStep(item)
                    } label: {
                        withAnimation {
                            Rectangle()
                                .fill(Color.clear)
                                .border(Color.black, width: 2)
                                .clipShape(.rect(cornerRadius: 3))
                                .frame(width: 25, height: 25)
                                .overlay {
                                    if item.isCompleted {
                                        Image(.checkmark)
                                            .renderingMode(.template)
                                            .foregroundStyle(Color.black)
                                    }
                                }
                        }
                    }
                    .frame(width: 25, height: 25)
                }
                TextField("", text: $text, prompt: Text("Создать цель").foregroundColor(Color.black.opacity(0.6)), axis: .vertical)
                    .foregroundStyle(Color.black)
                    .font(.system(size: 15, weight: .regular, design: .default))
                    .submitLabel(.done)
                    .lineLimit(1...)
                    .focused($isFocused)
                    .disabled(item.isCompleted)
                if !text.isEmpty && (item.isTemplate || isFocused) {
                    Image(.checkmark.circle)
                        .resizable()
                        .renderingMode(.template)
                        .foregroundStyle(Color.black)
                        .frame(width: 25, height: 25)
                        .onTapGesture {
                            if item.isTemplate {
                                item.title = text
                                item.isCompleted = false
                                item.isTemplate = false
                                viewModel.addStep(item)
                            } else {
                                item.title = text
                                viewModel.changeStep(item)
                                isFocused = false
                                return
                            }
                            text = ""
                            isFocused = false
                            item = .init(isTemplate: true)
                        }
                }
            }
            .onAppear {
                text = item.title ?? ""
            }
        }
        .animation(.default, value: item.isCompleted)
        .padding()
        .background(item.isCompleted ? Color.green.opacity(0.4) : Color.gray.opacity(0.4))
        .clipShape(.rect(cornerRadius: 10))
    }
}

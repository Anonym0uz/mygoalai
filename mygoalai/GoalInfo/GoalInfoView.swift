//
//  GoalInfoView.swift
//  mygoalai
//
//  Created by Alexander Orlov on 23.10.2025.
//

import SwiftUI
import Combine
import SafeSFSymbols

struct GoalInfoView: View {
    @StateObject var viewModel: GoalInfoViewModel = .init(nil)
    @Binding var path: NavigationPath
    
    var body: some View {
//        NavigationStack(path: $path) {
            ZStack {
                Color.white.ignoresSafeArea()
                VStack {
                    TopInfoView(viewModel: viewModel)
                        .frame(height: 55)
                        .background(Color.green)
                    withAnimation {
                        List {
                            ForEach(viewModel.goal?.steps ?? [], id: \.id) { step in
                                GoalAppendRowView(viewModel: viewModel, item: step)
                                    .listRowBackground(Color.white)
                                    .listRowSeparator(.hidden)
                                    .listRowInsets(.init(top: 10, leading: 10, bottom: 0, trailing: 10))
                                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                        Button(role: .destructive) {
                                            self.viewModel.removeAction(step)
                                        } label: {
                                            Image(.trash)
                                                .renderingMode(.template)
                                                .resizable()
                                                .foregroundStyle(Color.white)
                                                .frame(width: 40, height: 40)
                                        }
                                    }
//                                    .swipeActions(edge: .leading, allowsFullSwipe: true) {
//                                        Button(role: .cancel) {
//                                            var newStep: GoalSteps = step
//                                            newStep.isCompleted = !newStep.isCompleted
//                                            self.viewModel.changeStep(newStep)
//                                        } label: {
//                                            Image(.checkmark.circle)
//                                                .renderingMode(.template)
//                                                .resizable()
//                                                .foregroundStyle(Color.white)
//                                                .frame(width: 40, height: 40)
//                                        }
//                                        .background(Color.blue)
//                                    }
                            }
                            GoalAppendRowView(viewModel: viewModel, item: .init(isTemplate: true))
                                .listRowBackground(Color.white)
                                .listRowSeparator(.hidden)
                                .listRowInsets(.init(top: 10, leading: 10, bottom: 0, trailing: 10))
                        }
                        .onReceive(Just(viewModel.goal?.steps), perform: { _ in
                        })
                        .listStyle(.plain)
                        .environment(\.defaultMinListRowHeight, 55)
                    }
                }
            }
            .animation(.easeIn, value: viewModel.goal?.steps ?? [])
            .navigationBarBackButtonHidden()
//        }
    }
}

#Preview {
    GoalInfoView(viewModel: .init(Goal(title: "test",
                                       description: "test",
                                       steps: [
                                        .init(title: "test", isCompleted: false),
                                        .init(title: "test2", isCompleted: false),
                                        .init(title: "test3", isCompleted: false),
                                        .init(title: "test4", isCompleted: false),
                                        .init(title: "test5", isCompleted: false),
                                        .init(title: "test6", isCompleted: false)
                                       ])), path: Binding.constant(NavigationPath()))
}

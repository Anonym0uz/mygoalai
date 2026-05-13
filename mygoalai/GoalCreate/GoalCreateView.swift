//
//  GoalCreateView.swift
//  mygoalai
//
//  Created by Alexander Orlov on 23.10.2025.
//

import SwiftUI
import Combine
import SafeSFSymbols

struct GoalCreateView: View {
    @StateObject var viewModel: GoalCreateViewModel = .init(nil)
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            VStack {
                TopCreateView(viewModel: viewModel)
                    .frame(height: 55)
                    .background(Color.green)
                withAnimation {
                    List {
                        ForEach(viewModel.goal?.steps ?? [], id: \.id) { step in
                            GoalCreateRowView(viewModel: viewModel, item: step)
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
                        }
                        GoalCreateRowView(viewModel: viewModel, item: .init(isTemplate: true))
                            .listRowBackground(Color.white)
                            .listRowSeparator(.hidden)
                            .listRowInsets(.init(top: 10, leading: 10, bottom: 0, trailing: 10))
                    }
                    .listStyle(.plain)
                    .environment(\.defaultMinListRowHeight, 55)
                }
            }
        }
        .animation(.easeIn, value: viewModel.goal?.steps ?? [])
    }
}

#Preview {
    GoalCreateView(viewModel: .init(nil))
}

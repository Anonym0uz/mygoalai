//
//  GoalsListView..swift
//  mygoalai
//
//  Created by Alexander Orlov on 21.10.2025.
//

import SwiftUI
import Combine
import Foundation
import SafeSFSymbols

struct GoalsListView: View {
    @State var showAdd: Bool = false
    @State var showInfo: Bool = false
    @ObservedObject var viewModel: GoalsListViewModel = .init()
    @Environment(\.dismiss) var dismiss
    @State private var currentGoal: Goal?
    @State private var path: NavigationPath = .init()
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                Color.white.ignoresSafeArea()
                VStack(spacing: 0) {
                    TopView(title: "Мои списки")
                        .frame(height: 50)
                        .background(Color.green)
                    ScrollViewReader { reader in
                        List {
                            ForEach(viewModel.goals, id: \.self) { goal in
                                GoalRowView(item: goal)
                                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                                    .listRowSeparator(.hidden)
                                    .listRowBackground(Color.white)
                                    .onTapGesture {
//                                        currentGoal = goal
//                                        print(currentGoal)
//                                        showAdd.toggle()
                                        
                                        path.append(goal)
                                    }
                                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                        Button(role: .destructive) {
                                            self.viewModel.removeAction(goal)
                                        } label: {
//                                            Text("Delete")
                                            Image(.trash)
                                                .renderingMode(.template)
                                                .resizable()
                                                .foregroundStyle(Color.white)
                                                .frame(width: 40, height: 40)
                                        }
                                    }
                            }
                            GoalAddRowView()
                                .padding()
                                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                                .listRowSeparator(.hidden)
                                .listRowBackground(Color.white)
                                .onTapGesture {
                                    currentGoal = nil
                                    showAdd.toggle()
                                }
                        }
                        .onReceive(Just(viewModel.goals), perform: { _ in
                            
                        })
                        .listStyle(.plain)
                        .environment(\.defaultMinListRowHeight, 55)
                    }
                    .padding()
                }
                .fullScreenCover(isPresented: $showAdd) {
                    viewModel.getData()
                } content: {
//                    print(currentGoal)
                    return GoalCreateView(viewModel: .init(nil))
                }
                .navigationDestination(for: Goal.self) { goal in
//                    print(goal)
                    return GoalInfoView(viewModel: .init(goal), path: $path)
                }
            }
            .onAppear {
                viewModel.getData()
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    GoalsListView()
}

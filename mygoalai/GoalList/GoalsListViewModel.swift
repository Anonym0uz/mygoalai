//
//  GoalsListViewModel.swift
//  mygoalai
//
//  Created by Alexander Orlov on 21.10.2025.
//

import Foundation
import SwiftUI
import Combine

final class GoalsListViewModel: ObservableObject {
    @Published var goals: [Goal] = []
    @ObservedObject var storage: GoalsStorage = .shared
    
    init() {
    }
    
    func getData() {
        goals = storage.getGoals()
        /*
        self.goals.append(.init(title: "Накопить на машину", description: "Description", steps: [
            .init(title: "Приобрести машину1"),
            .init(title: "Приобрести машину23 d"),
            .init(title: "Приобрести машину10"),
            .init(title: "Приобрести машину19"),
            .init(title: "Приобрести машину18"),
            .init(title: "Приобрести машину17"),
            .init(title: "Приобрести машину16", isCompleted: true),
            .init(title: "Приобрести машину15", isCompleted: true),
            .init(title: "Приобрести машину14", isCompleted: true),
            .init(title: "Приобрести машину13", isCompleted: true),
            .init(title: "Приобрести машину12", isCompleted: true),
            .init(title: "Test ", isCompleted: true)
        ]))
        self.goals.append(.init(title: "Научиться готовить", description: "Description", steps: [
            .init(title: "Приобрести ингредиенты1"),
            .init(title: "Приобрести ингредиенты2"),
            .init(title: "Приобрести ингредиенты3"),
            .init(title: "Приобрести ингредиенты4", isCompleted: true),
        ]))
        self.goals.append(.init(title: "Научиться готовить1", description: "Description", steps: [
            .init(title: "Приобрести ингредиенты 1", isCompleted: true),
        ]))
        self.goals.append(.init(title: "Научиться играть на гитареoinwdfsoapodifdebguwfijoddokmjnuvhwj9ecikoxps", description: "Description", steps: [
            .init(title: "Приобрести ингредиенты 2"),
        ]))
        self.goals.append(.init(title: "Бросить курить", description: "Description", steps: [
            .init(title: "Приобрести ингредиенты 3"),
        ]))
         */
    }
    
    func removeAction(_ goal: Goal) {
        storage.deleteGoal(goal.id)
        getData()
    }
}

//
//  GoalCreateViewModel.swift
//  mygoalai
//
//  Created by Alexander Orlov on 27.10.2025.
//

import SwiftUI
import Combine
import Sharing

final class GoalCreateViewModel: ObservableObject {
    @Published var goal: Goal?
    @ObservedObject var storage: GoalsStorage = .shared
    
    init(_ goal: Goal?) {
        self.goal = goal
    }
    
    func addStep(_ step: GoalSteps) {
        if goal != nil {
            if goal?.steps == nil {
                goal?.steps = [step]
            } else {
                goal?.steps?.append(step)
            }
            if let goal {
//                self.goal = storage.editGoal(goal.id, title: goal.title, steps: goal.steps)
                self.goal = storage.goalEdit(goal.id, title: goal.title, steps: goal.steps)
            }
        } else {
            goal = .init(steps: [step])
            if let goal {
                storage.saveGoal(goal)
                self.goal = storage.getGoal(goal.id)
            }
        }
    }
    
    func changeTitle(_ title: String) {
        if goal != nil {
            goal?.title = title
            if let goal {
//                self.goal = storage.editGoal(goal.id, title: goal.title, steps: goal.steps)
                self.goal = storage.goalEdit(goal.id, title: goal.title, steps: goal.steps)
            }
        } else {
            goal = .init(title: title)
            if let goal {
                storage.saveGoal(goal)
                self.goal = storage.getGoal(goal.id)
            }
        }
    }
    
    func changeStep(_ step: GoalSteps) {
//        let index = goal?.steps?.firstIndex(of: step)
//        print(index)
//        goal?.steps?.removeAll(where: { $0.id == step.id })
//        goal?.steps?.insert(step, at: step.isCompleted ? (goal?.steps?.count ?? 0) : index ?? (goal?.steps?.count ?? 0))
//        print(goal?.steps ?? [])
        
        storage.$goals.withLock {
            let steps = $0.filter({ $0.id == goal?.id }).first?.steps
            let newStep = steps?.filter({ $0.id == step.id }).first
            newStep?.isCompleted = step.isCompleted
            newStep?.isTemplate = step.isTemplate
            newStep?.title = step.title
            self.goal = $0.filter({ $0.id == goal?.id }).first
        }
    }
    
    func removeAction(_ step: GoalSteps) {
        if let goal = self.goal {
            self.goal = storage.deleteGoalStep(goal, step: step)
        }
    }
}

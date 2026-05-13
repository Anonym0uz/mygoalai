//
//  GoalsStorage.swift
//  mygoalai
//
//  Created by Alexander Orlov on 27.10.2025.
//

import Foundation
import UIKit
import Combine
import Sharing

final class GoalsStorage: ObservableObject {
    public static let shared: GoalsStorage = .init()
//    @Shared(.fileStorage(.documentsDirectory.appending(components: "goals.json"))) public var goals: [Goal] = []
    @Shared(.inMemory("goals")) public var goals: [Goal] = []
    
    init() {}
    
    public func saveGoal(_ goal: Goal) {
        $goals.withLock {
            $0.append(goal)
        }
//        do {
//            let goals = getGoals()
//            let encoder = JSONEncoder()
//            encoder.outputFormatting = .prettyPrinted
//            let datas = try encoder.encode(goals + [goal])
//            saveDataToDocuments(datas)
//        } catch let error {
//            print(error.localizedDescription)
//        }
    }
    
    public func getGoal(_ id: UUID) -> Goal? {
//        checkStorage().first(where: { $0.id == id })
        $goals.withLock {
            if let object = $0.filter({ $0.id == id }).first {
                return object
            }
            return nil
        }
    }
    
    public func getGoals() -> [Goal] {
        $goals.wrappedValue
    }
    
    public func addGoalStep(_ id: UUID, step: GoalSteps) {
        $goals.withLock {
            $0.filter({ $0.id == id }).first?.steps?.append(step)
        }
    }
    
    public func goalEdit(_ id: UUID, title: String?, steps: [GoalSteps]?) -> Goal? {
        $goals.withLock {
            var goal = $0.filter({ $0.id == id }).first
            goal?.steps = steps
            goal?.title = title
            return goal
        }
    }
    
    public func editGoal(_ id: UUID, title: String?, steps: [GoalSteps]?) -> Goal? {
//        var goal = getGoals().first(where: { $0.id == id })
        let goalIndex = getGoals().firstIndex(where: { $0.id == id })
        var newGoal = getGoals()[(goalIndex ?? 0)]
        deleteGoal(id)
        newGoal.title = title
        newGoal.steps = steps
        do {
            let goals = getGoals()
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let datas = try encoder.encode(goals + [newGoal])
            saveDataToDocuments(datas)
        } catch _ {
            print("something is error")
        }
        return newGoal
    }
    
    public func deleteGoal(_ id: UUID) {
        $goals.withLock {
            if let index = $0.firstIndex(where: { $0.id == id }) {
                $0.remove(at: index)
            }
        }
        /*
        do {
            var goals = getGoals()
            goals.removeAll(where: { $0.id == id })
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let datas = try encoder.encode(goals)
            saveDataToDocuments(datas)
        } catch _ {
            print("error")
        }
         */
    }
    
    public func deleteGoalStep(_ goal: Goal, step: GoalSteps) -> Goal? {
        $goals.withLock {
            if let object = $0.filter({ $0.id == goal.id }).first {
                if let index = object.steps?.firstIndex(where: { $0.id == step.id }) {
                    object.steps?.remove(at: index)
                    return object
                }
            }
            return nil
        }
//        do {
//            var newGoal = goal
//            var steps = newGoal.steps ?? []
//            steps.removeAll(where: { $0.id == step.id })
//            newGoal.steps = steps
//            let encoder = JSONEncoder()
//            encoder.outputFormatting = .prettyPrinted
//            
////            let goalIndex = getGoals().firstIndex(where: { $0.id == newGoal.id })
////            var newGoal = getGoals()[(goalIndex ?? 0)]
//            
//            deleteGoal(newGoal.id)
//            let goals = getGoals()
//            let datas = try encoder.encode(goals + [newGoal])
//            saveDataToDocuments(datas)
//            return newGoal
//        } catch _ {
//            print("error")
//        }
//        return nil
    }
}

private extension GoalsStorage {
    func checkStorage() -> [Goal] {
        let jsonFileURL = FileManager.default.getDocumentsDirectory().appendingPathComponent("goals.json")
        return FileManager.default.getObject(jsonFileURL, [Goal].self) ?? []
    }
    
    private func saveDataToDocuments(_ data: Data) {
        let jsonFileURL = FileManager.default.getDocumentsDirectory().appendingPathComponent("goals.json")
        do { try data.write(to: jsonFileURL) }
        catch let error { print("Error = \(error.localizedDescription)") }
    }
}

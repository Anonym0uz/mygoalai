//
//  Goal.swift
//  mygoalai
//
//  Created by Alexander Orlov on 27.10.2025.
//

import SwiftUI
import Combine
import Sharing

@Observable
public class Goal: Identifiable, nonisolated Codable, Hashable {
    public var id: UUID = .init()
    public var title: String?
    public var description: String?
    public var steps: [GoalSteps]?
    public var completed: Int?
    
    public init(title: String? = nil, description: String? = nil, steps: [GoalSteps]? = nil) {
        self.title = title
    }
    
    public func calculateCount() -> CGFloat {
        if let steps = steps?.count,
           let completed = self.steps?.filter({ $0.isCompleted }).count {
            return (CGFloat(completed) / CGFloat(steps)) * 100
        }
        return 0.0
    }
    
    public func calculatePercent() -> CGFloat {
        if let steps = steps?.count,
           let completed = self.steps?.filter({ $0.isCompleted }).count {
            return (CGFloat(completed) / CGFloat(steps)) * 100
        }
        return 0.0
    }
    
    public static func == (lhs: Goal, rhs: Goal) -> Bool {
        lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

//public struct Goal: Hashable, Codable {
//    public var id: UUID = .init()
//    public var title: String?
//    public var description: String?
//    public var steps: [GoalSteps]?
//    public var completed: Int?
//    
//    public init(title: String? = nil, description: String? = nil, steps: [GoalSteps]? = nil) {
//        self.title = title
//        self.description = description
//        self.steps = steps
//        self.completed = steps?.filter({ $0.isCompleted }).count
//    }
//    
//    public func calculatePercent() -> CGFloat {
//        if let steps = steps?.count,
//           let completed = self.steps?.filter({ $0.isCompleted }).count {
//            return (CGFloat(completed) / CGFloat(steps)) * 100
//        }
//        return 0.0
//    }
//}

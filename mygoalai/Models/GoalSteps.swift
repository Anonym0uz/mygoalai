//
//  GoalSteps.swift
//  mygoalai
//
//  Created by Alexander Orlov on 27.10.2025.
//

import SwiftUI
import Combine
import Sharing

@Observable
public final class GoalSteps: Identifiable, Codable, Hashable {
    public var id: UUID = .init()
    public var title: String?
    public var isCompleted: Bool = false
    public var isTemplate: Bool = false
    
    public init(title: String? = nil, isCompleted: Bool = false, isTemplate: Bool = false) {
        self.title = title
        self.isCompleted = isCompleted
        self.isTemplate = isTemplate
    }
    
    public static func == (lhs: GoalSteps, rhs: GoalSteps) -> Bool {
        lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

/*
public struct GoalSteps: Hashable, Codable {
    public var id: UUID = .init()
    public var title: String?
    public var isCompleted: Bool = false
    public var isTemplate: Bool = false
    
    public init(title: String? = nil, isCompleted: Bool = false, isTemplate: Bool = false) {
        self.title = title
        self.isCompleted = isCompleted
        self.isTemplate = isTemplate
    }
}
*/

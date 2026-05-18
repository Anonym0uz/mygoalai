//
//  mygoalaiTests.swift
//  mygoalaiTests
//
//  Created by Alexander Orlov on 18.05.2026.
//

import XCTest
@testable import mygoalai

final class mygoalaiTests: XCTestCase {
    
    private var goalsStorage: GoalsStorage!

    override func setUpWithError() throws {
        goalsStorage = .shared
    }

    override func tearDownWithError() throws {
        goalsStorage = nil
    }

    func test_add_goal_success() throws {
        goalsStorage.saveGoal(.init(title: "test goal", description: nil, steps: nil))
        XCTAssertTrue(goalsStorage.getGoals().count == 1, "Goals added successfully")
        let goal = goalsStorage.getGoals().filter({ ($0.title ?? "") == "test goal" }).first
        if let goal {
            goalsStorage.deleteGoal(goal.id)
        }
    }
    
    func test_delete_goal_success() throws {
        goalsStorage.saveGoal(.init(title: "test goal", description: nil, steps: nil))
        XCTAssertTrue(goalsStorage.getGoals().count == 1, "Goals added successfully")
        let goal = goalsStorage.getGoals().filter({ ($0.title ?? "") == "test goal" }).first
        if let goal {
            goalsStorage.deleteGoal(goal.id)
        }
        XCTAssertTrue(goalsStorage.getGoals().count == 0, "Goals is empty")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}

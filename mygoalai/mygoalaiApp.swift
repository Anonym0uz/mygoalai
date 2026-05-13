//
//  mygoalaiApp.swift
//  mygoalai
//
//  Created by Alexander Orlov on 21.10.2025.
//

import SwiftUI

@main
struct mygoalaiApp: App {
    @State private var loading: Bool = false
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            if loading {
                
            } else {
                GoalsListView()
            }
        }
    }
}

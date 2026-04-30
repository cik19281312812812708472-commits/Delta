//
//  DeltaApp.swift
//  Delta
//
//  Created by Desire on 2026-03-06.
//

import SwiftUI

@main
struct DeltaApp: App {
    
    @StateObject var appState: AppManager
    @StateObject var testManager: TestManager
    
    init() {
        let appManager = AppManager()
        let testManager = TestManager(theAppManager: appManager)
        
        _appState = StateObject(wrappedValue: appManager)
        
        
       
        _testManager = StateObject(wrappedValue: testManager)
        
    }
    
    
    
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appState)
                .environmentObject(testManager)
        }
    }
}

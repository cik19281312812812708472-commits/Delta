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
    @StateObject var generalData: GeneralData
    
    init() {
        let appManager = AppManager()
        let testManager = TestManager(theAppManager: appManager)
        let generalData = GeneralData()
        
        _appState = StateObject(wrappedValue: appManager)
       
        _testManager = StateObject(wrappedValue: testManager)
        
        _generalData = StateObject(wrappedValue: generalData)
        
        
    }
    
    
    
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onOpenURL { url in
                    
                    
                    if url.pathExtension == "deltaTest" {
                        appState.appState = .Tests
                        appState.testState = .selectingPackages
                    }
                    
                }
                .environmentObject(appState)
                .environmentObject(testManager)
                .environmentObject(generalData)
               
                
        }
        
    }
}

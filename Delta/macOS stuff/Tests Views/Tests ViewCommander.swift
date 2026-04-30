//
//  Tests ViewCommander.swift
//  Delta
//
//  Created by Desire on 2026-03-06.
//

import SwiftUI

///this is the manager of all the test views
///
struct testsViewCommander: View {
    
    @EnvironmentObject var appState: AppManager
    @EnvironmentObject var testManager: TestManager
    
    var body: some View {
        
        switch appState.testState {
        case .selectingPackages:
            PackageSelection()
        case .testSettings:
            VStack {}
        case .runningTest:
            testView(correctAnswerWaitingTime: testManager.correctAnswerWaitingTime)
        case .testEnded:
            TestStats()
        }
        
        
        
    }
    
    
}

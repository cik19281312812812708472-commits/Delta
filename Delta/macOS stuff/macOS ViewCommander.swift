//
//  macOS ViewCommander.swift
//  Delta
//
//  Created by Desire on 2026-03-06.
//



import SwiftUI






struct macOSViewCommander: View {
    
    @EnvironmentObject var appManager: AppManager
    

    
    
    
    
    
    var body: some View {
        
        GeometryReader { geo in
            ZStack {
                switch appManager.appState {
                case .startingScreen:
                  
                    startingScreen()
                    
                case .Tests:
                    testsViewCommander()

                case .Packages:
                    Text("hello")
                }
            }
        }
        
        
        
        
        
        
    } // body end
    
}

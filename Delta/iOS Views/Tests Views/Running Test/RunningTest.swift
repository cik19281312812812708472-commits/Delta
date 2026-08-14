//
//  RunningTest.swift
//  Delta
//
//  Created by Desire on 2026-07-19.
//

import SwiftUI
import TestCreation


struct RunningTestView: View {
    
    @EnvironmentObject var testManager: TestManager
    
    @State private var noQuestionsInTest: Bool = false
    
    var body: some View {
        
        GeometryReader { geo in
        
            ZStack {
                
                
                if !noQuestionsInTest {
                    
                    
                    
                } else {
                
                    Text("No Questions")
                        .foregroundStyle(.gray)
                        .font(.title)
                        .fontWeight(.bold)
                        .position(x: geo.size.width / 2, y: geo.size.height / 2)
                    
                }
                
                
            }
            .onAppear() {
               
                
                //fix the bug where if a package give no questions the program crashes
                if testManager.packagesSelected.isEmpty || testManager.allQuestions.isEmpty {
                    
                    
                    noQuestionsInTest = true
                    
                } else {
                    
                    testManager.startTest()
                }
            }
            
        }
        
        
    }
}

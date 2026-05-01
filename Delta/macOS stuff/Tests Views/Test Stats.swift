//
//  Test Stats.swift
//  Delta
//
//  Created by Desire on 2026-04-30.
//

import SwiftUI





struct TestStats: View {
    
    @EnvironmentObject var testManager: TestManager
    @EnvironmentObject var appState: AppManager
    
    @State private var percentageCorrect: Double = 0.0
    @State private var totalQuestions: Int = 1
    
    
    
    
    var body: some View {
        
        
        GeometryReader { geo in
            
            ZStack {
                Background(geo: geo)
                
                
                
                
                
                RoundedRectangle(cornerRadius: 20)
                    .fill(.thinMaterial)
                    .frame(width: geo.size.width * 0.8, height: geo.size.height * 0.8)
                    .shadow(radius: 14)
          
                
            
                Text("You have \(testManager.allQuestionsCorrect.count) \(testManager.allQuestionsCorrect.count > 1 ?  "questions" : "question") correct out of \(totalQuestions)")
                    .font(.title.bold())
                    .position(x: geo.size.width / 2, y: geo.size.height * 0.4)
                
                HStack {
                    Image(systemName: "checkmark.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width * 0.02)
                        .foregroundStyle(.green)
                        .padding(2)
                    
                    Text("\(testManager.allQuestionsCorrect.count)")
                        .font(.title.bold())
                       
                }
                .position(x: geo.size.width * 0.47, y: geo.size.height * 0.55)
                
                
                HStack {
                    
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width * 0.02)
                        .foregroundStyle(.red)
                        .padding(2)
                    
                    Text("\(testManager.allQuestionsWrong.count)")
                        .font(.title.bold())
                    
                }
                .position(x: geo.size.width * 0.53, y: geo.size.height * 0.55)
                
                
                HStack {
                    
                    Image(systemName: "chart.pie.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width * 0.04)
                        .foregroundStyle(percentageCorrect > 50.0 ? Color.green : Color.red)
                        .padding(2)
                    
                    Text("\(percentageCorrect)%")
                        .font(.title.bold())
                        .foregroundStyle(percentageCorrect > 50.0 ? Color.black : Color.red)
                }
                .position(x: geo.size.width / 2, y: geo.size.height * 0.67)
                
                
                Button {
                    
                    
                    testManager.wipeTestData()
                    
                    appState.testState = .selectingPackages
                    appState.appState = .startingScreen
                } label: {
                    Image(systemName: "xmark.circle")
                        .resizable()
                        .scaledToFit()
                }
                .frame(width: geo.size.width * 0.02)
                .position(x: geo.size.width * 0.95, y: geo.size.height * 0.05)
                .buttonStyle(.plain)
                
            }
            
        } .onAppear {
            if testManager.allQuestions.isEmpty {
                
            } else {
                totalQuestions = testManager.allQuestionsCorrect.count + testManager.allQuestionsWrong.count
              
                let truePercentageCorrect: Double = Double(testManager.allQuestionsCorrect.count) / Double(totalQuestions)
                
                percentageCorrect = round(truePercentageCorrect * 100)
            }
        }
     
        
        
        
        
        
        
        
        
        
        
        
        
        
        
    }
}

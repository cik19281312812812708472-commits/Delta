//
//  iOS QuestionsView.swift
//  Delta
//
//  Created by Desire on 2026-07-13.
//

import SwiftUI
import TestCreation
//here it will show a scrole view of the questions that are created
//simply pull up to reload and recreate the questions.

struct iOSQuestionsView: View {
    
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    @EnvironmentObject var appManager: AppManager
    @EnvironmentObject var testManager: TestManager
    @EnvironmentObject var generalData: GeneralData
    
    @State var didTestQuestionsChanged: Bool = false
    
    @FocusState var isModifiyingTestName: Bool
    
    
    var body: some View {
      
        GeometryReader { geo in
            ZStack {
                
                
                TextField("Test Name", text: $testManager.testName)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: geo.size.width * 0.7)
                    //.background(
                    //    RoundedRectangle(cornerRadius: 8)
                   //         .stroke(.white, lineWidth: isModifiyingTestName == true ? 2 : 0)
                   // )
                    .focused($isModifiyingTestName)
                    .font(.title)
                    .fontWeight(.bold)
                    .position(x: geo.size.width * 0.5 , y: geo.size.height * 0)
                    
                //Text("Questions:")
                  ///  .font(.title)
                  //  .fontWeight(.bold)
                   // .position(x: geo.size.width / 2, y: geo.size.height * 0)
                
                Button {
                    appManager.testState = .testSettings
                    appManager.testCreationTestState = .testSettings
                } label: {
                    
                    Image(systemName: "gearshape.fill")
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(colorScheme == .light ? .gray : .white)
                        .frame(width: geo.size.height * 0.04)
                    
                    //Image("settings")
                   //     .resizable()
                  //      .scaledToFit()
                 //       .foregroundStyle(.gray)
                 //       .frame(width: geo.size.height * 0.05)
                    
                    
                }
                .position(x: geo.size.width * 0.92, y: geo.size.height * 0.0)
                
                
                if testManager.allQuestions.count == 0 {
                    
                    RoundedRectangle(cornerRadius: 2)
                        .fill(colorScheme == .light ? generalData.idealBlack : generalData.getWhite(245))
                        .frame(width: geo.size.width * 0.98, height: geo.size.height * 0.002)
                        .frame(maxWidth: .infinity)
                        .position(x: geo.size.width / 2, y: geo.size.height * 0.05)
                    
                    Text("No Questions")
                        .foregroundStyle(.gray)
                        .font(.title)
                        .fontWeight(.bold)
                        .position(x: geo.size.width / 2, y: geo.size.height / 2)
                    
                } else {
                    ScrollView {
                            
                        RoundedRectangle(cornerRadius: 2)
                            .fill(colorScheme == .light ? generalData.idealBlack : generalData.getWhite(245))
                            .frame(width: geo.size.width * 0.98, height: geo.size.height * 0.002)
                            .frame(maxWidth: .infinity)
                        
                        
                        ForEach(testManager.allQuestions, id: \.id) { uneQuestion in
                            TestQuestionButton(question: uneQuestion, oniOS: true, isShadowOff: false)
                                .padding(5)
                        }
                        
                        Spacer()
                        
                    }
                    .onChange(of: testManager.allQuestions) {
                        didTestQuestionsChanged = true
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.02) {
                            didTestQuestionsChanged = false
                        }
                        
                    }
                    //.animation(.smooth, value: didTestQuestionsChanged)
                    .refreshable {
                        withAnimation(.smooth) {
                            testManager.createAllQuestions()
                        }
                    }
                    .offset(y: geo.size.height * 0.05)
                }
                
            }
            .ignoresSafeArea(.keyboard)
            
        }
        .onAppear() {
            testManager.createAllQuestions()
        }
        
        
        
    }
}


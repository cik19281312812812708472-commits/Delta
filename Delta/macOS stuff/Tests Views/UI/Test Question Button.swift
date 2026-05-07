//
//  Test Question Button.swift
//  Delta
//
//  Created by Desire on 2026-04-28.
//

import SwiftUI
import Combine
import Foundation
import TestCreation

struct TestQuestionButton: View {
    
    var question: Question
    @State private var popOverShown: Bool = false
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var testManager: TestManager
    
    var body: some View {
        
        
        Button {
            popOverShown.toggle()
        } label: {
 
            Text(question.questionText)
        }
     
        .background(colorScheme == .light ? Color.white : Color.black)
     
        .cornerRadius(14)
        .shadow(radius: 14)
        
        .contextMenu() {
            Button("Remove Question") {
                testManager.removeQuestion(question, removeAll: false)
            }
            Button("Remove all of this Question") {
                testManager.removeQuestion(question, removeAll: true)
            }
  
                Text("This removes every question that is this question")
            
        }
        .popover(isPresented: $popOverShown) {
            
            GeometryReader { popOverGeo in
            
                ZStack {
                    
                    VStack {
                        
                        
                      
                        
                        question.questionContent
                      
                        
                    }
                    
                }
                
            }
            .frame(width: question.questionContentSizeX, height: question.questionContentSizeY)
            
        }
        
        
    }
    
    init(question: Question) {
        self.question = question
    }
}

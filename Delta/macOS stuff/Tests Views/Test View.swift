//
//  Test View.swift
//  Delta
//
//  Created by Desire on 2026-04-26.
//

///for the actual view just put everything in a scroll view
import SwiftUI
import TestCreation


struct testView: View {
 
    @Environment(\.colorScheme) var colorScheme
    
    @EnvironmentObject var testManager: TestManager
    @EnvironmentObject var appState: AppManager
    
    @State private var isCorrectAnswerShown: Bool = false
    
    var idealWhite: Color = Color(red: 245/255, green: 245/255, blue: 245/255)
    
    var correctAnswerWaitingTime: Double
    
    func showCorrectAnswer() {
        isCorrectAnswerShown = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + correctAnswerWaitingTime) {
            isCorrectAnswerShown = false
        }
        
    }
    
    var body: some View {
        
        GeometryReader { geo in
            
            ZStack {
                 
            Background(geo: geo)
                
                
                
                RoundedRectangle(cornerRadius: 20)
                    .fill(colorScheme == .light ? idealWhite : Color.black)
                    .frame(width: geo.size.width * 0.8, height: geo.size.height * 0.8)
                    .shadow(radius: 14)
                
                
                ZStack {
                    testManager.currentQuestion?.questionContent
                }
                .frame(maxWidth: geo.size.width * 0.8, maxHeight: geo.size.height * 0.7)
                
                Text(testManager.currentQuestion?.questionText ?? "")
                    .font(.title2.bold())
                    .position(x: geo.size.width / 2, y: geo.size.height * 0.3)
                
                
                
                
                
                
                
                Button {
                    testManager.changeQuestion(by: 1)
                    
                    showCorrectAnswer()
                } label: {
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 14)
                            .fill(.green)
                        
                        Image(systemName: "arrowshape.forward.fill")
                    }
                }
                .buttonStyle(.plain)
                .frame(width: geo.size.width * 0.05, height: geo.size.height * 0.05)
                .shadow(radius: 8)
                .position(x: geo.size.width * 0.8, y: geo.size.height * 0.8)
                
                
                Button {
                    testManager.changeQuestion(by: -1)
                    
                    showCorrectAnswer()
                } label: {
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 14)
                            .fill(.yellow)
                        
                        Image(systemName: "arrowshape.forward.fill")
                            .rotationEffect(.degrees(-180))
                    }
                }
                .buttonStyle(.plain)
                .frame(width: geo.size.width * 0.05, height: geo.size.height * 0.05)
                .shadow(radius: 8)
                .position(x: geo.size.width * 0.2, y: geo.size.height * 0.8)
                
                
                
                
                TextField("Answer", text: $testManager.allQuestions[testManager.currentQuestionNumber].input)
                    .frame(width: geo.size.width * 0.3)
                    .onSubmit {
                        showCorrectAnswer()
                        testManager.changeQuestion(by: 1)
                    }
                    .position(x: geo.size.width * 0.5, y: geo.size.height * 0.6)
                    
                
                
                
                
                
                Text("Question \(testManager.currentQuestionNumber + 1)")
                    .font(Font.largeTitle.bold())
                    .position(x: geo.size.width / 2, y: geo.size.height * 0.15)
                
                
                
                
                RoundedRectangle(cornerRadius: 100)
                    .fill(.thinMaterial)
                    .stroke(colorScheme == .light ? idealWhite : .black, lineWidth: 2)
                    .frame(width: geo.size.width * 0.1, height: geo.size.height * 0.04)
                    .position(x: geo.size.width / 2, y: geo.size.height * 0.05)
                
                HStack {
                    Image(systemName: "checkmark.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width * 0.015)
                        .scaleEffect(testManager.previousQuestion?.isAnswerCorrect ?? false ? 1.5 : 1.0)
                        .animation(.spring(), value: testManager.previousQuestion?.isAnswerCorrect ?? false)
                        .foregroundStyle(.green)
                        .padding(2)
                    
                    Text("\(testManager.allQuestionsCorrect.count)")
                        .font(.title.bold())
                       
                }
                .position(x: geo.size.width * 0.465, y: geo.size.height * 0.05)
                
                
                
                HStack {
                    
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width * 0.015)
                        .foregroundStyle(.red)
                        .padding(2)
                    
                    Text("\(testManager.allQuestionsWrong.count)")
                        .font(.title.bold())
                    
                }
                .position(x: geo.size.width * 0.525, y: geo.size.height * 0.05)
                
                
                Button {
                    appState.testState = .testEnded
                } label: {
                    Image(systemName: "xmark.circle")
                        .resizable()
                        .scaledToFit()
                }
                .frame(width: geo.size.width * 0.02)
                .position(x: geo.size.width * 0.95, y: geo.size.height * 0.05)
                .buttonStyle(.plain)
                
                
                if isCorrectAnswerShown == true && testManager.previousQuestion?.isAnswerCorrect == false {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.thinMaterial)
                            .stroke(colorScheme == .light ? idealWhite : .black, lineWidth: 2)
                            
                        
                        
                        Text("Correct Answer is: \"\(testManager.previousQuestion?.questionAnswer ?? "N/A")\"")
                            .font(.title.bold())
                            .padding(.horizontal, 10)
                            .padding(.vertical, 10)
                        
                 
                        
                    }
                    .fixedSize()
                    .position(x: geo.size.width / 2, y: geo.size.height * 0.95)
                }
                   
                //make a haptic input that shows it hte questiosn answers are correct
                
            }
            
        }
        
        
        
        
      
    }
}

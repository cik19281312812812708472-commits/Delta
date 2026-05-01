///
///  Test Creator.swift
///  Delta
///
///  Created by Desire on 2026-03-06.
///
///   code that manages the package creation and compiles it into one neet thing each views has thier own viewer .
///
///


import Foundation
import Combine
import TestCreation


struct Section {
    
    
    
}


 class TestManager: ObservableObject {
    
    @Published var packagesSelected: [UUID] = []
    @Published var packagesNotSelected: [UUID] = []
    @Published var allPackages: [UUID:any Package] = [:]
     
     
     
    @Published var allQuestions: [Question] = []
    @Published var stashOfAllQuestions: [Question] = []
    @Published var stashOfAllQuestionsMarks: [Int] = []
     
     
    @Published var allQuestionsWrong: [Question] = []
     @Published var allQuestionsCorrect: [Question] = []
     
     @Published var previousQuestion: Question? = nil
    @Published var createdTest: Bool = false
 
    @Published var currentQuestionNumber: Int = 0
    @Published var currentQuestion: Question? = nil
     @Published var questionsSuggested: [Question] = []
  
     
     //settings:
     @Published var allowTestAlgorithm: Bool = false
     @Published var randmizeQuestionsAtStart: Bool = false
     @Published var correctAnswerWaitingTime: Double = 2.0
     
    var appManager: AppManager
    
    init(theAppManager: AppManager) {
        self.appManager = theAppManager
    }
    
     
     func wipeTestData() {
         
         allQuestions = []
         stashOfAllQuestions = []
         stashOfAllQuestionsMarks = []
         allQuestionsWrong = []
         allQuestionsCorrect = []
         previousQuestion = nil
         createdTest = false
         currentQuestionNumber = 0
         currentQuestion = nil
         questionsSuggested = []
         
         
         
     }
    
    
    func createAllQuestions() {
        
        var actualPackagesSelected: [any Package] = []
        
        var tempAllQuestions: [Question] = []
        
        for package in packagesSelected {
            
            actualPackagesSelected.append(allPackages[package] ?? examplePackage())
   
        }
        
        
        for i in 0..<actualPackagesSelected.count {
            
            var section: [Question] = actualPackagesSelected[i].createSection(numOfQuestions: 10)
            
            tempAllQuestions += section
            
        }
        
        allQuestions = tempAllQuestions
        
        createdTest = true 
    }
    
    
    
    func startTest() {
        
       
        stashOfAllQuestions = allQuestions
        stashOfAllQuestionsMarks = allQuestions.map {_ in 0}
        
        
        if self.randmizeQuestionsAtStart == true {
            
            let randomizedQuestions = allQuestions.shuffled()
            allQuestions = randomizedQuestions
            
        }
        
        currentQuestionNumber = 0
        currentQuestion = allQuestions[currentQuestionNumber]
        
        appManager.testState = .runningTest

    }
    
    
     func changeQuestion(by: Int) {
            
        
        allQuestions[currentQuestionNumber].checkAnswer()
        previousQuestion = allQuestions[currentQuestionNumber]
         
         
         
         
         algorithmia_addQuestionToWrongQuestions()
        if allowTestAlgorithm == true {
         
            algorithmia_markQuestion(allQuestions[currentQuestionNumber])
        }
     
        
        
         if by > 0 {
             if currentQuestionNumber + by < allQuestions.count - 1 {
                 currentQuestionNumber += by
                 currentQuestion = allQuestions[currentQuestionNumber]
             } else {
                 if allowTestAlgorithm == true {
                     let suggestedQuestion = algorithmia_suggestNextQuestion()
                     allQuestions.append(suggestedQuestion)
                     currentQuestionNumber += by
                     currentQuestion = suggestedQuestion
                 } else {
                     currentQuestion = allQuestions[0]
                     currentQuestionNumber = 0
                 }
                 
                 
             }
         } else {
             
             if currentQuestionNumber + by > -1 {
                 
                 
                 currentQuestionNumber += by
                 currentQuestion = allQuestions[currentQuestionNumber]
                 
             } else {
                 if allowTestAlgorithm == true {
                     let suggestedQuestion = algorithmia_suggestNextQuestion()
                     allQuestions.insert(suggestedQuestion, at: 0)
                     currentQuestionNumber += by
                     currentQuestion = suggestedQuestion
                     
                 } else {
                     currentQuestion = allQuestions[allQuestions.count - 1]
                     currentQuestionNumber = allQuestions.count - 1
                 }
                 
             }
             
             
             
             
             
             
             
             
         }
        
        
    }
    
     func algorithmia_addQuestionToWrongQuestions() {
         
         if allQuestions[currentQuestionNumber].isAnswerCorrect == false {
         
              let actualQuestion =  allQuestions[currentQuestionNumber]
                 if allQuestionsWrong.contains(actualQuestion) == false {

                     allQuestionsWrong.append(actualQuestion)
                     
                 }
             
             
         } else {
             
              let actualQuestion =  allQuestions[currentQuestionNumber]
                 if allQuestionsCorrect.contains(actualQuestion) == false {

                     allQuestionsCorrect.append(actualQuestion)

                 }
           
         }
         //print(allQuestionsCorrect)
         
     }

     func algorithmia_markQuestion(_ question: Question) {
         
         if question.isAnswerCorrect == true {
             
         }
         
         //now wer can remove it from allquestionswrong
         
         
     }
     
     func algorithmia_suggestNextQuestion() -> Question {
         
      
         let questionWords = "test"
         //MARK: FIX THIS
         let questionContent2 = QuestionContent { AnyView (VStack {  Text(questionWords)  }) }
         
         var suggestedQuestion: Question = Question(questionText: "", questionContent: questionContent2 , questionContentSizeX: CGFloat(500), questionContentSizeY: CGFloat(500), questionAnswer: questionWords)
         
         if allQuestionsWrong.count > 1 {
             
             
             suggestedQuestion = allQuestionsWrong.randomElement()!
             questionsSuggested.append(suggestedQuestion)
             
         } else {
             
             suggestedQuestion = allQuestions.randomElement() ?? Question(questionText: "", questionContent: questionContent2 , questionContentSizeX: CGFloat(500), questionContentSizeY: CGFloat(500), questionAnswer: questionWords)
             
         }
         
         
         return suggestedQuestion
     }
     
}





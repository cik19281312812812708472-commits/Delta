///
///  Test Creator.swift
///  Delta
///
///  Created by Desire on 2026-03-06.
///
///  er .
///
///


import Foundation
import Combine
import TestCreation

//MARK: ADD QUESTION TYPE ID
 class TestManager: ObservableObject {
    
     @Published var packagesSelected: [UUID] = []
     @Published var packagesNotSelected: [UUID] = []
     @Published var allPackages: [UUID:any Package] = [:]
     
     
     @Published var testName: String = "Blank Test"
     
     @Published var allQuestions: [Question] = []
     
     //this is used in the algorithim to suggest a question as allQuestions changes this just stores all the questions that can exist.
     @Published var stashOfAllQuestions: [Question] = []
     @Published var stashOfAllQuestionsMarks: [Int] = []
     
     
     @Published var allQuestionsWrong: [Question] = []
     @Published var allQuestionsCorrect: [Question] = []
     
     @Published var previousQuestion: Question? = nil
     @Published var createdTest: Bool = false
     @Published var startedTest: Bool = false
 
     @Published var currentQuestionNumber: Int = 0
     @Published var currentQuestion: Question? = nil
     @Published var questionsSuggested: [Question] = []
  
     
     //settings:
     @Published var amountofTimesAnswerCorrectToPass: Int = 0
     @Published var allowTestAlgorithm: Bool = false
     @Published var randomizeQuestionsAtStart: Bool = false
     @Published var correctAnswerWaitingTime: Double = 2.0
     
     @Published var savedTest: Bool = false
     //@Published var allTests: [Test] = []
     
     @Published var loadedTest: Test? = nil
     
     @Published var allTestNames: [String] = []
     
     
     
    var appManager: AppManager
    
    init(theAppManager: AppManager) {
        self.appManager = theAppManager
        
        for package in appManager.allPackages {
            allPackages[package.id] = package
        }
        
    }
    
     
     func wipeTestData() {
         
         allQuestions = []
         stashOfAllQuestions = []
         stashOfAllQuestionsMarks = []
         allQuestionsWrong = []
         allQuestionsCorrect = []
         previousQuestion = nil
         createdTest = false
         startedTest = false
         currentQuestionNumber = 0
         currentQuestion = nil
         questionsSuggested = []
         
         
         
     }
    
     func removeQuestion(_ question: Question, removeAll: Bool) {
         
         if removeAll == true {
             
             allQuestions.removeAll() {
                 
                 $0.questionText == question.questionText &&
                 $0.questionType == question.questionType &&
                 $0.questionContentSizeX == question.questionContentSizeX &&
                 $0.questionContentSizeY == question.questionContentSizeY
                
             }
             
         } else {
             allQuestions.removeAll() { $0.id == question.id}
         }
         
     }
     
     
    func createAllQuestions() {
        
        var actualPackagesSelected: [any Package] = []
        
        var tempAllQuestions: [Question] = []
        
        for package in packagesSelected {
            
            actualPackagesSelected.append(allPackages[package] ?? examplePackage())
   
        }
        
        
        for i in 0..<actualPackagesSelected.count {
            
            let section: [Question] = actualPackagesSelected[i].createSection(numOfQuestions: 10)
            
            tempAllQuestions += section
            
        }
        
        
        
        allQuestions = randomizeQuestionsAtStart == true ? tempAllQuestions.shuffled() : tempAllQuestions
        
        createdTest = true 
    }
    
    
    ///This funcion si
    func startTest() {
        
        startedTest = true 
        
        stashOfAllQuestions = allQuestions
        stashOfAllQuestionsMarks = allQuestions.map {_ in 0}
        
        currentQuestionNumber = 0
        currentQuestion = allQuestions[currentQuestionNumber]
        
        appManager.testState = .runningTest
        
    }
    
    
     func changeQuestion(by: Int) {
            
        
        allQuestions[currentQuestionNumber].checkAnswer()
        previousQuestion = allQuestions[currentQuestionNumber]
      
      
        
         
        if allowTestAlgorithm == true {
           
            //let question = allQuestions[currentQuestionNumber]
          
            algorithmia_markQuestion(allQuestions[currentQuestionNumber])
        } else {
            markQuestion(allQuestions[currentQuestionNumber])
        }
     
        
        
         if by > 0 {
             if currentQuestionNumber + by <= allQuestions.count - 1 {
                 currentQuestionNumber += by
                 currentQuestion = allQuestions[currentQuestionNumber]
             } else {
                 if allowTestAlgorithm == true {
                     let suggestedQuestion = algorithmia_suggestNextQuestion()
                     allQuestions.append(suggestedQuestion)
                     currentQuestionNumber = allQuestions.count - 1
                     currentQuestion = allQuestions[currentQuestionNumber]
                 } else {
                     currentQuestion = allQuestions[0]
                     currentQuestionNumber = 0
                 }
                 
                 
             }
         } else {
             
             if currentQuestionNumber + by >= 0 {
                 
                 
                 currentQuestionNumber += by
                 currentQuestion = allQuestions[currentQuestionNumber]
                 
             } else {
                 
                     currentQuestion = allQuestions[allQuestions.count - 1]
                     currentQuestionNumber = allQuestions.count - 1
                 
                 
             }
             
         }
        
        
    }
    
     func flagQuestion() {
         //MARK: Fix the var names
         let actualQuestionNumber = (currentQuestionNumber + 1) % stashOfAllQuestions.count
         stashOfAllQuestionsMarks[actualQuestionNumber - 1] -= 1
         
     }
     
     
     func markQuestion(_ question: Question) {
         if question.isAnswerCorrect == true {
             algorithmia_addQuestionToCorrectQuestions()
             stashOfAllQuestionsMarks[currentQuestionNumber] += 1
         } else {
             algorithmia_addQuestionToWrongQuestions()
             stashOfAllQuestionsMarks[currentQuestionNumber] -= 1
         }
     }
     
     func algorithmia_addQuestionToWrongQuestions() {
         
              let actualQuestion =  allQuestions[currentQuestionNumber]
                 if allQuestionsWrong.contains(actualQuestion) == false {
                     allQuestionsCorrect.removeAll() { $0 == actualQuestion }
                     allQuestionsWrong.append(actualQuestion)
                     
                 }
             
             
         
         //print(allQuestionsCorrect)
         
     }
     
     func algorithmia_addQuestionToCorrectQuestions() {
         let actualQuestion =  allQuestions[currentQuestionNumber]
         if allQuestionsCorrect.contains(actualQuestion) == false {
             allQuestionsWrong.removeAll() { $0 == actualQuestion }
             allQuestionsCorrect.append(actualQuestion)
             
         }
     }

     func algorithmia_markQuestion(_ question: Question) {
   
         if question.isAnswerCorrect == true {
             let actualQuestionNumber = currentQuestionNumber % stashOfAllQuestions.count
                          
             stashOfAllQuestionsMarks[actualQuestionNumber] += 1
             
             print(stashOfAllQuestionsMarks)
             if stashOfAllQuestionsMarks[actualQuestionNumber] > amountofTimesAnswerCorrectToPass {
                
                 algorithmia_addQuestionToCorrectQuestions()
                 
             }
             
            
             
            
             
         } else {

             algorithmia_addQuestionToWrongQuestions()
    
             
             
             // this is so that if the question number is greater than the amount of questions in stash of all questions wich is unchanging then it will show the actual question that the new question is refering to.
             let actualQuestionNumber = currentQuestionNumber % stashOfAllQuestions.count 
             
             stashOfAllQuestionsMarks[actualQuestionNumber] -= 1
          
         }
     
         //now wer can remove it from allquestionswrong
         
         
     }
     
     func algorithmia_suggestNextQuestion() -> Question {
         
         var suggestedQuestion: Question = Question.getNullQuestion()
         
         if allQuestionsWrong.count > 0 {
             
             suggestedQuestion = allQuestionsWrong.randomElement()!
             questionsSuggested.append(suggestedQuestion)
             
         } else {
             
             suggestedQuestion = stashOfAllQuestions.randomElement()!
             
         }
         suggestedQuestion.input = ""
         
         return suggestedQuestion
     }
     
}





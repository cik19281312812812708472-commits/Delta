//
//  Test Struct.swift
//  Delta
//
//  Created by Desire on 2026-04-30.
//

import TestCreation


extension TestManager {
  
    struct Test: Codable {
        
        
       
        var name: String
        var allQuestions: [DescriptionOfQuestion]
        var stashOfAllQuestions: [DescriptionOfQuestion]
        var stashOfAllQuestionsMarks: [Int]
        var allQuestionsWrong: [DescriptionOfQuestion]
        var allQuestionsCorrect: [DescriptionOfQuestion]
        var previousQuestion: DescriptionOfQuestion?
        
        var currentQuestionNumber: Int
        var currentQuestion: DescriptionOfQuestion?
        var questionsSuggested: [DescriptionOfQuestion]
         
        var startedTest: Bool
        
        init(name: String, allQuestions: [DescriptionOfQuestion], stashOfAllQuestions: [DescriptionOfQuestion], stashOfAllQuestionsMarks: [Int], allQuestionsWrong: [DescriptionOfQuestion], allQuestionsCorrect: [DescriptionOfQuestion], previousQuestion: DescriptionOfQuestion? = nil, startedTest: Bool, currentQuestionNumber: Int, currentQuestion: DescriptionOfQuestion? = nil, questionsSuggested: [DescriptionOfQuestion]) {
            self.name = name
            self.allQuestions = allQuestions
            self.stashOfAllQuestions = stashOfAllQuestions
            self.stashOfAllQuestionsMarks = stashOfAllQuestionsMarks
            self.allQuestionsWrong = allQuestionsWrong
            self.allQuestionsCorrect = allQuestionsCorrect
            self.previousQuestion = previousQuestion
            self.startedTest = startedTest
            self.currentQuestionNumber = currentQuestionNumber
            self.currentQuestion = currentQuestion
            self.questionsSuggested = questionsSuggested
        }
        
    }
    
}





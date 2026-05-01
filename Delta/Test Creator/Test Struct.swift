//
//  Test Struct.swift
//  Delta
//
//  Created by Desire on 2026-04-30.
//

import TestCreation

struct test {
    
    var name: String
    var allQuestions: [Question] = []
    var stashOfAllQuestions: [Question] = []
    var stashOfAllQuestionsMarks: [Int] = []
    var allQuestionsWrong: [Question] = []
    var allQuestionsCorrect: [Question] = []
    var previousQuestion: Question? = nil
    var createdTest: Bool = false
    var currentQuestionNumber: Int = 0
    var currentQuestion: Question? = nil
    var questionsSuggested: [Question]  = []
    
    
    
}

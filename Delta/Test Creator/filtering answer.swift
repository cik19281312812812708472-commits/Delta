//
//  filtering answer.swift
//  Delta
//
//  Created by Desire on 2026-05-17.
//

import Foundation
import TestCreation

extension TestManager {
    
    
    func filterAnswer() {
        
        
        
        
        if let questionOwner = currentQuestion?.packageOwner {
            
            
            let questionsPackage = allPackages[questionOwner]
            
            
            let answer = allQuestions[currentQuestionNumber].input
            
            let newAnswer = questionsPackage?.filterAnswer(answer: answer) ?? ""
            
            allQuestions[currentQuestionNumber].input = newAnswer
            
            ///Incase the package changes internal stuff we set it to the new version
            allPackages[questionOwner] = questionsPackage
            
            
        } else { return }
        
    }
    
}

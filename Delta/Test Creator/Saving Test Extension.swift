//
//  Saving Test Extension.swift
//  Delta
//
//  Created by Desire on 2026-06-02.
//

import TestCreation
import Foundation
import Combine
import SwiftUI

extension Array where Element == Question {
    
     func filterQuestions(isIncluded: (Question) -> Bool) -> [TempQuestion] {
        
        var result: [TempQuestion] = []
        
        for i in 0..<self.count {
            
            
            let question = self[i]
            
            if isIncluded(question) {
                
                let tempQuestion = TempQuestion(question: question, index: i)
                
                result.append(tempQuestion)
            }
        }
        
        return result
    }
    
    
}

 struct TempQuestion {
    
    var question: Question
    var index: Int
    
    
}

extension TestManager {
    //what does it mean
    
   
    func setLastTestName() {
        
        var bundleID = Bundle.main.bundleIdentifier ?? "Delta"
        
        let lastTestURL = findURLinAppSupport()
            .appendingPathComponent(bundleID)
            .appendingPathComponent("Last Test")
            .appendingPathComponent(testName)
            .appendingPathExtension("deltaTest")
        
        
        FileManager.default.createFile(atPath: lastTestURL.path, contents: nil)
        
        
    }
    
    
    
    func saveTest() {
        savedTest = false
        //MARK: FIX THIS
        
        // each package should add the extra discription
        
        //MARK: - Converting the Questions into descriptions of them.
        //this should save the question index
        //convert tthe questions into tmep of questions them compare it via filtering it
        
        //creating a vars that holds all the questions that the test will use so that we can save we will save the index so themn we  cana accses
        
        //we can do this twice as there surley wont be 10000+ questions.
        
        func getDescriptionOfQuestionsFromPackages(questions: [TempQuestion]) -> [DescriptionOfQuestion] {
            var allDescriptions: [DescriptionOfQuestion] = []
            
            for tempQuestion in questions {
                
                if let packageOwner = allPackages[tempQuestion.question.packageOwner] {
                    
                    var descriptionOfQuestion = packageOwner.saveQuestion(question: tempQuestion.question)
                    
                    descriptionOfQuestion.questionIndex = tempQuestion.index
                    
                    allDescriptions.append(descriptionOfQuestion)
                }
            }
            
            return allDescriptions
        }
        
        func getDescriptionOfQuestions(from questions: [TempQuestion]) -> [DescriptionOfQuestion] {
            
            var descriptionOfQuestions: [DescriptionOfQuestion] = []
            
            for i in 0..<questions.count {
                
                let question = questions[i].question
                
                if let packageOwner = allPackages[question.packageOwner] {
                    
                    var questionDescription = DescriptionOfQuestion(ownerInternalName: packageOwner.internalName, question: question)
                    
                    questionDescription.questionIndex = questions[i].index
                    
                    descriptionOfQuestions.append(questionDescription)
                }
            }
            
            return descriptionOfQuestions
        }
        
        
        let tempStashOfAllQuestionsSelfCreated: [TempQuestion] = stashOfAllQuestions.filterQuestions { $0.letTestManagerCreateDescriptionOfQuestion }
        let tempStashOfAllQuestionsNotSelfCreated: [TempQuestion] = stashOfAllQuestions.filterQuestions { !$0.letTestManagerCreateDescriptionOfQuestion }
        
        let stashOfAllQuestionsSelfCreated: [DescriptionOfQuestion] = getDescriptionOfQuestions(from: tempStashOfAllQuestionsSelfCreated)
        
        
        
        let stashOfAllQuestionsNotSelfCreated: [DescriptionOfQuestion] = getDescriptionOfQuestionsFromPackages(questions: tempStashOfAllQuestionsNotSelfCreated)
        
        
        let tempallQuestionsSelfCreated: [TempQuestion] = allQuestions.filterQuestions { $0.letTestManagerCreateDescriptionOfQuestion == true }
        let tempallQuestionsNotSelfCreated: [TempQuestion] = allQuestions.filterQuestions { $0.letTestManagerCreateDescriptionOfQuestion == false }
       
       
        let allQuestionsSelfCreated: [DescriptionOfQuestion] = getDescriptionOfQuestions(from: tempallQuestionsSelfCreated)
        print("AllQuestions Sefl created: ", allQuestionsSelfCreated)
        let allQuestionsNotSelfCreated: [DescriptionOfQuestion] = getDescriptionOfQuestionsFromPackages(questions: tempallQuestionsNotSelfCreated)
        print("allQuestions not self created: ", allQuestionsNotSelfCreated)
        print("Allquestions Self created: ")
        
        var questionsWrongSelfCreated: [DescriptionOfQuestion] {
            
            let tempQuestionsWrongSelfCreated = allQuestionsWrong.filterQuestions { $0.letTestManagerCreateDescriptionOfQuestion }
            
            return getDescriptionOfQuestions(from: tempQuestionsWrongSelfCreated)
        }
        
        
        var questionsWrongNotSelfCreated: [DescriptionOfQuestion] {
         
            let tempQuestionsWrongNotSelfCreated = allQuestionsWrong.filterQuestions { !$0.letTestManagerCreateDescriptionOfQuestion }
            
            return getDescriptionOfQuestionsFromPackages(questions: tempQuestionsWrongNotSelfCreated)
        }
        
        var questionsCorrectSelfCreated: [DescriptionOfQuestion] {
            
            let tempQuestionsCorrectSelfCreated = allQuestionsCorrect.filterQuestions { $0.letTestManagerCreateDescriptionOfQuestion }
            
            return getDescriptionOfQuestions(from: tempQuestionsCorrectSelfCreated)
        }
       
        var questionsCorrectNotSelfCreated: [DescriptionOfQuestion] {
            
            let tempQuestionsCorrectNotSelftCreated = allQuestionsCorrect.filterQuestions { !$0.letTestManagerCreateDescriptionOfQuestion }
            
            return getDescriptionOfQuestionsFromPackages(questions: tempQuestionsCorrectNotSelftCreated)
        }
        
        
        var questionsSuggestedSelfCreated: [DescriptionOfQuestion] {
            
            let tempQuestionsSuggestedSelfCreated = questionsSuggested.filterQuestions { $0.letTestManagerCreateDescriptionOfQuestion }
            
            return getDescriptionOfQuestions(from: tempQuestionsSuggestedSelfCreated)
        }
        
        var questionsSuggestedNotSelfCreated: [DescriptionOfQuestion] {
            
            let tempQuestionsSuggestedNotSelfCreated = questionsSuggested.filterQuestions { !$0.letTestManagerCreateDescriptionOfQuestion }
            
            return getDescriptionOfQuestionsFromPackages(questions: tempQuestionsSuggestedNotSelfCreated)
        }
        
       
        
        //MARK: - Recombining description of questions
        // and ordering them back into thier order.
        
        var tempAllQuestions: [DescriptionOfQuestion] {
            
            var allQuestions = allQuestionsSelfCreated + allQuestionsNotSelfCreated
            
            //sorting the question index in asending order.
            
            allQuestions = allQuestions.sorted { $0.questionIndex < $1.questionIndex }
            
            return allQuestions
        }
        
        var tempStashOfAllQuestions: [DescriptionOfQuestion] {
            
            var stashOfAllQuestions = stashOfAllQuestionsSelfCreated + stashOfAllQuestionsNotSelfCreated
            
            stashOfAllQuestions = stashOfAllQuestions.sorted { $0.questionIndex < $1.questionIndex }
            
            return stashOfAllQuestions
        }
        
        var tempAllQuestionsWrong: [DescriptionOfQuestion] {
            
            var allQuestionsWrong = questionsWrongSelfCreated + questionsWrongNotSelfCreated
            
            allQuestionsWrong = allQuestionsWrong.sorted { $0.questionIndex < $1.questionIndex }
            
            return allQuestionsWrong
        }
        
        var tempAllQuestionsCorrect: [DescriptionOfQuestion] {
            
            var allQuestionsCorrect = questionsCorrectSelfCreated + questionsCorrectNotSelfCreated
            
            allQuestionsCorrect = allQuestionsCorrect.sorted { $0.questionIndex < $1.questionIndex }
            
            return allQuestionsCorrect
        }
        
        var tempQuestionsSuggested: [DescriptionOfQuestion] {
            
            var questionsSuggested = questionsSuggestedSelfCreated + questionsSuggestedNotSelfCreated
            
            questionsSuggested = questionsSuggested.sorted { $0.questionIndex < $1.questionIndex }
            
            return questionsSuggested
        }
        
        //MARK: Creating the test.
        let testToSave = Test(name: testName, allQuestions: tempAllQuestions, stashOfAllQuestions: tempStashOfAllQuestions, stashOfAllQuestionsMarks: stashOfAllQuestionsMarks, allQuestionsWrong: tempAllQuestionsWrong, allQuestionsCorrect: tempAllQuestionsCorrect, startedTest: startedTest, currentQuestionNumber: currentQuestionNumber, questionsSuggested: tempQuestionsSuggested)
        
        var trueTestToSave: Data
        
        do {
             trueTestToSave = try JSONEncoder().encode(testToSave)
        } catch {
            fatalError("JSON encoder failed to encode the Test to save.")
        }
        
        //creating URL for test to save
        let fileManager = FileManager.default
        
        guard let appSupportURL = fileManager.urls(for: .applicationSupportDirectory, in: .userDomainMask).first else {
            fatalError("Failed to find app support.")
        }
        
        let bundleID = Bundle.main.bundleIdentifier ?? "Delta"
        let savedTestsURL = appSupportURL.appendingPathComponent(bundleID).appendingPathComponent("SavedTests")
        
        let fileURL = savedTestsURL.appendingPathComponent("\(testName).deltaTest")
        
        do {
            try fileManager.createDirectory(at: savedTestsURL, withIntermediateDirectories: true, attributes: nil)
            try trueTestToSave.write(to: fileURL, options: .atomic)
            
        } catch {
            
        }
        
       savedTest = true 
        
        print("~~~~~")
        print("Test TO SAVE: ", testToSave)
        
        
    }
    
    func deleteTest(testName: String) {
        
        let fileManager = FileManager.default
        
        guard let appSupportURL = fileManager.urls(for: .applicationSupportDirectory, in: .userDomainMask).first else {
            fatalError("Failed to find app support.")
        }
        
        let bundleID = Bundle.main.bundleIdentifier ?? "Delta"
        let savedTestURL = appSupportURL.appendingPathComponent(bundleID)
            .appendingPathComponent("SavedTests")
            .appendingPathComponent("\(testName).deltaTest")
        
        guard fileManager.fileExists(atPath: savedTestURL.path) else {
            return
        }
        
        do {
            try fileManager.removeItem(at: savedTestURL)
        } catch {
            print("failed to delete test")
        }
        
    }
    
    
    
    
    
    
    
    func findAllTests() {
        
        let bundleID = Bundle.main.bundleIdentifier ?? "Delta"
        let SavedTestsURL = findURLinAppSupport()
            .appendingPathComponent(bundleID)
            .appendingPathComponent("SavedTests")
         
        var allTestNames: [String] = []
        
        
        do {
            
            let files = try FileManager.default.contentsOfDirectory(at: SavedTestsURL, includingPropertiesForKeys: nil)
            
            
            for testFile in files where testFile.pathExtension == "deltaTest" {
                
                let test = testFile.lastPathComponent
                
                var testName: String {
                    
                    var testChars: [Character] = Array(test).reversed()
                    
                    
                    
                    var pathExtension: String = ""
                    
                    var foundTestName: Bool = false
                    
                 
                    
                    while foundTestName == false {
                        
                        guard 0 < testChars.count - 1 else {
                            
                            return testChars.reversed().description
                        }
                        
                        let character = testChars[0]
                        
                        pathExtension += character.description
                        testChars.remove(at: 0)
                        
                        if pathExtension == "tseTatled." {// .deltaTest but reversed
                            foundTestName = true
                        }
                        
                    }
                    
                    
                    var finalTestName: String = ""
                    
                    testChars.reverse()
                    
                    for char in testChars {
                        finalTestName += char.description
                    }
                    return finalTestName
                }
                
                
                allTestNames.append(testName)
            }
            
        } catch {
            print("failed")
        }
        
        allTestNames.sort(by: >)
        
        self.allTestNames = allTestNames
        
       
    }
    
    func findURLinAppSupport(_ url: URL? = nil) -> URL {
        
        let fileManager = FileManager.default
        
        guard var appSupportURL = fileManager.urls(for: .applicationSupportDirectory, in: .userDomainMask).first else {
            fatalError("Failed to find app support.")
        }
        
        if let actualURL = url {
            appSupportURL = appSupportURL.appendingPathComponent(actualURL.path)
        }
        
        return appSupportURL
        
    }
    
}

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



extension TestManager {
    //what does it mean
    
   
    
    func saveTest() {
        savedTest = false
        //MARK: FIX THIS
        
        // each package should add the extra discription
        
        //MARK: Converting the Questions into descriptions of them.
        let tempAllQuestions = allQuestions.map{DescriptionOfQuestion(question: $0)}
        let tempStashOfAllQuestions = stashOfAllQuestions.map{DescriptionOfQuestion(question: $0)}
        let tempAllQuestionsWrong = allQuestionsWrong.map{DescriptionOfQuestion(question: $0)}
        let tempAllQuestionsCorrect = allQuestionsCorrect.map{DescriptionOfQuestion(question: $0)}
        
        /*var tempPreviousQuestion: DescriptionOfQuestion?
        
        if previousQuestion != nil {
         tempPreviousQuestion = DescriptionOfQuestion(question: previousQuestion!)
        } else {
         tempPreviousQuestion = nil
        }

        var tempCurrentQuestion: DescriptionOfQuestion?
        
        if currentQuestion != nil {
            tempCurrentQuestion = DescriptionOfQuestion(question: currentQuestion!)
        } else {
            tempCurrentQuestion = nil
        }
         */
        
        let tempQuestionsSuggested = questionsSuggested.map{DescriptionOfQuestion(question: $0)}
        
        
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

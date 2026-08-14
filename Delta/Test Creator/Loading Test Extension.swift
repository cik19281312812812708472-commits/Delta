//
//  Loading Test Extension.swift
//  Delta
//
//  Created by Desire on 2026-06-29.
//

import Foundation
import TestCreation

extension TestManager {
    
    
    func findTestName(_ test: String) -> String {
        
           
           var testChars: [Character] = Array(test).reversed()
           
           
           
           var pathExtension: String = ""
           
           var foundTestName: Bool = false
           
        
           
           while foundTestName == false {
               
               guard 0 < testChars.count - 1 else {
                   
                   return (testChars.reversed().description)
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
    
    
    func loadTestData(name: String, _ url: URL? = nil) {
        
        
        let bundleID = Bundle.main.bundleIdentifier ?? "Delta"
        let savedTestsURL = findURLinAppSupport().appendingPathComponent(bundleID).appendingPathComponent("SavedTests")
        
        var test: Test? = nil
        
        if url == nil {
            do {
                print("here")
                let files = try FileManager.default.contentsOfDirectory(at: savedTestsURL, includingPropertiesForKeys: nil)
                print("allFiles: ", files)
                for testFile in files where testFile.pathExtension == "deltaTest" {
                    
                    let testName = findTestName(testFile.lastPathComponent)
                    print(testName)
                    if testName == name {
                        if let testJSON = try? (Data(contentsOf: testFile)) {
                            let testData = try JSONDecoder().decode(Test.self, from: testJSON)
                            
                            test = testData
                            
                            
                        }
                    }
                    
                }
                
            } catch {
                print("failed")
            }
        } else {
            do {
                let testFile = url
                if let testJSON = try? (Data(contentsOf: testFile!)) {
                    let testData = try JSONDecoder().decode(Test.self, from: testJSON)
                    
                    test = testData
                    
                }
            } catch {
                
            }
        }
        loadedTest = test
        
    }
    
    ///This function sets the apps current test data to "loadedTest"'s test data. so the loaded tests is saved in a seperate variable. this function actual sets the vars from tthat var.
     func loadTest() {
        
        if let test: Test = self.loadedTest {
            
            testName = test.name
            stashOfAllQuestionsMarks = test.stashOfAllQuestionsMarks
            startedTest = test.startedTest
            currentQuestionNumber = test.currentQuestionNumber
            
            var tempPackagesSelected: [UUID] = []
            
            func loadQuestion(_ question: DescriptionOfQuestion) -> Question {
                let creatorInternalName = question.creatorInternalName
                
                var trueQuestion = Question.getNullQuestion()
                
                for i in 0..<appManager.allPackages.count {
                    
                    let package = appManager.allPackages[i]
                    print(creatorInternalName, package.id, " is ", package.internalName == creatorInternalName)
                    if package.internalName == creatorInternalName {
                        trueQuestion = appManager.allPackages[i].loadQuestion(descriptionOfQuestion: question)
                        
                        
                        if !tempPackagesSelected.contains(package.id) {
                            tempPackagesSelected.append(package.id)
                        }
                        
                        
                    }
                    
                    
                }
                
                return trueQuestion
            }
            
            var trueAllQuestions: [Question] = []
            
            for question in test.allQuestions {
                trueAllQuestions.append(loadQuestion(question))
            }
            
            var trueAllQuestionsWrong: [Question] = []
            
            for question in test.allQuestionsWrong {
                trueAllQuestionsWrong.append(loadQuestion(question))
            }
            
            var trueStashOfAllQuestions: [Question] = []
            
            for question in test.stashOfAllQuestions {
                trueStashOfAllQuestions.append(loadQuestion(question))
            }
            
            var trueAllQuestionsCorrect: [Question] = []
            
            for question in test.allQuestionsCorrect {
                trueAllQuestionsCorrect.append(loadQuestion(question))
            }
            
            var trueQuestionsSuggested: [Question] = []
            
            for question in test.questionsSuggested {
                trueQuestionsSuggested.append(loadQuestion(question))
            }
            
            
            // - Adding all Packages selected to the global variable
            
            packagesSelected = tempPackagesSelected
            
            print("packages selected ", packagesSelected)
            
            
            // - Starting the test
            //Some vars are reset here
            if test.startedTest == true {
                 startTest()
            }
            
            // - Actually setting the variables:
            
            allQuestionsCorrect = trueAllQuestionsCorrect
            
            questionsSuggested = trueQuestionsSuggested
            
            if let testPreviousQuestion = test.previousQuestion {
                previousQuestion = loadQuestion(testPreviousQuestion)
            } else {
                previousQuestion = nil
            }
         
            if let testCurrentQuestion = test.currentQuestion {
                currentQuestion = loadQuestion(testCurrentQuestion)
            } else {
                currentQuestion = nil
            }
            
            stashOfAllQuestionsMarks = test.stashOfAllQuestionsMarks
            
            allQuestions = trueAllQuestions
            
            allQuestionsWrong = trueAllQuestionsWrong
            
            stashOfAllQuestions = trueStashOfAllQuestions
            
            testName = test.name
            
        }
        
    }
    
    
    
    
}

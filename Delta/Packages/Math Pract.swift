//
//  Math Pract.swift
//  Delta
//
//  Created by Desire on 2026-06-18.
//

import TestCreation
import Combine

class MathPract: Package {
    var publicName: String = "Math Practise"
    
    var internalName: String = ""
    
    var packageDescription: String = ""
    
    var id: UUID = UUID(uuidString: "2B8AC398-E2BC-478A-869B-B78FB0ED3753")!
    
    var allChangbleBools: [TestCreation.boolSetting] = []
    
    var allChangbleInts: [TestCreation.intSetting] = [intSetting(int: 0, name: "Num of Questions")]
    
    var allChangbleDoubles: [TestCreation.doubleSetting] = []
    
    var allQuestions: [Question] = []
    
    var allOmmittedQuestions: [String] = []
    
    func updateInternalSettings() {
        
        allOmmittedQuestions = []
        
        for setting in allChangbleBools {
            if setting.bool == true {
                
                
                var settingName: [Character] = Array(setting.name)
                
                for _ in 0..<16 {
                    settingName.remove(at: 0)
                  
                }
                settingName.remove(at: settingName.count - 1)
          
                var trueSettingName = ""
                
                for character in settingName {
                    trueSettingName += character.description
                }
     
                allOmmittedQuestions.append(trueSettingName)
            }
        }
    }
    
    init() {
        setup()
    }
    
    func setup() {
        loadAllQuestions()
        
        var allQuestion: [lightQuestion] = []
        
        for lightQuestion in allPossibleQuestions.allCases {
            allQuestion.append(lightQuestion.lightQuestion)
        }
        
        print(allQuestion)
        for question in allQuestion {
            
            let newBoolSetting = boolSetting(bool: false, name: "Ommit question \"\(question.questionWords)\"")
           // print(newBoolSetting)
            allChangbleBools.append(newBoolSetting)
            //print(allChangbleBools)
        }
        
        
        allChangbleInts[0].int = allQuestions.count
        
    }
    
    
    func createSection(numOfQuestions: Int) -> [TestCreation.Question] {
        loadAllQuestions()
        
        var allQuestion: [Question] = []
        
        for i in 0..<allChangbleInts[0].int {
            
            if i > allQuestions.count - 1 {
                allQuestions = allQuestions + allQuestions
            }
            
            var question = allQuestions[i]
            //this is here so that the id is not reused when the allQuestions is duplicated
            question.id = UUID()
            allQuestion.append(question)
        }
        return allQuestion
    }
    
    func createQuestion() -> TestCreation.Question {
        loadAllQuestions()
        return allQuestions.randomElement()!
    }
    
    func loadQuestion(descriptionOfQuestion: TestCreation.DescriptionOfQuestion) -> TestCreation.Question {
      createQuestion()
    }
    
    
    func loadAllQuestions() {
       
      
        var allQuestion: [Question] = []
        let allPossibleQuestions = allPossibleQuestions.allCases
        for questionCase in allPossibleQuestions {
            
            let lightQuestion = questionCase.lightQuestion
            
            guard !allOmmittedQuestions.contains(lightQuestion.questionWords) else { continue }
          
            let question = Question(creator: self.id, questionName: lightQuestion.questionWords, questionText: lightQuestion.questionDescription, questionContent: QuestionContent{Text(lightQuestion.questionWords)}, questionContentSizeX: 100, questionContentSizeY: 100, questionAnswer: lightQuestion.answer)
            
           
            
            allQuestion.append(question)
            
        }
        
        allQuestions = allQuestion
        
    }
    
    func filterAnswer(answer: String) -> String {
        return answer.lowercased()
    }
    
    enum allPossibleQuestions: CaseIterable {
    
        case regularPolygon
        case convexPolygon
        case concavePolygon
        case regularWithConvex
       
        case sumExterior
        case midPointDef
        case medianDef
        case midsegmentDef
        case diagonalDef
        case ExteriorWithInterior
        case parralelogramDiagonalProps
        case rectangleDiagonalProps
        case rhombusDiagonalProps
        case squareDiagonalProps
        case kiteDiagonalProps
        
        
        var lightQuestion: lightQuestion {
            switch self {
            case .regularPolygon:
                return .init(questionWords: "Regular Polygon", answer: "a polygon where all sides and all interior angles equal", questionDescription: "Define:")
            case .convexPolygon:
                return .init(questionWords: "Convex polygon", answer: "a polygon with all interior angles measuring less than 180°", questionDescription: "Define:")
            case .concavePolygon:
                return .init(questionWords: "Concave polygon", answer: "a polygon with at least one angle measuring more than 180°", questionDescription: "Define:")
            case .regularWithConvex:
                return .init(questionWords: "All regular polygons are ___", answer: "convex polygons", questionDescription: "Fill in the blank:")
            case .sumExterior:
                return  .init(questionWords: "What is the sum of all exterior angles in all polygons?", answer: "360°", questionDescription: "Answer the Question:")
            case .ExteriorWithInterior:
                return .init(questionWords: "Exterior and Interior angles add to?", answer: "180°", questionDescription: "Answer the Question:")
            case .midPointDef:
                return .init(questionWords: "Midpoint", answer: "The middle of a line", questionDescription: "Define:")
            case .medianDef:
                return .init(questionWords: "Median", answer: "the line joining a vertex to the midpoint on the oppisite side.", questionDescription: "Define:")
            case .midsegmentDef:
                return .init(questionWords: "Midsegment", answer: "a line segment that joins the midpoints of two consecutive sides of a polygon", questionDescription: "Define:")
            case .diagonalDef:
                return .init(questionWords: "Diagonal", answer: "a line segment that joins two non-consecutive (non-adjacent) vertices of a polygon", questionDescription: "Define:")
            case .parralelogramDiagonalProps:
                return .init(questionWords: "Parrelelogram", answer: "bisect each other", questionDescription: "What are the Diagonal Properties of this shape:")
            case .rectangleDiagonalProps:
                return .init(questionWords: "Rectangle", answer: "bisect each other, are equal in length", questionDescription: "What are the Diagonal Properties of this shape:")
            case .rhombusDiagonalProps:
                return .init(questionWords: "Rhombus", answer: "bisect each other, are perpendicular, bisect vertex angles", questionDescription: "What are the Diagonal Properties of this shape:")
            case .squareDiagonalProps:
                return .init(questionWords: "Square", answer: "bisect each other, are equal in length, are perpendicular, bisect vertex angles", questionDescription: "What are the Diagonal Properties of this shape:")
            case .kiteDiagonalProps:
                return .init(questionWords: "Kite", answer: "are perpendicular", questionDescription: "What are the Diagonal Properties of this shape:")
            }
        }
        
    }
    
    
    
}

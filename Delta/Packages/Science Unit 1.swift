//
//  Science Unit 1.swift
//  Delta
//
//  Created by Desire on 2026-05-01.
//


import TestCreation
import Combine


class ScienceUnit1: Package, ObservableObject {
    
    var publicName: String = "Science Unit 1"
    
    var internalName: String = "scienceUnit1"
    
    var packageDescription: String = ""
    
    var id = UUID()
    
    @Published var allChangbleBools: [boolSetting] = [boolSetting(bool: false, name: "Randomize questions?")]
    
    @Published var numberOfQuestionsMadePerSection: Int = 10
    
    @Published var allChangbleInts: [intSetting] = [intSetting(int: 10, name: "Number of questions per section")]
    
    @Published var allChangbleDoubles: [doubleSetting] = []
  
    var alllightQuestions: [lightQuestion] = []
    var randomizeQuestions: Bool = false
    var generatedAllLightQuestions: Bool = false
    var questionNum: Int = 0
    
   
    
    func updateInternalSettings() {
        numberOfQuestionsMadePerSection = allChangbleInts[0].int
        randomizeQuestions = allChangbleBools[0].bool
    }
    
    func createSection(numOfQuestions: Int) -> [TestCreation.Question] {
        
        
        var allQuestions: [Question] = []
        
        for i in 0..<numberOfQuestionsMadePerSection {
            allQuestions.append(createQuestion())
        }
        questionNum = 0
        return allQuestions
        
        
        
     
    }
    
    func loadAllQuestions() -> [lightQuestion] {
        
        var allQuestionsLoaded: [lightQuestion] = []
        
        for question in allQuestions.allCases {
            
            let newQuestion = question.lightQuestion
            allQuestionsLoaded.append(newQuestion)
            
        }
        
        
        
        if generatedAllLightQuestions == false {
            generatedAllLightQuestions = true
            alllightQuestions = allQuestionsLoaded
        } else {
            allQuestionsLoaded = alllightQuestions
        }
        
        if randomizeQuestions == true {
            allQuestionsLoaded.shuffle()
        }
        
        
        return allQuestionsLoaded
    }
    
    func createQuestion() -> TestCreation.Question {
        
        let questionNum = (questionNum > loadAllQuestions().count - 1 ? 0 : questionNum)
        
        if self.questionNum > loadAllQuestions().count - 1 {
            self.questionNum = 0
        }
        
        
        let lightQuestion = loadAllQuestions()[questionNum]
        
        let questionContent = QuestionContent { AnyView (VStack {    }) }
        
        
        let trueQuestion = Question(questionText: lightQuestion.questionWords, questionContent: questionContent, questionContentSizeX: 500, questionContentSizeY: 500, questionAnswer: lightQuestion.answer)
        
        self.questionNum += 1
        return trueQuestion
    }
   
    enum allQuestions: CaseIterable {
        
        
        case astronomyDef
        case asterismDef
        case solarwindDef
        case helioCentricDef
        case heliaCentricTheoryDef
        case apparentMagnitudeDef
        case planisphere
        case starMass
        case fusionDef
        case spectroscopeDef
        case spectroscope
        
        
        var questionWords: String {
            switch self {
            case .astronomyDef:
                return "What is the definition of Astronomy?"
            case .asterismDef:
                return "What is an Asterism?"
            case .solarwindDef:
                return "What is solar wind?"
            case .helioCentricDef:
                return "What does heliocentric mean?"
            case .heliaCentricTheoryDef:
                return "What is the helio Centric theory?"
            case .apparentMagnitudeDef:
                return "What is the definition of Apparent Magnitude?"
            case .planisphere:
                return "What is nessecary for a planisphere to work?"
            case .starMass:
                return "Is the mass of a star constant? and why?"
            case .fusionDef:
                return "What is fusion?"
            case .spectroscopeDef:
                return "What is a spectroscope?"
            case .spectroscope:
                return "What does a spectroscope do?"
            }
        }
        
        var answer: String {
            switch self {
            case .astronomyDef:
                "The study of celestial objects"
            case .asterismDef:
                "A star pattern that is not a constellation"
            case .solarwindDef:
                "Small particles emitted by the sun."
            case .helioCentricDef:
                "Heliocentric means “centered around the sun” in astronomy."
            case .heliaCentricTheoryDef:
                "Heliocentric is a theory that the planets revolve around the sun."
            case .apparentMagnitudeDef:
                "The apparent brightness of objects in space when viewed from earth."
            case .planisphere:
                "The right lattitude and longitude is nessecary."
            case .starMass:
                "No, because it's mass is used to make light."
            case .fusionDef:
                "//ANSWER NOT FINISHED//"
            case .spectroscopeDef:
                "A spectroscope is an instrument that separates the light of a luminous object into different wave lengths."
            case .spectroscope:
                "it separates the light of a luminous object into different wave lengths."
            }
        }
        
        var lightQuestion: lightQuestion {
            
            return .init(questionWords: self.questionWords, answer: self.answer)
            
        }
    }
    
    
    
    
    
}





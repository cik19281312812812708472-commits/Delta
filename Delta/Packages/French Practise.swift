//
//  Untitled.swift
//  Delta
//
//  Created by Desire on 2026-05-26.
//

import TestCreation
import Combine

class FrenchPractise: Package {
    
    var publicName: String = "French Practise"
    
    var internalName: String = "FrenchPractise"
    
    var packageDescription: String = ""
    
    var id: UUID = UUID()
    
    var allChangbleBools: [TestCreation.boolSetting] = []
    
    var allChangbleInts: [TestCreation.intSetting] = [intSetting(int: 50, name: "numberOfQuestions")]
    
    var allChangbleDoubles: [TestCreation.doubleSetting] = []
    
    var allQuestions: [Question] = []
    var createdAllQuestions: Bool = false
    var createdAllSettings: Bool = false
    
    func updateInternalSettings() {
        if allChangbleInts[0].int < 0 {
            allChangbleInts[0].int = 0
        }
    }
    
    func filterAnswer(answer: String) -> String {
        return answer.lowercased()
    }
    
    func createRestofSettings() {
        
      
            for question in allQuestions {
                
                let newBoolSetting = boolSetting(bool: false, name: "Ommit question \"\(question.questionText)\"")
               // print(newBoolSetting)
                allChangbleBools.append(newBoolSetting)
                //print(allChangbleBools)
            }
          
        
    }
    func setup() {
        createAllQuestions()
        createRestofSettings()
    }
    init() {
        setup()
    }
    
    
    func createAllQuestions() {
        
        
        for question in allQuestionTypes.allCases {
           
            let theQuestion = question.Question
            
            let content = QuestionContent {}
            
            let trueQuestion = Question(creator: self.id, questionText: "Conjugate: \(theQuestion.Verb) | for \(theQuestion.Noun)", questionContent: content, questionContentSizeX: 0, questionContentSizeY: 0, questionAnswer: theQuestion.Answer)
            
            
            allQuestions.append(trueQuestion)
            
            
        }
        createdAllQuestions = true
    }
    
    func createSection(numOfQuestions: Int) -> [TestCreation.Question] {
        
    
        
        
        
        var section: [Question] = []
        
        var finishedCreatingSection = false
        var i = 0
        var actualIndex = 0
        while finishedCreatingSection == false {
            
            if i > allQuestions.count - 1 {
                i = 0
            }
            if actualIndex > allChangbleInts[0].int {
                finishedCreatingSection = true
            }
            
            
            
            guard allChangbleBools[i].bool == true else {
                section.append(allQuestions[i])
                continue
            }
            
            
            i += 1
            actualIndex += 1
        }
        
        
        
        
        
        
        
        return section
    }
    
    func createQuestion() -> TestCreation.Question {
        
        return allQuestions.randomElement()!
    }
    
    
    
    struct conjugationQuestion {
        var Verb: String
        var Noun: String
        var Answer: String
        
        init(Verb: String, Noun: String, Answer: String) {
            self.Verb = Verb
            self.Noun = Noun
            self.Answer = Answer
        }
    }
    
    
    
    
    enum allQuestionTypes: CaseIterable {
        
        case DevoirJe
        case DevoirTu
        case DevoirIl
        case DevoirElle
        case DevoirOn
        case DevoirIls
        case DevoirElles
        case DevoirNous
        case DevoirVous

        case PouvoirJe
        case PouvoirTu
        case PouvoirIl
        case PouvoirElle
        case PouvoirIls
        case PouvoirElles
        case PouvoirOn
        case PouvoirNous
        case PouvoirVous
        
        case VouloirJe
        case VouloirTu
        case VouloirIl
        case VouloirElle
        case VouloirOn
        case VouloirIls
        case VouloirElles
        case VouloirNous
        case VouloirVous
        
        case AvoirJe
        case AvoirTu
        case AvoirIl
        case AvoirNous
        case AvoirVous
        case AvoirElles
        
        case pu
        case du
        case voulu
        case ete
        
        case AllerJe
        case AllerTu
        case AllerIl
        case AllerNous
        case AllerVous
        case AllerElles
        
        case EtreJe
        case EtreTu
        case EtreIl
        case EtreElle
        case EtreOn
        case EtreNous
        case EtreVous
        case EtreIls
        case EtreElles
        
        var Question: conjugationQuestion {
            switch self {
            case .DevoirJe:
                   return .init(Verb: "Devoir", Noun: "Je", Answer: "dois")
            case .DevoirTu:
                return .init(Verb: "Devoir", Noun: "Tu", Answer: "dois")
            case .DevoirIl:
                return .init(Verb: "Devoir", Noun: "Il", Answer: "doit")
            case .DevoirElle:
                return .init(Verb: "Devoir", Noun: "Elle", Answer: "doit")
            case .DevoirOn:
                return .init(Verb: "Devoir", Noun: "On", Answer: "doit")
            case .DevoirIls:
                return .init(Verb: "Devoir", Noun: "Ils", Answer: "doivent")
            case .DevoirElles:
                return .init(Verb: "Devoir", Noun: "Elles", Answer: "doivent")
            case .DevoirNous:
                return .init(Verb: "Devoir", Noun: "Nous", Answer: "devons")
            case .DevoirVous:
                return .init(Verb: "Devoir", Noun: "Vous", Answer: "devez")
            case .PouvoirJe:
                return .init(Verb: "Pouvoir", Noun: "Je", Answer: "peux")
            case .PouvoirTu:
                return .init(Verb: "Pouvoir", Noun: "Tu", Answer: "peux")
            case .PouvoirIl:
                return .init(Verb: "Pouvoir", Noun: "Il", Answer: "peut")
            case .PouvoirElle:
                return .init(Verb: "Pouvoir", Noun: "Elle", Answer: "peut")
            case .PouvoirIls:
                return .init(Verb: "Pouvoir", Noun: "Ils", Answer: "peuvent")
            case .PouvoirElles:
                return .init(Verb: "Pouvoir", Noun: "Elles", Answer: "peuvent")
            case .PouvoirOn:
                return  .init(Verb: "Pouvoir", Noun: "On", Answer: "peut")
            case .PouvoirNous:
                 return     .init(Verb: "Pouvoir", Noun: "Nous", Answer: "pouvons")
            case .PouvoirVous:
                return    .init(Verb: "Pouvoir", Noun: "Vous", Answer: "pouvez")
            case .VouloirJe:
                return    .init(Verb: "Vouloir", Noun: "Je", Answer: "veux")
            case .VouloirTu:
                 return     .init(Verb: "Vouloir", Noun: "Tu", Answer: "veux")
            case .VouloirIl:
                 return     .init(Verb: "Vouloir", Noun: "Il", Answer: "veut")
            case .VouloirElle:
                  return      .init(Verb: "Vouloir", Noun: "Elle", Answer: "veut")
            case .VouloirOn:
                   return       .init(Verb: "Vouloir", Noun: "On", Answer: "veut")
            case .VouloirIls:
                  return      .init(Verb: "Vouloir", Noun: "Ils", Answer: "veulent")
            case .VouloirElles:
                  return      .init(Verb: "Vouloir", Noun: "Elles", Answer: "veulent")
            case .VouloirNous:
                   return       .init(Verb: "Vouloir", Noun: "Nous", Answer: "voulons")
            case .VouloirVous:
                   return       .init(Verb: "Vouloir", Noun: "Vous", Answer: "voulez")
            case .AvoirJe:
                   return       .init(Verb: "Avoir", Noun: "Je", Answer: "ai")
            case .AvoirTu:
                   return       .init(Verb: "Avoir", Noun: "Tu", Answer: "as")
            case .AvoirIl:
                   return       .init(Verb: "Avoir", Noun: "Il/Elle/On", Answer: "a")
            case .AvoirNous:
                   return       .init(Verb: "Avoir", Noun: "Nous", Answer: "avons")
            case .AvoirVous:
                   return       .init(Verb: "Avoir", Noun: "Vous", Answer: "avez")
            case .AvoirElles:
                   return       .init(Verb: "Avoir", Noun: "Ils/Elles", Answer: "ont")
            case .pu:
                   return       .init(Verb: "Pouvoir", Noun: "Passe Composée", Answer: "pu")
            case .du:
                   return       .init(Verb: "Devoir", Noun: "Passe Composée", Answer: "dû")
            case .voulu:
                   return       .init(Verb: "Vouloir", Noun: "Passe Composée", Answer: "voulu")
            case .ete:
                   return       .init(Verb: "Etre", Noun: "Passe Composée", Answer: "été")
            case .AllerJe:
                   return       .init(Verb: "Aller", Noun: "Je", Answer: "vais")
            case .AllerTu:
                   return       .init(Verb: "Aller", Noun: "Tu", Answer: "vas")
            case .AllerIl:
                   return       .init(Verb: "Aller", Noun: "Il/Elle/On", Answer: "va")
            case .AllerNous:
                   return       .init(Verb: "Aller", Noun: "Nous", Answer: "allons")
            case .AllerVous:
                   return       .init(Verb: "Aller", Noun: "Vous", Answer: "allez")
            case .AllerElles:
                   return       .init(Verb: "Aller", Noun: "Ils/Elles", Answer: "vont")
            case .EtreJe:
                   return       .init(Verb: "Etre", Noun: "Je", Answer: "suis")
            case .EtreTu:
                   return       .init(Verb: "Etre", Noun: "Tu", Answer: "es")
            case .EtreIl:
                   return       .init(Verb: "Etre", Noun: "Il", Answer: "est")
            case .EtreElle:
                   return       .init(Verb: "Etre", Noun: "Elle", Answer: "est")
            case .EtreOn:
                   return       .init(Verb: "Etre", Noun: "On", Answer: "est")
            case .EtreNous:
                   return       .init(Verb: "Etre", Noun: "Nous", Answer: "sommes")
            case .EtreVous:
                   return       .init(Verb: "Etre", Noun: "Vous", Answer: "êtes")
            case .EtreIls:
                   return       .init(Verb: "Etre", Noun: "Ils", Answer: "sont")
            case .EtreElles:
                   return       .init(Verb: "Etre", Noun: "Elles", Answer: "sont")
            }
        }
    }
        
    
}

//
//  Periodic table.swift
//  Delta
//
//  Created by Desire on 2026-06-17.
//

import TestCreation
import Combine

class PeriodicTable: Package {
    
    var publicName: String = "Periodic Table"
    
    var internalName: String = ""
    
    var packageDescription: String = "Periodic table"
    
    var id: UUID = UUID()
    
    var allChangbleBools: [TestCreation.boolSetting] = []
    
    var allChangbleInts: [TestCreation.intSetting] = [intSetting(int: 15, name: "Num of Questions", description: "the number of questions")]
    
    var allChangbleDoubles: [TestCreation.doubleSetting] = []
    
    var loadedAllQuestions: Bool = false
    
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
    
    func setup() {
        loadAllQuestions()
        
        var allQuestion: [lightQuestion] = []
        
        for lightQuestion in allPossibleQuestions.allCases {
            allQuestion.append(lightQuestion.lightQuestion)
        }
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
         
            var question = Question(creator: self.id, questionName: lightQuestion.questionWords, questionText: "What is the defining feature of this Group?", questionContent: QuestionContent{Text(lightQuestion.questionWords)}, questionContentSizeX: 100, questionContentSizeY: 100, questionAnswer: lightQuestion.answer)
            
            question.id = UUID()
            allQuestion.append(question)
            
        }
        
        allQuestions = allQuestion
        if allQuestions[allQuestions.count - 1].questionName == "Alkali" {print("yes")}
    }
    
    
    enum allPossibleQuestions: CaseIterable {
        case alkali
        case alkaline
        case metals
        case Metalloids
        case Halogens
        case gases
        case Lanthanide
        case Actinide
        case neutronElementSymbol
        case neutronMass
        case atomicRaduis
        case IonizationEnergy
        case Electronegativity
        case ElectronAffinity
        case meltingPoint
        case reactivity
        case ion
        case ionicBond
        case ionicCompound
        case ionicProps
        case covalentBond
        case molecularCompound
        case mono
        case di
        case tri
        case tetra
        case penta
        case hexa
        case hepta
        case octa
        case nona
        case deca
        case molecularProps
        case HR
        
        var lightQuestion: lightQuestion {
            switch self {
            case .alkali:
                return .init(questionWords: "Alkali", answer: "very reactive")
            case .alkaline:
                return .init(questionWords: "alkaline", answer: "reactive")
            case .metals:
                return .init(questionWords: "Transition Metals", answer: "very hard metals with very high melting points")
            case .Metalloids:
                return .init(questionWords: "Metalloids", answer: "mixed metal/non-metal properties")
            case .Halogens:
                return .init(questionWords: "Halogens", answer: "reactive non-metals")
            case .gases:
                return .init(questionWords: "Noble Gases", answer: "completely unreactive")
            case .Lanthanide:
                return .init(questionWords: "Lanthanide Series", answer: "sometimes called rare earth metals")
            case .Actinide:
                return .init(questionWords: "Actinide Series", answer: "are radioactive")
            case .neutronElementSymbol:
                return .init(questionWords: "What is the Neutron Element Symbol?", answer: "n⁰")
            case .neutronMass:
                return .init(questionWords: "What is the mass of neutron in amu?", answer: "1 amu")
            case .atomicRaduis:
                return .init(questionWords: "Atomic Raduis", answer: "")
            case .IonizationEnergy:
                return .init(questionWords: "Ionization Energy ", answer: "energy needed to remove a valence e")
            case .Electronegativity:
                return .init(questionWords: "Electronegativity ", answer: "the ability of an atom to attract shared electrons")
            case .ElectronAffinity:
                return .init(questionWords: "Electron Affinity ", answer: "the energy absorbed or released when an e- is added to a neutral, gaseous atom")
            case .meltingPoint:
                return .init(questionWords: "Melting Point ", answer: "")
            case .reactivity:
                return .init(questionWords: "reactivity", answer: "")
            case .ion:
                return .init(questionWords: "ion", answer: "a charged particle that formerly lost or gained electrons")
            case .ionicBond:
                return .init(questionWords: "Ionic Bond", answer: "a chemical bond that forms between oppositely charged ions")
            case .ionicCompound:
                return .init(questionWords: "Ionic Compound", answer: "a compound held together by the charge difference caused by ionic bonds")
            case .ionicProps:
                return .init(questionWords: "Ionic Properties", answer: "1. usually solid physical state 2. highly soluble 3. highly conductive when dissolved")
            case .covalentBond:
                return .init(questionWords: "Covalent Bond", answer: "a chemical bond where e- are shared by two atoms")
            case .molecularCompound:
                return .init(questionWords: "Molecular Compound", answer: "a compound held together by covalent bonds")
            case .mono:
                return .init(questionWords: "prefix meaning one", answer: "mono-")
            case .di:
                return .init(questionWords: "prefix meaning two", answer: "di-")
            case .tri:
                return .init(questionWords: "prefix meaning three", answer: "tri-")
            case .tetra:
                return .init(questionWords: "prefix meaning four", answer: "tetra-")
            case .penta:
                return .init(questionWords: "prefix meaning five", answer: "penta-")
            case .hexa:
                return .init(questionWords: "prefix meaning six", answer: "hexa-")
            case .hepta:
                return .init(questionWords: "prefix meaning seven", answer: "hepta-")
            case .octa:
                return .init(questionWords: "prefix meaning eight", answer: "octa-")
            case .nona:
                return .init(questionWords: "prefix meaning nine", answer: "nona-")
            case .deca:
                return .init(questionWords: "prefix meaning ten", answer: "deca-")
            case .molecularProps:
                return .init(questionWords: "Molecular Compound Properties", answer: "1. no generalizable physical state 2. low solubility 3. poor conductivity")
            case .HR:
                return .init(questionWords: "A HR Diagram Graphs", answer: "luminosity and temperature")
            }
        }
        
    }
    
    func filterAnswer(answer: String) -> String {
        return answer.lowercased()
    }
    
    
    init() {
        setup()
    }
    
    
    
    
    
}

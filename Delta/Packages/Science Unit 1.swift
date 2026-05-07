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
    
    @Published var numberOfQuestionsMadePerSection: Int = 37
    
    @Published var allChangbleInts: [intSetting] = [intSetting(int: 37, name: "Number of questions per section")]
    
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
        case smallerStarTemp
        case directionStarsTurnInTheNightSky
        case rotationAndRevolution
        case HRdiagram
        case HRdiagromShows
        case determiningOfEarthsDays
        case starDef
        case tiltOfEarth
        case spectraDef
        case solarSystemMnemonic
        case determiningOfAYear
        //Ai will be needed for explinations but definitions will do
        case fissionDef
        case parsecDef
        case magnetoSphereJob
        case terrestialPlanetsDef
        case solarFlaresDef
        case meteorDef
        case meteoriteDef
        case cometDef
        case lightYearDef
        case starTemp
        case lowMassStarDef
        case intermediateStarDef
        case highMassStarDef
        case highMassStarLifetime
        case geoCentricDef
        case solarMassDef
        case hemispheresOfTheEarth
        case lattitudeDef
        case longitudeDef
        case causationOfSolarFlares
        case sunSpotDef
        case earthPerfectForLife
        case sixeLayersOfSun
         
        
        
        
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
            case .smallerStarTemp:
                return "In relation to other stars are small stars cool or hot?"
            case .directionStarsTurnInTheNightSky:
                return "What direction do stars turn in the sky, when facing north and what about the south pole?"
            case .rotationAndRevolution:
                return "What is the difference between a rotation and a revolution?"
            case .HRdiagram:
                return "What is a HR diagram?"
            case .HRdiagromShows:
                return "What does a HR diagram show?"
            case .determiningOfEarthsDays:
                return "How are earth’s days determined?"
            case .starDef:
                return "What is the definition of a star?"
            case .tiltOfEarth:
                return "How much is the earth tilted by?"
            case .spectraDef: //MARK: ADD SPECTRUM DEF
                return "What is a spectra?"
            case .solarSystemMnemonic:
                return "Name a mnemonic for the solar system."
            case .determiningOfAYear:
                return "How is an Earth year determined?"
            case .fissionDef:
                return "What is the definition of fission?"
            case .parsecDef:
                return "What is a parsec?"
            case .magnetoSphereJob:
                return "What does the magnetosphere protect us from?"
            case .terrestialPlanetsDef:
                return "What are terrestrial planets?"
            case .solarFlaresDef:
                return "What are solar flares?"
            case .meteorDef:
                return "What is a meteor?"
            case .meteoriteDef:
                return "What is a meteorite?"
            case .cometDef:
                return "What is a comet?"
            case .lightYearDef:
                return "What is the definition of a light year?"
            case .starTemp:
                return "If a star is blue how hot is it?(answer like: cold, warm, hot, very hot)"
            case .lowMassStarDef:
                return "What are low mass stars?"
            case .intermediateStarDef:
                return "What are intermediate stars?"
            case .highMassStarDef:
                return "What are High mass stars?"
            case .highMassStarLifetime:
                return "How long do high mass stars live?"
            case .geoCentricDef:
                return "What is the definition of geocentric?"
            case .solarMassDef:
                return "What is a solar mass?"
            case .hemispheresOfTheEarth:
                return "What are all the hemispheres of earth?"
            case .lattitudeDef:
                return "What is latitude?"
            case .longitudeDef:
                return "What is longitude?"
            case .causationOfSolarFlares:
                return "How do solar flares happen?"
            case .sunSpotDef:
                return "What are sun spots?"
            case .earthPerfectForLife:
                return "What made earth perfecteft for liv?"
            case .sixeLayersOfSun:
                return "what are teh six laywers of the sun?"
            }
        }
        
        var answer: String {
            switch self {
            case .astronomyDef:
               return "The study of celestial objects"
            case .asterismDef:
                return "A star pattern that is not a constellation"
            case .solarwindDef:
                return "Small particles emitted by the sun."
            case .helioCentricDef:
                return "Heliocentric means “centered around the sun” in astronomy."
            case .heliaCentricTheoryDef:
                return "Heliocentric is a theory that the planets revolve around the sun."
            case .apparentMagnitudeDef:
                return "The apparent brightness of objects in space when viewed from earth."
            case .planisphere:
                return "The right lattitude and longitude is nessecary."
            case .starMass:
                return "No, because it's mass is used to make light."
            case .fusionDef:
                return "//ANSWER NOT FINISHED//"//MARK: ANSWER NOT FINISHED
            case .spectroscopeDef:
                return "A spectroscope is an instrument that separates the light of a luminous object into different wave lengths."
            case .spectroscope:
                return "it separates the light of a luminous object into different wave lengths."
            case .smallerStarTemp:
                return "Generally they are cooler."
            case .directionStarsTurnInTheNightSky:
                return "North: counterclockwise. South: clockwise."
            case .rotationAndRevolution:
                return "A rotation is a direct change in an object's direction and a revolution is the act of moving around another object, often in a circle."
            case .HRdiagram:
                return "A HR diagram is a diagram of the luminosity and temperature of stars that can be used to classify them."
            case .HRdiagromShows:
                return "It shows the luminosity and temperature of various stars."
            case .determiningOfEarthsDays:
                return "Via the rotation of the Earth."
            case .starDef:
                return "A star is a big ball of plasma floating in outer space, undergoing fusion, that is held under its own gravity."
            case .tiltOfEarth:
                return "23.5 degrees"
            case .spectraDef:
                return "A spectrum but in plural."
            case .solarSystemMnemonic:
                return "//ANSWER NOT FINISHED//"//MARK: ANSWER NOT FINISHED
            case .determiningOfAYear:
                return "A year is determined by the revolution of the earth around the sun."
            case .fissionDef:
                return "//ANSWER NOT FINISHED//"//MARK: ANSWER NOT FINISHED
            case .parsecDef:
                return "//ANSWER NOT FINISHED//"//MARK: ANSWER NOT FINISHED
            case .magnetoSphereJob:
                return "A magnetosphere protects us from the solar wind from the sun."
            case .terrestialPlanetsDef:
                return "Planets with rocky surfaces."
            case .solarFlaresDef:
                return "//ANSWER NOT FINISHED//"//MARK: ANSWER NOT FINISHED and fix
            case .meteorDef:
                return "//ANSWER NOT FINISHED//"//MARK: ANSWER NOT FINISHED
            case .meteoriteDef:
                return "//ANSWER NOT FINISHED//"//MARK: ANSWER NOT FINISHED
            case .cometDef:
                return "//ANSWER NOT FINISHED//"//MARK: ANSWER NOT FINISHED
            case .lightYearDef:
                return "The distance that light can travel in 1 year. "
            case .starTemp:
                return "very hot"
            case .lowMassStarDef:
                return "//ANSWER NOT FINISHED//"//MARK: ANSWER NOT FINISHED
            case .intermediateStarDef:
                return "//ANSWER NOT FINISHED//"//MARK: ANSWER NOT FINISHED
            case .highMassStarDef:
                return "//ANSWER NOT FINISHED//"//MARK: ANSWER NOT FINISHED
            case .highMassStarLifetime:
                return "//ANSWER NOT FINISHED//"//MARK: ANSWER NOT FINISHED
            case .geoCentricDef:
                return "//ANSWER NOT FINISHED//"//MARK: ANSWER NOT FINISHED
            case .solarMassDef:
                return "//ANSWER NOT FINISHED//"//MARK: ANSWER NOT FINISHED
            case .hemispheresOfTheEarth:
                return "The hemispheres of the earth are east, west, north and south."
            case .lattitudeDef:
                return "//ANSWER NOT FINISHED//"//MARK: ANSWER NOT FINISHED
            case .longitudeDef:
                return "//ANSWER NOT FINISHED//"//MARK: ANSWER NOT FINISHED
            case .causationOfSolarFlares:
                return "//ANSWER NOT FINISHED//"//MARK: ANSWER NOT FINISHED
            case .sunSpotDef:
                return "//ANSWER NOT FINISHED//"//MARK: ANSWER NOT FINISHED
            case .earthPerfectForLife:
                return "//ANSWER NOT FINISHED//"//MARK: ANSWER NOT FINISHED
            case .sixeLayersOfSun:
                return "//ANSWER NOT FINISHED//"//MARK: ANSWER NOT FINISHED
            }
        }
        
        var lightQuestion: lightQuestion {
            
            return .init(questionWords: self.questionWords, answer: self.answer)
            
        }
    }
    
    
    
    
    
}





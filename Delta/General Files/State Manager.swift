//
//  State Manger.swift
//  Delta
//
//  Created by Desire on 2026-04-26.
//

import Foundation
import Combine
import TestCreation

enum appStateBlueprint {
    
    case startingScreen
    case Tests
    case Packages
    
    
    
    var helpInfo: String {
        switch self {
        case .startingScreen:
            return "Click the \"Tests\" button to create a Test"
        case .Tests:
            return "."
        case .Packages:
            return "."
        }
        
    }
    
    
    
}

enum testStateBlueprint {
    
    case selectingPackages
   
    ///This is only meant for iOS macOS doesn't use this.
    ///This just 
    case testSettings
    
    //this is only meant for iOS
    case previewQuestions
   
    
    case runningTest
    case testEnded
   
    
    var helpInfo: String {
        switch self {
        case .selectingPackages:
            return """
    Please right click the packages to see their settings. You can also click to select a package. 
    Selecting a package will make it generate it's questions. Right click the questions to remove them.
    """
        case .testSettings:
            return ""
        case .runningTest:
            return ""
        case .testEnded:
            return ""
        case .previewQuestions:
            return ""
        }
    }
    
}

enum iOSTestSettingsStates {
    
    case showingQuestions
    
    
}



class AppManager: ObservableObject {
    
    ///This is here to make sure that the loading test window stays closed untill it is asked for.
    @Published var loadingTestWindowOpen: Bool = false
    
    @Published var appVersion: versionData_Type = versionData_Type(Major: 0, Minor: 2, Patch: 7)
    @Published var isLoading: Bool = false
    @Published var appState: appStateBlueprint = .Tests // .startingscreen MARK: Set this back
    //it should always set the test state to selecting packages at first
    @Published var testState: testStateBlueprint = .selectingPackages
    @Published var testCreationTestState: testStateBlueprint = .selectingPackages
    
    
    /// in teh furture this will be loaded from a JSON as of now i will manually add them.
    @Published var allPackages: [any Package] = [EnglishLitTerm(),  ScienceUnit1(), LinearSystemCreator(), ChemistryUnit1(), TrigonometryPackage(), PolynomialPackage(), AlgebraUnit1(), FrenchPractise(), NumberSetsUnit(), TriangleCentersPackage(), Geometry3DPackage(), PeriodicTable(), MathPract()
    
                                                 //examplePackage(), EuclideanGeo()
    ]
    
    
    func iOSSetup() {
        
        appState = .Tests
        
        
    }
    
    init() {
        self.allPackages.sort { $0.publicName < $1.publicName }
    }
    
    
}



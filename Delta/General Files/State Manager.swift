//
//  State Manger.swift
//  Delta
//
//  Created by Desire on 2026-04-26.
//

import Foundation
import Combine

enum appStateBlueprint {
    
    case startingScreen
    case Tests
    case Packages
    
    
    
    var helpInfo: String {
        switch self {
        case .startingScreen:
            return "Choose either to create a Test or to create a Flashcard Set."
        case .Tests:
            return "."
        case .Packages:
            return "."
        }
        
    }
    
    
    
}

enum testStateBlueprint {
    
    case selectingPackages
    case testSettings
    case runningTest
    case testEnded
   
    
    var helpInfo: String {
        switch self {
        case .selectingPackages:
            return "Please right click the packages to see their settings."
        case .testSettings:
            return ""
        case .runningTest:
            return ""
        case .testEnded:
            return ""
        }
    }
    
}





class AppManager: ObservableObject {
    
    @Published var isLoading: Bool = false
    @Published var appState: appStateBlueprint = .startingScreen
    //it should always set the test state to selecting packages at first
    @Published var testState: testStateBlueprint = .selectingPackages
    
    /// in teh furture this will be loaded from a JSON as of now i will manually add them.
    @Published var allPackages: [any Package] = [ examplePackage(), EnglishLitTerm(), EuclideanGeo()]
    
    
    
}



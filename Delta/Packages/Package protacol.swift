//
//  Package protacol.swift
//  Delta
//
//  Created by Desire on 2026-04-26.
//

import Foundation
import TestCreation
import SwiftUI
import Combine

///please move this to the test creation package.
protocol Package: ObservableObject, Identifiable {

    //Please put your internal name as  a let statement
    
    var publicName: String { get }
    var internalName: String { get }
    var packageDescription: String { get set }
    
    
    var id: UUID { get }
    
    
    var allChangbleBools: [boolSetting] { get set }
    var allChangbleInts: [intSetting] { get set }
    var allChangbleDoubles: [doubleSetting] { get set }
   
    
    //make a func call modify settings
    
   
    ///This function is required as it is to update the settings of your package after they have been updated in the UI.
    func updateInternalSettings()
    func createSection(numOfQuestions: Int) -> [Question]
    func createQuestion() -> Question
    
    //func answerFiltering() -> String
    
}
//for each package a custom view will be needed but for now 

extension Package {
    
    func changeABool(_ index: Int, to: Bool) {
        
        
        let currentIndexName: String = self.allChangbleBools[index].name
        let currentIndexID: UUID = self.allChangbleBools[index].id
        
        self.allChangbleBools[index] =  boolSetting(bool: to, name: currentIndexName, id: currentIndexID)
    }
    
    func changeAnInt(_ index: Int, to: Int) {
        
        let currentIndexName: String = self.allChangbleInts[index].name
        let currentIndexID: UUID = self.allChangbleInts[index].id
        
        self.allChangbleInts[index] = intSetting(int: to, name: currentIndexName, id: currentIndexID)
    }
    
    func changeADouble(_ index: Int, to: Double) {
        
        let currentIndexName: String = self.allChangbleDoubles[index].name
        let currentIndexID: UUID = self.allChangbleDoubles[index].id
        
        self.allChangbleDoubles[index] = doubleSetting(double: to, name: currentIndexName, id: currentIndexID)
    }
    
    
    
}


enum allChangbleTypes {
    case bool
    case int
    case double
}


struct boolSetting: Identifiable {
    
    var bool: Bool
    var name: String
    var id = UUID()
}

struct intSetting: Identifiable {
    
    var int: Int
    ///How do you see this?
    var tempIntString: String
    var name: String
    var id = UUID()
    
    init(int: Int, name: String, id: UUID = UUID()) {
        self.int = int
        self.tempIntString = String(int)
        self.name = name
        self.id = id
    }
    
}
struct doubleSetting: Identifiable {
    var double: Double
    
    var tempDoubleString: String = ""
    var name: String
    var id = UUID()
    
    init(double: Double, name: String, id: UUID = UUID()) {
        self.double = double
        self.tempDoubleString = String(double)
        self.name = name
        self.id = id
    }
    
}


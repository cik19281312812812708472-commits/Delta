//
//  Euclidiean Geometry.swift
//  Delta
//
//  Created by Desire on 2026-04-27.
//

import Foundation
import TestCreation
import SwiftUI
import Combine

class EuclideanGeo: Package {
  
    
    
    
    enum allQuestions: CaseIterable {
         
        
        case Chord
        case SemiCircle
        case MidSegment
        case Perpendicular_Bisector
        case Midpoint
        case Cyclic_Quadrilateral
        case Perpendicular
        case Arc
        case ExteriorAngle
        
        
    }
    
    
    
    
    func updateInternalSettings() {
        
    }
    
    static func == (lhs: EuclideanGeo, rhs: EuclideanGeo) -> Bool {
        lhs.id == rhs.id
    }
    
    
    
   
    @Published var allChangbleBools: [boolSetting] = []
    
    @Published var allChangbleInts: [intSetting] = []
    
    @Published var allChangbleDoubles: [doubleSetting] = [doubleSetting(double: 0.0, name: "stuff")]
    
    
    
    
    let publicName: String = "Euclidean Geometry"
    
    let internalName: String = "euclideanGeometry"
    
    var packageDescription: String = "This package will simply create questions on definitions of Euclidean Geometry."
    
    let id = UUID()
    
     
    
    func createSection(numOfQuestions: Int) -> [Question] {
        
        
        let x:[Question] = []
        return x
    }
    
    func createQuestion() -> Question {
        
        
        
            
            var questionView = AnyView(
                VStack {
                    
                }
            )
            
        
        
        let questionContent2 = QuestionContent {questionView} 
        

        var result = Question(questionText: "Solve for x and y in these linear Systems", questionContent: questionContent2, questionContentSizeX: CGFloat(10), questionContentSizeY: CGFloat(10), questionAnswer: "x")
        return result
       
    }
    
    enum allPossibleQuestions: CaseIterable {
        
    }
    
    
    
}

//
//  True Lin. Func.swift
//  Delta
//
//  Created by Desire on 2026-05-07.
//

import Combine
import Foundation
import TestCreation

class LinearSystemCreator: Package, ObservableObject {
    
    var publicName: String = "Linear System Creator"
    
    var internalName: String = "LinearSystemCreator"
    
    var packageDescription: String = "This is a package that creates simple linear systems. This package is meant to be used to get the basic skills of linear systems ortherwise it is useless."
    
    var id: UUID = UUID()
    
    var allChangbleBools: [boolSetting] = []
    
    var allChangbleInts: [intSetting] = [intSetting(int: 10, name: "Highest number generated"), intSetting(int: 10, name: "Number of questions"), intSetting(int: 0, name: "Number of decimal places (dont use a value above 17)")]
    
    var allChangbleDoubles: [doubleSetting] = []
    
    func updateInternalSettings() {
        if allChangbleInts[2].int > 17 {
            allChangbleInts[2].int = 17
        }
    }
    
    func createSection(numOfQuestions: Int) -> [Question] {
        
        var section: [Question] = []
        
        for i in 0..<allChangbleInts[1].int {
            let newQuestion = createQuestion()
            section.append(newQuestion)
        }
        
        return section
    }
    
    func createQuestion() -> Question {
        
        
        //MARK: Creating equations
        //Here I am declaring the equation dictonary
        ///The dictronary for an equation.
        var equation: [String:Decimal] = ["xCof1": 0, "xCof2": 1, "x": 0, "yCof1": 0, "yCof2": 1, "y": 0, "equalsTo": 0]
        var equation2: [String:Decimal] = ["xCof1": 0, "xCof2": 1, "x": 0, "yCof1": 0, "yCof2": 1, "y": 0, "equalsTo": 0]
        //the Cof2's are set to one so there is less code
        
        // creating the first cofs
        //MARK: Switch this to my new number system
        let places: Int = allChangbleInts[2].int
        let step = pow(10.0, Double(places))
        let actualHigherLimit: Int = allChangbleInts[0].int
        let higherLimit: Int = actualHigherLimit * Int(step)
        
        
        
        equation["xCof1"] = Decimal(Int.random(in: -higherLimit...higherLimit)) / Decimal(step)
        equation["yCof1"] = Decimal(Int.random(in: -higherLimit...higherLimit)) / Decimal(step)
        equation2["xCof1"] = Decimal(Int.random(in: -higherLimit...higherLimit)) / Decimal(step)
        equation2["yCof1"] = Decimal(Int.random(in: -higherLimit...higherLimit)) / Decimal(step)
        
        //creating x&y
        equation["x"] = Decimal(Int.random(in: -higherLimit...higherLimit))
        equation["y"] = Decimal(Int.random(in: -higherLimit...higherLimit))
        equation2["x"] = equation["x"]
        equation2["y"] = equation["y"]
        
        //looking to see the the equation will have fractions of not
        let equationHasFractions = Bool.random()
        
        
        if equationHasFractions == false {
            
           
            
            //creating the coefficients of x and y in both equations
            
         
            
            //finding out hte answer
            
            let newX: Decimal = equation["xCof1"]!  * equation["x"]!
            let newY: Decimal = equation["yCof1"]! * equation["y"]!
            let newX2: Decimal = equation2["xCof1"]! * equation2["x"]!
            let newY2: Decimal = equation2["yCof1"]!  * equation2["y"]!
            
            equation["equalsTo"] = newX + newY
            equation2["equalsTo"] = newX2 + newY2
            
        } else {
            
            //creating the coefficients of x and y in both equations
            
            equation["xCof2"] = Decimal(Int.random(in: -higherLimit...higherLimit)) / Decimal(step)
            equation["yCof2"] = Decimal(Int.random(in: -higherLimit...higherLimit)) / Decimal(step)
            equation2["xCof2"] = Decimal(Int.random(in: -higherLimit...higherLimit)) / Decimal(step)
            equation2["yCof2"] = Decimal(Int.random(in: -higherLimit...higherLimit)) / Decimal(step)
            
            
            
            //finding out hte answer
            
            let actualXCof1: Decimal = equation["xCof1"]!  / equation["xCof2"]!
            let actualYCof1: Decimal = equation["yCof1"]! / equation["yCof2"]!
            let actualXCof2: Decimal = equation2["xCof1"]! / equation2["xCof2"]!
            let actualYCof2: Decimal = equation2["yCof1"]! / equation2["yCof2"]!
            
            let newX: Decimal = actualXCof1 * equation["x"]!
            let newY: Decimal = actualYCof1 * equation["y"]!
            let newX2: Decimal = actualXCof2 * equation2["x"]!
            let newY2: Decimal = actualYCof2 * equation2["y"]!
            
            equation["equalsTo"] = newX + newY
            equation2["equalsTo"] = newX2 + newY2
            
            
        }
        
        //MARK: VIEWING EQUATION
        
        var equationViewed: String = ""
        var equation2Viewed: String = ""
        
        if equationHasFractions == false {
            
            if equation["yCof1"]! > 0 {
                equationViewed = "\(equation["xCof1"], default: "NIL ")x + \(equation["yCof1"], default: "NIL ")y = \(equation["equalsTo"], default: "NIL ")"
            } else {
                equationViewed = "\(equation["xCof1"], default: "NIL ")x - \(equation["yCof1"]! * -1)y = \(equation["equalsTo"], default: "NIL ")"
            }
           
            if equation2["yCof1"]! > 0 {
                equation2Viewed = "\(equation2["xCof1"], default: "NIL ")x + \(equation2["yCof1"], default: "NIL ")y = \(equation2["equalsTo"], default: "NIL ")"
                
            } else {
                equation2Viewed = "\(equation2["xCof1"], default: "NIL ")x - \(equation2["yCof1"]! * -1)y = \(equation2["equalsTo"], default: "NIL ")"
                
            }
            
           
            
        } else {//fractions
            
            
                equationViewed = "(\(equation["xCof1"], default: "NaN ") ÷ \(equation["xCof2"], default: "NIL2 "))x + (\(equation["yCof1"], default: "NIL1 ") ÷ \(equation["yCof2"], default: "NaN "))y = \(equation["equalsTo"], default: "NIL ")"
            equation2Viewed = "(\(equation2["xCof1"], default: "NIL1 ") ÷ \(equation2["xCof2"], default: "NIL2 "))x + (\(equation2["yCof1"], default: "NIL1 ") ÷ \(equation2["yCof2"], default: "NIL2 "))y = \(equation2["equalsTo"], default: "NIL ")"
            
            
        }
        
        
        
        
        var finalQuestion: Question
        
     
        let answer = "x=\(equation["x"], default: "NaN"), y=\(equation["y"], default: "NaN")"
        
        let questionContent = QuestionContent { AnyView (
            
            VStack {
                
                Text(equationViewed)
                    .font(.title3)
                Text(equation2Viewed)
                    .font(.title3)
                    .padding(25)
                
                Text("Answer like: x = ?, y = ?")
                
            }
        
        )}
        //MARK: Add omitting of questions with 0 in it
        
        finalQuestion = Question(creator: self.id, questionText: "Solve the linear system:", questionContent: questionContent, questionContentSizeX: 500, questionContentSizeY: 500, questionAnswer: answer)
        
        
        
        guard equation["equalsTo"]!.isNaN == false && equation2["equalsTo"]!.isNaN == false else {
            
            let newQuestion = createQuestion()
            
            return newQuestion
            
        }
        
        return finalQuestion
        
    }
    
    
}

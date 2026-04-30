//
//  Package Example.swift
//  Delta
//
//  Created by Desire on 2026-03-06.
//
/// this is just an example of what a package should have for linear systems
///

import Foundation
///it needs this
import TestCreation
import SwiftUI
import Combine

///it should have this
class examplePackage: Package {
    
    
    func updateInternalSettings() {
        
    }
    
    static func == (lhs: examplePackage, rhs: examplePackage) -> Bool {
        lhs.id == rhs.id
    }
    

    @Published var packageDescription: String = ""
    @Published var allChangbleBools: [boolSetting] = []
    
    @Published var allChangbleInts: [intSetting] = []
    
    @Published var allChangbleDoubles: [doubleSetting] = []

    let publicName: String = "Linear System Creator"
    
    let internalName: String = "Example Package. Linear System Creator"
    let id = UUID()
    
    
    
    
    
    ///it should have this to create a section
    func createSection(numOfQuestions: Int) -> [Question]{
        
        //let questions
        
        let x: [Question] = []
        return x
    }
    
    ///it should have this(to create individual questiosn
    func createQuestion() -> Question {
        
        
        let t = CreateLinearSystem()
        var content: [mathEquationBlueprint] = t
        
       
        
        
        struct questionView: View {
            
            var body: some View {
                
            }
            
        }
        
        let questionContent2 = QuestionContent { AnyView (VStack {}) }
        
        let answer1 = content[2].rightSide[0].factors[0].numerator
        let answer2 = content[3].rightSide[0].factors[0].numerator
        var result = Question(questionText: "Solve for x and y in these linear Systems", questionContent: questionContent2, questionContentSizeX: CGFloat(10), questionContentSizeY: CGFloat(10), questionAnswer: "x = \(answer1), y = \(answer2)")
        return result
    }
    
    
    
    func  CreateLinearSystem() -> [mathEquationBlueprint] {

        
        
        var actualEquation1: mathEquationBlueprint
        var actualEquation2: mathEquationBlueprint
        
        
        var allEquations: [mathEquationBlueprint]
        
        //MARK: Creating equations
        //Here I am declaring the equation dictonary
        ///The dictronary for an equation.
        var equation: [String:Decimal] = ["xCof1": 0, "xCof2": 1, "x": 0, "yCof1": 0, "yCof2": 1, "y": 0, "equalsTo": 0]
        var equation2: [String:Decimal] = ["xCof1": 0, "xCof2": 1, "x": 0, "yCof1": 0, "yCof2": 1, "y": 0, "equalsTo": 0]
        //the Cof2's are set to one so there is less code
        
        // creating the first cofs
        
        let places: Int = 0
        let step = pow(10.0, Double(places))
        let actualHigherLimit: Int = 10
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
            
            equation["xCof2"] = Decimal(Int.random(in: 0...higherLimit)) / Decimal(step)
            equation["yCof2"] = Decimal(Int.random(in: 0...higherLimit)) / Decimal(step)
            equation2["xCof2"] = Decimal(Int.random(in: 0...higherLimit)) / Decimal(step)
            equation2["yCof2"] = Decimal(Int.random(in: 0...higherLimit)) / Decimal(step)
            
            
            
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
        
        
        
        if equationHasFractions == false {
            
            
            // the first equation
            var firstTerm: mathEquationBlueprint.Term
            let xVar = mathEquationBlueprint.factor(topBase: "x", bottomBase: "1", squareRoot: false)
            let xCof1String = equation["xCof1"]!.description
            
            
            let xCof1 = mathEquationBlueprint.factor(topBase: xCof1String, bottomBase: "1", squareRoot: false)
            firstTerm = mathEquationBlueprint.Term(sign: .positive, factors: [xCof1, xVar])
//MARK: make elim the pos when at hte farthest
            var secondTerm: mathEquationBlueprint.Term
            
            let yVar = mathEquationBlueprint.factor(topBase: "y", bottomBase: "1", squareRoot: false)
            
           
            if equation["yCof1"]! > 0 {
                let yCof1String = equation["yCof1"]!.description
                let yCof1 = mathEquationBlueprint.factor(topBase: yCof1String, bottomBase: "1", squareRoot: false)
                
                secondTerm = mathEquationBlueprint.Term(sign: .positive, factors: [yCof1, yVar])
            } else {
                let yCof1String = (-1 * equation["yCof1"]!).description
                let yCof1 = mathEquationBlueprint.factor(topBase: yCof1String, bottomBase: "1", squareRoot: false)
                secondTerm = mathEquationBlueprint.Term(sign: .negative, factors: [yCof1, yVar])
            }
            
            let rightsideString = equation["equalsTo"]!.description
            let righsideFactor = mathEquationBlueprint.factor(topBase: rightsideString, bottomBase: "1", squareRoot: false)
            let rightside = mathEquationBlueprint.Term(sign: .positive, factors: [righsideFactor])
            actualEquation1 = mathEquationBlueprint(leftSide: [firstTerm, secondTerm], relation: .equal, rightSide: [rightside])
            
            
            // the second equation
            
            
            let xCof1String2 = equation2["xCof1"]!.description
            
            
            let xCof1_2 = mathEquationBlueprint.factor(topBase: xCof1String2, bottomBase: "1", squareRoot: false)
            firstTerm = mathEquationBlueprint.Term(sign: .positive, factors: [xCof1, xVar])
//MARK: make elim the pos when at hte farthest
         
            
           
            
           
            if equation["yCof1"]! > 0 {
                let yCof1String2 = equation2["yCof1"]!.description
                let yCof1_2 = mathEquationBlueprint.factor(topBase: yCof1String2, bottomBase: "1", squareRoot: false)
                
                secondTerm = mathEquationBlueprint.Term(sign: .positive, factors: [yCof1_2, yVar])
            } else {
                let yCof1String2 = (-1 * equation2["yCof1"]!).description
                let yCof1_2 = mathEquationBlueprint.factor(topBase: yCof1String2, bottomBase: "1", squareRoot: false)
                secondTerm = mathEquationBlueprint.Term(sign: .negative, factors: [yCof1_2, yVar])
            }
            
            let rightsideString2 = equation2["equalsTo"]!.description
            let righsideFactor2 = mathEquationBlueprint.factor(topBase: rightsideString, bottomBase: "1", squareRoot: false)
            let rightside2 = mathEquationBlueprint.Term(sign: .positive, factors: [righsideFactor])
            actualEquation2 = mathEquationBlueprint(leftSide: [firstTerm, secondTerm], relation: .equal, rightSide: [rightside2])
            
            allEquations = [actualEquation1, actualEquation2]
            
        } else {//fractions
            
            // the first equation
            var firstTerm: mathEquationBlueprint.Term
            let xVar = mathEquationBlueprint.factor(topBase: "x", bottomBase: "1", squareRoot: false)
            
            let xCof2String = equation["xCof2"]!.description
            let xCof1String = equation["xCof1"]!.description
            let xCof1 = mathEquationBlueprint.factor(topBase: xCof1String, bottomBase: xCof2String, squareRoot: false)
            firstTerm = mathEquationBlueprint.Term(sign: .positive, factors: [xCof1, xVar])
//MARK: make elim the pos when at hte farthest
            var secondTerm: mathEquationBlueprint.Term
            
            let yVar = mathEquationBlueprint.factor(topBase: "y", bottomBase: "1", squareRoot: false)
            
           
            if equation["yCof1"]! > 0 {
                let yCof1String = equation["yCof1"]!.description
                let yCof2String = equation["yCof2"]!.description
                let yCof1 = mathEquationBlueprint.factor(topBase: yCof1String, bottomBase: yCof2String, squareRoot: false)
                
                secondTerm = mathEquationBlueprint.Term(sign: .positive, factors: [yCof1, yVar])
            } else {
                let yCof1String = (-1 * equation["yCof1"]!).description
                let yCof2String = equation["yCof2"]!.description
                let yCof1 = mathEquationBlueprint.factor(topBase: yCof1String, bottomBase: yCof2String, squareRoot: false)
                secondTerm = mathEquationBlueprint.Term(sign: .negative, factors: [yCof1, yVar])
            }
            
            let rightsideString = equation["equalsTo"]!.description
            let righsideFactor = mathEquationBlueprint.factor(topBase: rightsideString, bottomBase: "1", squareRoot: false)
            let rightside = mathEquationBlueprint.Term(sign: .positive, factors: [righsideFactor])
            actualEquation1 = mathEquationBlueprint(leftSide: [firstTerm, secondTerm], relation: .equal, rightSide: [rightside])
            
            
            // the second equation
            
            
            let xCof1String2 = equation2["xCof1"]!.description
            let xCof2String2 = equation2["xCof2"]!.description
            
            let xCof1_2 = mathEquationBlueprint.factor(topBase: xCof1String2, bottomBase: xCof2String2, squareRoot: false)
            firstTerm = mathEquationBlueprint.Term(sign: .positive, factors: [xCof1, xVar])
//MARK: make elim the pos when at hte farthest
         
            
           
            
           
            if equation["yCof1"]! > 0 {
                let yCof1String2 = equation2["yCof1"]!.description
                let yCof2String2 = equation2["yCof2"]!.description
                let yCof1_2 = mathEquationBlueprint.factor(topBase: yCof1String2, bottomBase: yCof2String2, squareRoot: false)
                
                secondTerm = mathEquationBlueprint.Term(sign: .positive, factors: [yCof1_2, yVar])
            } else {
                let yCof1String2 = (-1 * equation2["yCof1"]!).description
                let yCof2String2 = equation2["yCof2"]!.description
                let yCof1_2 = mathEquationBlueprint.factor(topBase: yCof1String2, bottomBase: yCof2String2, squareRoot: false)
                secondTerm = mathEquationBlueprint.Term(sign: .negative, factors: [yCof1_2, yVar])
            }
            
            let rightsideString2 = equation2["equalsTo"]!.description
            let righsideFactor2 = mathEquationBlueprint.factor(topBase: rightsideString, bottomBase: "1", squareRoot: false)
            let rightside2 = mathEquationBlueprint.Term(sign: .positive, factors: [righsideFactor])
            actualEquation2 = mathEquationBlueprint(leftSide: [firstTerm, secondTerm], relation: .equal, rightSide: [rightside2])
            
            allEquations = [actualEquation1, actualEquation2]
            
        }
        
        var answerEquationX: mathEquationBlueprint
        if equation["x"]! > 0 {
            let actualX_Var_String = equation["x"]!.description
            let actualXVar = mathEquationBlueprint.factor(topBase: actualX_Var_String, bottomBase: "1", squareRoot: false)
            let x = mathEquationBlueprint.factor(topBase: "x", bottomBase: "1", squareRoot: false)
            let XVarTerm = mathEquationBlueprint.Term(sign: .positive, factors: [actualXVar])
            let XTerm = mathEquationBlueprint.Term(sign: .positive, factors: [x])
            answerEquationX = mathEquationBlueprint(leftSide: [XTerm], relation: .equal, rightSide: [XVarTerm])
        } else {
            let actualX_Var_String = ( -1 * equation["x"]!).description
            let actualXVar = mathEquationBlueprint.factor(topBase: actualX_Var_String, bottomBase: "1", squareRoot: false)
            let x = mathEquationBlueprint.factor(topBase: "x", bottomBase: "1", squareRoot: false)
            let XVarTerm = mathEquationBlueprint.Term(sign: .negative, factors: [actualXVar])
            let XTerm = mathEquationBlueprint.Term(sign: .positive, factors: [x])
            answerEquationX = mathEquationBlueprint(leftSide: [XTerm], relation: .equal, rightSide: [XVarTerm])
        }
        
        var answerEquationY: mathEquationBlueprint
        if equation["y"]! > 0 {
            let actualY_Var_String = equation["y"]!.description
            let actualYVar = mathEquationBlueprint.factor(topBase: actualY_Var_String, bottomBase: "1", squareRoot: false)
            let y = mathEquationBlueprint.factor(topBase: "y", bottomBase: "1", squareRoot: false)
            let YVarTerm = mathEquationBlueprint.Term(sign: .positive, factors: [actualYVar])
            let YTerm = mathEquationBlueprint.Term(sign: .positive, factors: [y])
            answerEquationY = mathEquationBlueprint(leftSide: [YTerm], relation: .equal, rightSide: [YVarTerm])
        } else {
            let actualY_Var_String = ( -1 * equation["y"]!).description
            let actualYVar = mathEquationBlueprint.factor(topBase: actualY_Var_String, bottomBase: "1", squareRoot: false)
            let y = mathEquationBlueprint.factor(topBase: "x", bottomBase: "1", squareRoot: false)
            let YVarTerm = mathEquationBlueprint.Term(sign: .negative, factors: [actualYVar])
            let YTerm = mathEquationBlueprint.Term(sign: .positive, factors: [y])
            answerEquationY = mathEquationBlueprint(leftSide: [YTerm], relation: .equal, rightSide: [YVarTerm])
        }
        
        allEquations.append(answerEquationX)
        allEquations.append(answerEquationY)
        
        return allEquations
    }

    
    
}



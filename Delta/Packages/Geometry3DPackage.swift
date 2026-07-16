//
//  Geometry3DPackage.swift
//  Delta
//
//  Created by Desire on 2026-06-16.
//


import SwiftUI
import Foundation
import TestCreation
import Combine

class Geometry3DPackage: Package {
    // Protocol Conformances
    
    var packageType: PackageTypes = .mathPackage
    
    let publicName = "3D Geometry: Volume & Surface Area"
    let internalName = "com.geometry.volume.surfacearea"
    @Published var packageDescription = "Generates procedural questions regarding the volume and surface area of cylinders, cones, and spheres."
    let id = UUID()
    
    // Configurable Settings using your app's types
    @Published var allChangbleBools: [boolSetting] = []
    @Published var allChangbleInts: [intSetting] = []
    @Published var allChangbleDoubles: [doubleSetting] = []
    
    // Internal state tracking
    private var testCylinders: Bool = true
    private var testCones: Bool = true
    private var testSpheres: Bool = true
    private var minDimension: Int = 2
    private var maxDimension: Int = 15
    
    

    init() {
        setup()
    }
    
    func saveQuestion(question: TestCreation.Question) -> TestCreation.DescriptionOfQuestion {
        DescriptionOfQuestion(ownerInternalName: internalName, question: question)
    }
    
    func setup() {
        // Initialize your app's custom setting types
        allChangbleBools = [
            boolSetting(bool: true, name: "Include Cylinders", description: "Toggle questions about cylinders"),
            boolSetting(bool: true, name: "Include Cones", description: "Toggle questions about cones"),
            boolSetting(bool: true, name: "Include Spheres", description: "Toggle questions about spheres")
        ]
        
        allChangbleInts = [
            intSetting(int: 2, name: "Minimum Dimension", description: "Lowest allowed value for radius or height"),
            intSetting(int: 15, name: "Maximum Dimension", description: "Highest allowed value for radius or height")
        ]
    }
    
    func updateInternalSettings() {
        // Pull properties updated by your UI back into the generator logic
        if allChangbleBools.count >= 3 {
            testCylinders = allChangbleBools[0].bool
            testCones = allChangbleBools[1].bool
            testSpheres = allChangbleBools[2].bool
        }
        
        if allChangbleInts.count >= 2 {
            minDimension = allChangbleInts[0].int
            maxDimension = allChangbleInts[1].int
        }
    }
    
    func createSection(numOfQuestions: Int) -> [Question] {
        var section: [Question] = []
        for _ in 0..<numOfQuestions {
            section.append(createQuestion())
        }
        return section
    }
    
    func createQuestion() -> Question {
        // Build the pool based on user settings
        var allowedShapes: [String] = []
        if testCylinders { allowedShapes.append("cylinder") }
        if testCones { allowedShapes.append("cone") }
        if testSpheres { allowedShapes.append("sphere") }
        if allowedShapes.isEmpty { allowedShapes = ["cylinder"] } // Fallback safety
        
        let targetShape = allowedShapes.randomElement()!
        let metric = Bool.random() ? "volume" : "surface area"
        
        let radius = Int.random(in: minDimension...maxDimension)
        let height = Int.random(in: minDimension...maxDimension)
        
        var questionText = ""
        var calculatedValue: Double = 0.0
        
        // Compute geometry math logic using Double.pi
        switch targetShape {
        case "cylinder":
            questionText = "Calculate the \(metric) of a cylinder with a radius of \(radius) cm and a height of \(height) cm."
            if metric == "volume" {
                calculatedValue = Double.pi * pow(Double(radius), 2) * Double(height)
            } else {
                calculatedValue = (2 * Double.pi * Double(radius) * Double(height)) + (2 * Double.pi * pow(Double(radius), 2))
            }
            
        case "cone":
            questionText = "Calculate the \(metric) of a cone with a radius of \(radius) cm and a height of \(height) cm."
            if metric == "volume" {
                calculatedValue = (1.0 / 3.0) * Double.pi * pow(Double(radius), 2) * Double(height)
            } else {
                let slantHeight = sqrt(pow(Double(radius), 2) + pow(Double(height), 2))
                calculatedValue = (Double.pi * Double(radius) * slantHeight) + (Double.pi * pow(Double(radius), 2))
            }
            
        case "sphere":
            questionText = "Calculate the \(metric) of a sphere with a radius of \(radius) cm."
            if metric == "volume" {
                calculatedValue = (4.0 / 3.0) * Double.pi * pow(Double(radius), 3)
            } else {
                calculatedValue = 4 * Double.pi * pow(Double(radius), 2)
            }
            
        default:
            break
        }
        
        // String conversion formatted to 2 decimal places matching your text-style pipeline
        let answerString = String(format: "%.2f", calculatedValue)

        // Setup empty or minimal UI visualization context per your QuestionContent design
        let uiContent = QuestionContent {
            VStack {
                Text("📦 3D Geometry Challenge")
                    .font(.headline)
                    .padding()
            }
        }
        
        // Instantiates using your text initializer: init(creator:questionName:questionType:questionText:questionContent:questionContentSizeX:questionContentSizeY:questionAnswer:)
        return Question(
            creator: self.id,
            questionName: "\(targetShape.capitalized) Exercise",
            questionType: .text,
            questionText: questionText,
            questionContent: uiContent,
            questionContentSizeX: 400,
            questionContentSizeY: 200,
            questionAnswer: answerString
        )
    }
    
    func loadQuestion(descriptionOfQuestion: DescriptionOfQuestion) -> Question {
        // Re-route or build a standard question object based on your app's custom DescriptionOfQuestion type definition
        return createQuestion()
    }
}

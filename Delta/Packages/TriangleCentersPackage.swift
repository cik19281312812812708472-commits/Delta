//
//  TriangleCentersPackage.swift
//  Delta
//
//  Created by Gemini on 2026-06-12.
//

import Foundation
import SwiftUI
import Combine
import TestCreation

@available(macOS 10.15, iOS 13, *)
class TriangleCentersPackage: Package {
    
    // MARK: - Package Protocol Properties
    let publicName: String = "Triangle Centers & Concurrency"
    let internalName: String = "TriangleCentersPackage"
    
    var packageDescription: String = "Converted from your custom allQuestionsMath enum and questionBlueprint code into a standard Package model."
    
    let id = UUID()
    
    // Settings arrays required by the protocol
    @Published var allChangbleBools: [boolSetting] = []
    @Published var allChangbleInts: [intSetting] = []
    @Published var allChangbleDoubles: [doubleSetting] = []
    
    // MARK: - Initializer & Setup
    init() {
        setup()
    }
    
    func setup() {
        allChangbleBools = [
            boolSetting(
                bool: false,
                name: "Reverse Questions (Guess lines from Center)",
                description: "Swaps the quiz order so you guess the intersecting lines based on the name of the triangle center."
            )
        ]
        
        allChangbleInts = [
            intSetting(
                int: 4,
                name: "Default Question Count",
                description: "The total number of questions generated when you start a new quiz section."
            )
        ]
        
        allChangbleDoubles = []
    }
    
    // MARK: - Settings Mutator Sync
    func updateInternalSettings() {}
    
    // MARK: - Question Factory Logic
    private var isReversed: Bool {
        return allChangbleBools.first(where: { $0.name.contains("Reverse") })?.bool ?? false
    }
    
    func createQuestion() -> Question {
        let randomQuestionType = allQuestionsMath.allCases.randomElement()!
        let blueprint = randomQuestionType.actualQuestion
        
        let finalQuestionText: String
        let finalAnswerText: String
        
        if isReversed {
            finalQuestionText = "Which lines intersect to form the \(blueprint.answer)?"
            finalAnswerText = randomQuestionType.rawValue
        } else {
            finalQuestionText = blueprint.question
            finalAnswerText = blueprint.answer
        }
        
        // Matches your exact .text initializer signatures perfectly
        return Question(
            creator: self.id,
            questionName: randomQuestionType.rawValue,
            questionType: .text, // Hardcoded to .text as requested
            questionText: finalQuestionText,
            questionContent: QuestionContent(AnyView(EmptyView())), // No custom view injected yet
            questionContentSizeX: 0,
            questionContentSizeY: 0,
            questionAnswer: finalAnswerText
        )
    }
    
    func createSection(numOfQuestions: Int) -> [Question] {
        var sectionQuestions: [Question] = []
        for _ in 0..<numOfQuestions {
            sectionQuestions.append(createQuestion())
        }
        return sectionQuestions
    }
    
    func loadQuestion(descriptionOfQuestion: DescriptionOfQuestion) -> Question {
        // Matches your exact .text initializer signatures using decoded persistent data
        return Question(
            creator: descriptionOfQuestion.creator,
            questionName: descriptionOfQuestion.questionName,
            questionType: .text, // Reconstructed safely as a text type question
            questionText: descriptionOfQuestion.questionText,
            questionContent: QuestionContent(AnyView(EmptyView())),
            questionContentSizeX: 0,
            questionContentSizeY: 0,
            questionAnswer: descriptionOfQuestion.questionAnswer
        )
    }
    
    // MARK: - Answer Filtering
    func filterAnswer(answer: String) -> String {
        return answer.lowercased()
    }
}

// MARK: - Math Data Structures
enum allQuestionsMath: String, CaseIterable {
    case altitude = "altitude"
    case median = "median"
    case perpendicularBisector = "perpendicular bisector"
    case angleBisector = "angle bisector"
    
    var answer: String {
        switch self {
        case .altitude: return "orthocenter"
        case .median: return "centroid"
        case .perpendicularBisector: return "circumcenter"
        case .angleBisector: return "incenter"
        
        }
    }
    
    var questionWords: String {
        switch self {
        case .altitude: return "What is the intersection of three Altitudes called?"
        case .median: return "What is the intersection of three Medians called?"
        case .perpendicularBisector: return "What is the intersection of three Perpendicular Bisectors called?"
        case .angleBisector: return "What is the intersection of three Angle Bisectors called?"
        
        }
    }
    
    var actualQuestion: questionBlueprint {
        return .init(question: questionWords, answer: answer)
    }
}

struct questionBlueprint {
    var question: String
    var answer: String
}

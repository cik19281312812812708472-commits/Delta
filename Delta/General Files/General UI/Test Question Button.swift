//
//  Test Question Button.swift
//  Delta
//
//  Created by Desire on 2026-04-28.
//

import SwiftUI
import Combine
import Foundation
import TestCreation

struct TestQuestionButton: View {
    
    var question: Question
    var oniOS: Bool
    var isShadowOff: Bool
    @State private var showing: Bool = true
    @State private var backgroundSize: CGSize = .zero
    
    @State private var popOverShown: Bool = false
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var testManager: TestManager
    
    var body: some View {
       
        ZStack {
            Group {
                if oniOS {
                    
                 Button {
                                
                    popOverShown.toggle()
                                   
                } label: {
                                   
                                   
                                   
                    ZStack {
                        
                        
                        
                        if oniOS {
                            RoundedRectangle(cornerRadius: 14).fill(showing  ? (colorScheme == .light ? Color.white : Color.black) : .clear)
                                .frame(width: backgroundSize.width, height: backgroundSize.height)
                            
                            Text(question.questionName != "" ? question.questionName : question.questionText)
                                .foregroundStyle(showing  ? (colorScheme == .light ? .black : .white) : .clear)
                                .padding(10)
                                .background(
                                    GeometryReader { geometry in
                                        
                                        Color.clear
                                            .preference(key: SizePreferenceKey.self, value: geometry.size)
                                        
                                    }
                                )
                        } else {
                            
                            Text(question.questionName != "" ? question.questionName : question.questionText)
                                .hoverEffect(cornerRadius: 14)
                                .padding(10)
                            
                        }
                        
                        
                    }
                                   .onPreferenceChange(SizePreferenceKey.self) { size in
                                       self.backgroundSize = size
                                   }
                               }
                               .cornerRadius(14)
                } else {
                    
                    Button {
                        
                        popOverShown.toggle()
                        
                    } label: {
                        
                        
                        
                        ZStack {
                            
                            
                            
                            if oniOS {
                                RoundedRectangle(cornerRadius: 14).fill(showing  ? (colorScheme == .light ? Color.white : Color.black) : .clear)
                                    .frame(width: backgroundSize.width, height: backgroundSize.height)
                                
                                Text(question.questionName != "" ? question.questionName : question.questionText)
                                    .foregroundStyle(showing  ? (colorScheme == .light ? .black : .white) : .clear)
                                    .padding(10)
                                    .background(
                                        GeometryReader { geometry in
                                            
                                            Color.clear
                                                .preference(key: SizePreferenceKey.self, value: geometry.size)
                                            
                                        }
                                    )
                            } else {
                                
                                Text(question.questionName != "" ? question.questionName : question.questionText)
                                
                                    .hoverEffect(cornerRadius: 14)
                                    .padding(10)
                                
                            }
                            
                            
                        }
                        .onPreferenceChange(SizePreferenceKey.self) { size in
                            self.backgroundSize = size
                        }
                    }
                    
                    .background(colorScheme == .light ? .white : .black)
                    .cornerRadius(14)
                }
            }
                .contextMenu {
                    Button("Remove Question") {
                        
#if os(iOS)
                        showing = false
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            withAnimation(.smooth) {
                                testManager.removeQuestion(question, removeAll: false)
                            }
                        }
                        
#else
                        testManager.removeQuestion(question, removeAll: false)
#endif
                        
                        
                    }
                    Button("Remove these Questions") {
                        
#if os(iOS)
                        showing = false 
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            withAnimation(.smooth) {
                                testManager.removeQuestion(question, removeAll: true)
                            }
                        }
#else
                        testManager.removeQuestion(question, removeAll: true)
#endif
                        
                    }.contextMenu {
                        
                        Text("This removes every question that is this question")
                    }
                }
                .popover(isPresented: $popOverShown) {
                    
                    GeometryReader { popOverGeo in
                        
                        ZStack {
                            
                            question.questionContent
                                .position(x: popOverGeo.size.width / 2, y: popOverGeo.size.height / 2)
                        }
                        
                    }
                    .frame(width: question.questionContentSizeX, height: question.questionContentSizeY)
                    
                }
            }
            .shadow(radius: isShadowOff ? 0 : (oniOS ? 8 : 14))
       
    }
    
    init(question: Question, oniOS: Bool, isShadowOff: Bool) {
        self.question = question
        self.oniOS = oniOS
        self.isShadowOff = isShadowOff
    }
    
    
    struct SizePreferenceKey: PreferenceKey {
     
        static var defaultValue: CGSize = .zero
        
        static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
            value = nextValue()
        }
        
    }
    
    
    
    
    
    
}

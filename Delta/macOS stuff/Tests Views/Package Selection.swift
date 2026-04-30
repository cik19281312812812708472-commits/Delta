//
//  Package Selection.swift
//  Delta
//
//  Created by Desire on 2026-04-26.
//


import SwiftUI
import Combine



struct PackageSelection: View {
    //for loading simply place something above everyting
    
    @EnvironmentObject var appState: AppManager
    @Environment(\.colorScheme) var colorScheme
    
    @EnvironmentObject var testManager: TestManager
    
    
    @State private var isAlgorithmPoppedOpen: Bool = false
    
    @State private var noPackageSelected: Bool = false
    ///Thise stores the packages id so we can l
    
    
    var idealWhite: Color = Color(red: 240/255, green: 240/255, blue: 240/255)
    var idealShadowOpacity: Double = 0.3
    
    
    var body: some View {
   
        
        
        GeometryReader { geo in
            
            ZStack {
                
                Background(geo: geo)
 
                
                ScrollView {
                    
                    Text("Select a Package")
                        .font(.system(size: 20))
                        .fontWeight(.black)
                    
                    RoundedRectangle(cornerRadius: 2)
                        .fill(.black.opacity(0.7))
                        .frame(height: 2)
                   
                    ForEach($appState.allPackages, id: \.id) { $unePackage in
                 
                        PackageButton(geo: geo, package: unePackage)
                  
                    }
                    
                    Spacer()
                }
                .frame(width: geo.size.width * 0.15, height: geo.size.height * 0.9)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                    .fill(colorScheme == .light ? idealWhite : .black)
                )
                .shadow(color: Color.black.opacity(idealShadowOpacity), radius: 10, x: 1, y: 1)
                .position(x: geo.size.width * 0.9, y: geo.size.height / 2)
             
                
                ScrollView {
                    
                    Text("Test Questions")
                        .font(.system(size: 20))
                        .fontWeight(.black)
                    
                    RoundedRectangle(cornerRadius: 2)
                        .fill(.black.opacity(0.7))
                        .frame(height: 2)
                    
                    
                    ForEach($testManager.allQuestions, id: \.id) { $uneQuestion in
                        
                        TestQuestionButton(question: uneQuestion)
                    }
                    
                    Spacer()
                }
                .frame(width: geo.size.width * 0.6, height: geo.size.height * 0.9)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(colorScheme == .light ? idealWhite: .black)
                )
                .shadow(color: Color.black.opacity(idealShadowOpacity), radius: 10, x: 1, y: 1)
                .position(x: geo.size.width * 0.32, y: geo.size.height / 2)
                
                
                
                ScrollView {
                    
                    Text("Modify Test Settings")
                        .font(.system(size: 20))
                        .fontWeight(.black)
                    
                    RoundedRectangle(cornerRadius: 2)
                        .fill(.black.opacity(0.7))
                        .frame(height: 2)
                    
                    
                    
                    Button {
                        
                        //because it will always be wanted to be nothing at start
                        testManager.allQuestions = []
                        
                        testManager.createAllQuestions()
                        
                    } label: {
                        
                        ZStack {
                            
                            if testManager.createdTest == false {
                                
                                RoundedRectangle(cornerRadius: 14)
                                    .fill(colorScheme == .light ? Color.white : Color.blue)
                                    .stroke(colorScheme == .light ? Color.white : Color.blue, lineWidth: 2)
                                
                                    .shadow(radius: 10)
                                
                                Text("Create Questions")
                                    .font(.system(size: 20))
                                    .fontWeight(.black)
                                
                            } else {
                                
                                RoundedRectangle(cornerRadius: 14)
                                    .fill(colorScheme == .light ? Color.white : Color.blue)
                                    .stroke(colorScheme == .light ? Color.white : Color.blue, lineWidth: 2)
                                
                                    .shadow(radius: 10)
                                
                                
                                Text("Recreate Questions")
                                    .font(.system(size: 20))
                                    .fontWeight(.black)
                            }
                            
                        }
                    }
                    .frame(width: geo.size.width * 0.1, height: geo.size.height * 0.08)
                    .buttonStyle(.plain)
                  
                    
                    
                    Toggle("Enable Algorithmia", isOn: $testManager.allowTestAlgorithm)
                        .toggleStyle(.switch)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(colorScheme == .light ? idealWhite: .black)
                                .frame(width: geo.size.width * 0.11, height: geo.size.height * 0.03)
                        )
                        .shadow(color: Color.black.opacity(idealShadowOpacity), radius: 10, x: 1, y: 1)
                        .popover(isPresented: $isAlgorithmPoppedOpen) {
                            ZStack {

                                VStack {
                                    Text("Help")
                                    Divider()
                                    Text("This algorithim is designed to find the most relevant questions for you based on your previous answers.")
                                    
                                    
                                }
                                
                            }
                        }
                        .padding(20)
               
                    
                    Toggle("Randomize Questions at start", isOn: $testManager.randmizeQuestionsAtStart)
                        .toggleStyle(.switch)
                        .background(
                            HStack {
                                
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(colorScheme == .light ? idealWhite: .black)
                                    .frame(width: geo.size.width * 0.13, height: geo.size.height * 0.03)
                                    
                            }
                        )
                        .shadow(color: Color.black.opacity(idealShadowOpacity), radius: 10, x: 1, y: 1)
                        .padding(20)
                    
                    Button {
                        
                        //because it will always be wanted to be nothing at start
                        
                        if testManager.allQuestions == [] {
                            testManager.allQuestions = []
                            testManager.createAllQuestions()
                        }
                        
                        //fix the bug where if a package give no questions the program crashes
                        if testManager.packagesSelected.isEmpty || testManager.allQuestions.isEmpty {
                            
                            
                            noPackageSelected = true
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                
                             noPackageSelected = false
                            }
                            
                        } else {
                            

                            
                            
                            testManager.startTest()
                        }
                        
                        
                        if true {
                            
                        }
                        
                    } label: {
                        
                        ZStack {
                            
                            if noPackageSelected == false {
                                RoundedRectangle(cornerRadius: 14)
                                    .fill(colorScheme == .light ? Color.white : Color.blue)
                                    .stroke(colorScheme == .light ? Color.white : Color.blue, lineWidth: 2)
                                
                                    .shadow(radius: 10)
                                
                                Text("Start Practise Session")
                                    .font(.system(size: 20))
                                    .fontWeight(.black)
                            } else {
                                RoundedRectangle(cornerRadius: 14)
                                    .fill(colorScheme == .light ? Color.red : Color.blue)
                                    .stroke(colorScheme == .light ? Color.yellow : Color.blue, lineWidth: 2)
                                
                                    .shadow(radius: 10)
                                
                                Text("No Packages/Questions")
                                    .font(.system(size: 20))
                                    .fontWeight(.black)
                            }
                        }
                    }
                    .frame(width: geo.size.width * 0.13, height: geo.size.height * 0.08)
                    .buttonStyle(.plain)
                    
                    ZStack {
                        
                        RoundedRectangle(cornerRadius: 14)
                            .fill(colorScheme == .light ? idealWhite : Color.blue)
                            .frame(width: geo.size.width * 0.13, height: geo.size.height * 0.03)
                            .shadow(color: Color.black.opacity(idealShadowOpacity), radius: 10, x: 1, y: 1)
                           
                        
                        
                        HStack {
                            Slider(value: $testManager.correctAnswerWaitingTime, in: 0...5)
                            
                            Text("Correct answer display time")
                            
                        }
                        
                    }
                    .fixedSize()
                    
                    
                    
                    Spacer()
                }
                .frame(width: geo.size.width * 0.15, height: geo.size.height * 0.9)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(colorScheme == .light ? idealWhite: .black)
                )
                .shadow(color: Color.black.opacity(idealShadowOpacity), radius: 10, x: 1, y: 1)
                .position(x: geo.size.width * 0.73, y: geo.size.height * 0.5)
                
                
                
               
                
                
                
                QuestionInfo(geo: geo)
                    .position(x: geo.size.width * 0.98, y: geo.size.height * 0.97)
                
            }
            
            
        } .onAppear {
            
            testManager.packagesNotSelected = appState.allPackages.map {$0.id}
            testManager.packagesSelected = []
            
            for package in appState.allPackages {
                testManager.allPackages[package.id] = package
            }
            
        }
        
    }
    
    
    
}

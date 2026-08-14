//
//  iOS Question Settings.swift
//  Delta
//
//  Created by Desire on 2026-07-13.
//

// It will use a popover for the preview of the questions where some of them can abe removed.
import SwiftUI


struct iOSTestSettings: View {
    
    @EnvironmentObject var generalData: GeneralData
    @EnvironmentObject var testManager: TestManager
    @EnvironmentObject var appManager: AppManager
    @Environment(\.colorScheme) var colorScheme
    
    @State private var isAlgorithmPoppedOpen: Bool = false
    
    @State private var noPackageSelected: Bool = false
    ///Thise stores the packages id so we can l
    
    @State private var tempCorrectAnswersToPass: String = ""
    
    @State private var idealSpacerLength: CGFloat = 0
    
    
    
    @FocusState private var correctAnsDisplayTextFieldInFocus: Bool
    
    
    @State private var resetTest: Bool = false
    
    var idealWhite: Color = Color(red: 240/255, green: 240/255, blue: 240/255)
    var idealBlack = Color(red: 11/255,green: 13/255, blue: 43/255)
    var idealShadowOpacity: Double = 0.3
    
    var body: some View {
        
        GeometryReader { geo in
        
            ZStack {
                
                Text("Modify Test Settings")
                    .font(.title)
                    .fontWeight(.bold)
                    .position(x: geo.size.width / 2, y: geo.size.height * 0)
                
                Button {
                    appManager.testState = .previewQuestions
                    appManager.testCreationTestState = .previewQuestions
                } label: {
                    Image(systemName: "xmark.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.height * 0.03)
                        .position(x: geo.size.width * 0.92, y: geo.size.height * 0)
                }
                .buttonStyle(.plain)
                
                
                ScrollView {
                    
                    
                    
                    RoundedRectangle(cornerRadius: 2)
                        .fill(generalData.idealBlack)
                        .frame(width: geo.size.width * 0.98, height: geo.size.height * 0.002)
                        .frame(maxWidth: .infinity)
                    
                    
                    
                    Button {
                        
                        //because it will always be wanted to be nothing at start
                        testManager.allQuestions = []
                        
                        testManager.createAllQuestions()
                        
                    } label: {
                        
                        ZStack {
                            
                           
                                
                            RoundedRectangle(cornerRadius: 14)
                                .fill(colorScheme == .light ? Color.white : Color.blue)
                                .stroke(colorScheme == .light ? Color.white : Color.blue, lineWidth: 2)
                                .shadow(radius: 10)
                                
                            Text("Create Questions")
                                .font(.system(size: 20))
                                .fontWeight(.black)
                                
                             
                            
                        }
                    }
                    .frame(width: geo.size.width * 0.5, height: geo.size.height * 0.08)
                    .buttonStyle(.plain)
                    
                    Spacer(minLength: idealSpacerLength)
                    
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
                                    .fill(colorScheme == .light ? Color.red : Color.white)
                                    .stroke(colorScheme == .light ? Color.yellow : Color.white, lineWidth: 2)
                                
                                    .shadow(radius: 10)
                                
                                Text("No Packages/Questions")
                                    .font(.system(size: 20))
                                    .fontWeight(.black)
                                    .foregroundStyle(colorScheme == .light ? .black : .red)
                            }
                        }
                    }
                    .frame(width: geo.size.width * 0.5, height: geo.size.height * 0.08)
                    .buttonStyle(.plain)
                    
                    Spacer(minLength: idealSpacerLength)
                    
                    Toggle("Enable Algorithmia", isOn: $testManager.allowTestAlgorithm)
                        .toggleStyle(.switch)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(colorScheme == .light ? idealWhite: idealBlack)
                                .stroke(generalData.getWhite(245), lineWidth: 3)
                                .frame(width: geo.size.width * 0.73, height: geo.size.height * 0.06)
                                .contextMenu {
                                    Text("Help")
                                    Divider()
                                    Text("This algorithim is designed to find the most relevant questions for you based on your previous answers.")
                                }
                        )
                        .frame(maxWidth: geo.size.width * 0.7)
                        .shadow(color: generalData.getShadowColor().opacity(0.1), radius: 10, x: 1, y: 1)
                        .popover(isPresented: $isAlgorithmPoppedOpen) {
                            ZStack {

                                VStack {
                                    Text("Help")
                                    Divider()
                                    Text("This algorithim is designed to find the most relevant questions for you based on your previous answers.")
                                    
                                    
                                }
                                
                            }
                        }
                    
                    Spacer(minLength: idealSpacerLength)
                  //  Spacer(minLength: idealSpacerLength)
                    
                    Toggle("Randomize Questions at start", isOn: $testManager.randomizeQuestionsAtStart)
                        .toggleStyle(.switch)
                        .background(
                            HStack {
                                
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(colorScheme == .light ? idealWhite: idealBlack)
                                    .stroke(generalData.getWhite(245), lineWidth: 3)
                                    .frame(width: geo.size.width * 0.73, height: geo.size.height * 0.06)
                                    
                            }
                        )
                        .frame(maxWidth: geo.size.width * 0.7)
                        .shadow(color: generalData.getShadowColor().opacity(0.1), radius: 10, x: 1, y: 1)
                    
                    Spacer(minLength: idealSpacerLength)
        
                   // Spacer(minLength: idealSpacerLength)
                    
                    ZStack {
                        
                        RoundedRectangle(cornerRadius: 14)
                            .fill(colorScheme == .light ? idealWhite : idealBlack)
                            .stroke(generalData.getWhite(245), lineWidth: 3)
                            .frame(width: geo.size.width * 0.71, height: geo.size.height * 0.06)
                            .shadow(color: generalData.getShadowColor().opacity(0.1), radius: 10, x: 1, y: 1)
                           
                        
                        
                        HStack {
                            Slider(value: $testManager.correctAnswerWaitingTime, in: 0...5)
                            
                            Text("Correct answer display time")
                            
                        }
                        
                    }
                    .fixedSize()
                    
                    Spacer(minLength: idealSpacerLength)
                    
                    
                    ZStack {
                        
                        RoundedRectangle(cornerRadius: 14)
                            .fill(colorScheme == .light ? idealWhite : idealBlack)
                            .stroke(generalData.getWhite(245), lineWidth: 3)
                            .frame(width: geo.size.width * 0.55, height: geo.size.height * 0.04)
                            
                            .shadow(color: generalData.getShadowColor().opacity(0.1), radius: 20, x: 1, y: 1)
                            .contextMenu {
                                Text("This is the amount of times a set question has to be correct for it to count as correct.")
                                Text("This is used for the algorithim and is only enabled when the algorithim is enabled.")
                            }
                        
                        
                        HStack {
                            
                            TextField("Integer", text: $tempCorrectAnswersToPass)
                                .padding(.vertical, geo.size.width * 0.003)
                                .padding(.horizontal, geo.size.width * 0.003)
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.gray, lineWidth: 1)
                                )
                                .focused($correctAnsDisplayTextFieldInFocus)
                                .onChange(of: tempCorrectAnswersToPass) {_, _ in
                                    let tempIntString = tempCorrectAnswersToPass
                                    testManager.amountofTimesAnswerCorrectToPass = Int(Double(tempIntString.filter {"-+0123456789".contains($0)}) ?? 0)
                                    
                                }
                                .frame(maxWidth: geo.size.width * 0.1)
                            
                        
                            Text("Memory protection")
                        }
                        
                    }
                    .fixedSize()
                   
                    Spacer(minLength: idealSpacerLength)
                    
                    ArchiveTestButton(geo: geo, oniOS: true)
                        .padding(20)
                    
                    Spacer(minLength: idealSpacerLength)
                    
                    LoadTestButton(geo: geo, oniOS: true)
                    
                    Spacer(minLength: idealSpacerLength)
                    
                   // Spacer(minLength: idealSpacerLength)
                    
                    Button {
                        
                        withAnimation(.smooth) {
                            resetTest = true
                        }
                        
                        testManager.resetTest()
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            //I wonder what will happen if you leave the view during this?
                            
                            withAnimation(.smooth) {
                                resetTest = false
                            }
                        }
                        
                    } label: {
                        
                        ZStack {
                            
                            RoundedRectangle(cornerRadius: 8)
                                .fill(colorScheme == .light ? generalData.getWhite(245) : generalData.idealBlack)
                                .stroke(.red, lineWidth: 4)
                            
                            Text(resetTest ? "Test Reset" : "Reset Test")
                                .fontWeight(.bold)
                                .foregroundStyle(.red)
                            
                        }
                        
                    }
                    .frame(width: geo.size.width * 0.3, height: geo.size.height * 0.05)
                    
                }
                .offset(y: geo.size.height * 0.05)
                
                
            }
            .onAppear {
                idealSpacerLength = geo.size.width * 0.05
            }
        }
        
    }
}


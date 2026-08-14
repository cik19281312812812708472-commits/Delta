//
//  iOS ViewCommander.swift
//  Delta
//
//  Created by Desire on 2026-03-06.
//


import SwiftUI


struct iOSViewCommander: View {
    
    @EnvironmentObject var appManager: AppManager
    @Environment(\.scenePhase) private var scenePhase
    @EnvironmentObject var testManager: TestManager
    @EnvironmentObject var generalData: GeneralData
    
    
   
    var body: some View {
        
        GeometryReader { geo in
        
            ZStack {
                
                Background(geo: geo)
                
                switch appManager.appState {
                    
                case .Tests:
                    iOSTestViewCommander()
                    
                default:
                    Text("")
                }
                
                if #available(iOS 17.6, *){
                    
                    if #available(iOS 26.0, macOS 26.0, *) { //#available(iOS 26.0, macOS 26.0, *)
                        HStack(alignment: .top) {
                         
                            
                            MenuBarButton(buttonFunction: {
                      
                                appManager.testState = .runningTest
                               
                            }, buttonImageSystemName: "brain", imageGeoWidthCoff: 0.05, imageGeoHeightCoff: 0, imageOffsetCofX: 0, imageOffsetCofY: 0, geo: geo)
                            
                            MenuBarButton(buttonFunction: {appManager.testState = appManager.testCreationTestState}, buttonImageSystemName: "hammer", imageGeoWidthCoff: 0.047, imageGeoHeightCoff: 0, imageOffsetCofX: 0, imageOffsetCofY: 0, geo: geo)
                            
                            MenuBarButton(buttonFunction: {appManager.testState = .testEnded}, buttonImageSystemName: "gauge.open.with.lines.needle.33percent", imageGeoWidthCoff: 0.05, imageGeoHeightCoff: 0, imageOffsetCofX: 0, imageOffsetCofY: -0.0015, geo: geo)
                                
                            
                            
                        }
                        .frame(width: geo.size.width * 0.5, height: geo.size.height * 0.07)
                        .background(
                            
                            RoundedRectangle(cornerRadius: 120)
                               .fill(.clear)
                               .glassEffect(.clear.tint(generalData.getWhite(204).opacity(0.5)))
                        )
                        
                        .position(x: geo.size.width / 2, y: geo.size.height * 0.95)
                        
                        if appManager.testState == .selectingPackages {
                            Button {
                                appManager.testState = .previewQuestions
                                appManager.testCreationTestState = .previewQuestions
                            } label: {
                                
                                ZStack {
                                    Circle()
                                        .fill(.clear)
                                        .stroke(.white, lineWidth: 1)
                                        .glassEffect()
                                        .frame(width: geo.size.height * 0.06, height: geo.size.height * 0.06)
                                    
                                    Image(systemName: "arrowshape.right.fill")
                                }
                                
                            }
                            .buttonStyle(.plain)
                            .position(x: geo.size.width * 0.9, y: geo.size.height * 0.95)
                        } else if appManager.testState == .previewQuestions {
                            
                            Button {
                                appManager.testState = .selectingPackages
                                appManager.testCreationTestState = .selectingPackages
                            } label: {
                                
                                ZStack {
                                    Circle()
                                        .fill(.clear)
                                        .stroke(.white, lineWidth: 1)
                                        .glassEffect()
                                        .frame(width: geo.size.height * 0.06, height: geo.size.height * 0.06)
                                    
                                    Image(systemName: "arrowshape.left.fill")
                                }
                                
                            }
                            .buttonStyle(.plain)
                            .position(x: geo.size.width * 0.1, y: geo.size.height * 0.95)
                        }
                        
                        
                    } else {
                        HStack(alignment: .top) {
                            
                            MenuBarButton(buttonFunction: {appManager.testState = .runningTest}, buttonImageSystemName: "brain", imageGeoWidthCoff: 0.05, imageGeoHeightCoff: 0, imageOffsetCofX: 0, imageOffsetCofY: 0, geo: geo)
                            
                            MenuBarButton(buttonFunction: {appManager.testState = .selectingPackages}, buttonImageSystemName: "hammer", imageGeoWidthCoff: 0.047, imageGeoHeightCoff: 0, imageOffsetCofX: 0, imageOffsetCofY: 0, geo: geo)
                            
                            MenuBarButton(buttonFunction: {appManager.testState = .testEnded}, buttonImageSystemName: "gauge.open.with.lines.needle.33percent", imageGeoWidthCoff: 0.05, imageGeoHeightCoff: 0, imageOffsetCofX: 0, imageOffsetCofY: -0.0015, geo: geo)
                            
                        }
                        .frame(width: geo.size.width * 0.5, height: geo.size.height * 0.07)
                        .background(
                            
                            RoundedRectangle(cornerRadius: 120)
                               .fill(.ultraThinMaterial)
                              
                        )
                        
                        .position(x: geo.size.width / 2, y: geo.size.height * 0.95)
                        
                        // Fallback on earlier versions
                    }
                }
                
                
            }
            
        }
        .onChange(of: scenePhase) {_, newPhase in
            switch newPhase {
                
          
                
            case .background:
                testManager.saveTest()
                testManager.setLastTestName()
           
            default:
                break
            }
            
        }
                  
    }
    
}

struct preview2 {
    
    static var appManager2: AppManager = AppManager()
    
    static var testManager = TestManager(theAppManager: preview2.appManager2)
    static var generalData = GeneralData()
    
    
    
    
}
// /*
#Preview {
    
    if true {
        
        iOSViewCommander()
            .environmentObject(preview2.appManager2)
            .environmentObject(preview2.testManager)
            .environmentObject(preview2.generalData)
    }
}
// */

 

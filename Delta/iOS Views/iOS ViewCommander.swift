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
                
                switch appManager.appState {
                    
                case .Tests:
                    iOSTestViewCommander()
                    
                default:
                    Text("")
                }
                
                
                
                
                if #available(iOS 17.6, *){
                    
                    if #available(iOS 26.0, macOS 26.0, *) { //#available(iOS 26.0, macOS 26.0, *)
                        HStack(alignment: .top) {
                         
                            
                            MenuBarButton(buttonFunction: {appManager.testState = .runningTest}, buttonImageSystemName: "brain", imageGeoWidthCoff: 0.05, imageGeoHeightCoff: 0, imageOffsetCofX: 0, imageOffsetCofY: 0, geo: geo)
                            
                            MenuBarButton(buttonFunction: {appManager.testState = .selectingPackages}, buttonImageSystemName: "hammer", imageGeoWidthCoff: 0.047, imageGeoHeightCoff: 0, imageOffsetCofX: 0, imageOffsetCofY: 0, geo: geo)
                            
                            MenuBarButton(buttonFunction: {appManager.testState = .testEnded}, buttonImageSystemName: "gauge.open.with.lines.needle.33percent", imageGeoWidthCoff: 0.05, imageGeoHeightCoff: 0, imageOffsetCofX: 0, imageOffsetCofY: -0.0015, geo: geo)
                                
                            
                            
                        }
                        .frame(width: geo.size.width * 0.5, height: geo.size.height * 0.07)
                        .background(
                            
                            RoundedRectangle(cornerRadius: 120)
                               .fill(.clear)
                               .glassEffect(.clear.tint(generalData.getWhite(204).opacity(0.5)))
                        )
                        
                        .position(x: geo.size.width / 2, y: geo.size.height * 0.95)
                        
                        
                        
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
    
    
    struct MenuBarButton: View {
        
        
        var buttonFunction: () -> Void
        
        var buttonImageSystemName: String
        var imageGeoWidthCoff: CGFloat
        var imageGeoHeightCoff: CGFloat
        var imageOffsetCofX: CGFloat
        var imageOffsetCofY: CGFloat
        
        var geo: GeometryProxy
        
        
        var body: some View {
            
         
            Button {
                buttonFunction()
            } label: {
                ZStack {
                    
                    if #available(macOS 26, iOS 26, *) {
                        Circle()
                            .fill(.clear)
                            .stroke(.white, lineWidth: 1)
                            .glassEffect()
                            .frame(width: geo.size.height * 0.06, height: geo.size.height * 0.06)
                    } else {
                        Circle()
                            .fill(.thickMaterial)
                            .stroke(.white, lineWidth: 1)
                            .frame(width: geo.size.height * 0.06, height: geo.size.height * 0.06)
                    }
                    
                    if imageGeoWidthCoff == 0 {
                        Image(systemName: buttonImageSystemName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: geo.size.height * imageGeoHeightCoff)
                            .offset(x: geo.size.height * imageOffsetCofX, y: geo.size.height * imageOffsetCofY)
                    } else if imageGeoHeightCoff == 0 {
                        Image(systemName: buttonImageSystemName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: geo.size.height * imageGeoWidthCoff)
                            .offset(x: geo.size.height * imageOffsetCofX, y: geo.size.height * imageOffsetCofY)
                    } else {
                        Image(systemName: buttonImageSystemName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: geo.size.height * imageGeoWidthCoff, height: geo.size.height * imageGeoHeightCoff)
                            .offset(x: geo.size.height * imageOffsetCofX, y: geo.size.height * imageOffsetCofY)
                    }
                        
                }
                    //.offset(x: geo.size.width * 0.01)
                    // Label("", systemImage: "")
            }
            .frame(maxWidth: .infinity)
            .buttonStyle(.plain)
            //Image(systemName: "gearshape.fill")
           // Image(systemName: "text.alignleft")
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

 

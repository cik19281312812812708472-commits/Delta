//
//  Load Test button.swift
//  Delta
//
//  Created by Desire on 2026-06-10.
//

import SwiftUI


struct ArchiveTestButton: View {
    
    @EnvironmentObject var testManager: TestManager
    @EnvironmentObject var generalData: GeneralData
    @Environment(\.colorScheme) var colorScheme
    
    
    
    var oniOS: Bool
    var geo: GeometryProxy
    @State private var testSavingState: TestSavingState = .notSaving
    @State private var isHovering: Bool = false
    
    enum TestSavingState {
        case notSaving
        case saving
        case saved
    }
    
    func delayResetingTestSavingState() {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            
            if testManager.savedTest == true {
                
                testSavingState = .saved
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    testSavingState = .notSaving
                }
                
            } else {
                delayResetingTestSavingState()
            }
        }
        
    }
    
    func archiveTest() {
        testManager.saveTest()
        
        testSavingState = .saving
            
        delayResetingTestSavingState()
    }
    
    
    var body: some View {
        Button {
          
           archiveTest()
           
        } label: {
            
            if oniOS {
                Forground(oniOS: oniOS, testSavingState: testSavingState, geo: geo)
                .shadow(color: generalData.getShadowColor().opacity(generalData.idealShadowOpacity), radius: 7, x: 1, y: 1)
                
            } else {
                Forground(oniOS: oniOS, testSavingState: testSavingState, geo: geo)
                    .shadow(color: generalData.getShadowColor().opacity(generalData.idealShadowOpacity), radius: 7, x: 1, y: 1)
                    .hoverEffect(width: oniOS ? geo.size.width * 0.5 : geo.size.width * 0.11, height: oniOS ? geo.size.height * 0.07 : geo.size.height * 0.03, cornerRadius: 8)
                    .contextMenu {
                        Text("Help")
                        Divider()
                        Text("This saves this test. So it can be used again.")
                    }
            }
            
            
            
            
        }
        .buttonStyle(.plain)
        
        
        
    }
    
    init(geo: GeometryProxy, oniOS: Bool) {
        self.geo = geo
        self.oniOS = oniOS
    }
    
    
    struct Background: View {
        
        @Environment(\.colorScheme) var colorScheme: ColorScheme
        @EnvironmentObject var generalData: GeneralData
        
        var oniOS: Bool
        var geo: GeometryProxy
        
        var body: some View {
            RoundedRectangle(cornerRadius: 8)
                .fill(colorScheme == .light ? generalData.getWhite(240): generalData.idealBlack)
                
                .stroke(generalData.getWhite(240), lineWidth: generalData.idealButtonLineWidth)
                .frame(width: oniOS ? 200 : geo.size.width * 0.11, height: oniOS ? 50 : geo.size.height * 0.03)
        }
            
    }
    
    struct Forground: View {
        
        var oniOS: Bool
        var testSavingState: TestSavingState
        var geo: GeometryProxy
        
        
        var body: some View {
            ZStack {
                //This will be made more beutiful later
                switch testSavingState {
                case .notSaving:
                    Text("Archive Test")
                        
                case .saving:
                    Text("Archiving")
                        
                case .saved:
                    Text("Archived!")
                       
                }
                
                
            }
            .animation(.smooth, value: testSavingState)
            .background(
                Background(oniOS: oniOS, geo: geo)
                    
            )
        }
        
    }
    
    
}

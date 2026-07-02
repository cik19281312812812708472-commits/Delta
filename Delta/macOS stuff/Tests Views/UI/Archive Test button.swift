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
    
    
    var body: some View {
        Button {
            
            
            testManager.saveTest()
            
            testSavingState = .saving
                
            delayResetingTestSavingState()
            
           
           
        } label: {
            ZStack {
                //This will be made more beutiful later
                switch testSavingState {
                case .notSaving:
                    Text("Archive Test")
                        .hoverEffect($isHovering, cornerRadius: 12)
                case .saving:
                    Text("Archiving")
                        .hoverEffect($isHovering, cornerRadius: 12)
                case .saved:
                    Text("Archived!")
                        .hoverEffect($isHovering, cornerRadius: 12)
                }
                
                
            }
            
            .animation(.smooth, value: true)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(colorScheme == .light ? generalData.getWhite(240): generalData.idealBlack)
                    
                    .stroke(generalData.getWhite(240), lineWidth: generalData.idealButtonLineWidth)
                    .frame(width: geo.size.width * 0.11, height: geo.size.height * 0.03)
                    .hoverEffect($isHovering, cornerRadius: 12)
                    .contextMenu {
                        Text("Help")
                        Divider()
                        Text("This saves this test. So it can be used again.")
                    }
            )
            .shadow(color: generalData.getShadowColor().opacity(generalData.idealShadowOpacity), radius: 7, x: 1, y: 1)
        }
        .onHover() { hovering in
            isHovering = hovering
            print(hovering)
        }
        .buttonStyle(.plain)
        
    }
    
    init(geo: GeometryProxy) {
        self.geo = geo
    }
}

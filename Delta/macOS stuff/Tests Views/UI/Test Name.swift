//
//  Test Name.swift
//  Delta
//
//  Created by Desire on 2026-06-10.
//

import SwiftUI


struct TestName: View {
    
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var testManager: TestManager
    @EnvironmentObject var generalData: GeneralData
    
    @State private var idealWhite: Color?
    @State private var changingTestName: Bool = false
    var geo: GeometryProxy
    
    
    var body: some View {
        
        ZStack {
            
            Color.clear.opacity(0.0).ignoresSafeArea()
                .contextMenu {
                    Button("Change Test Name") {
                        changingTestName = true
                    }
                }
            
            Text(testManager.testName.description)
                .font(.system(size: 20))
                .fontWeight(.black)
                .contextMenu {
                    Button("Change Test Name") {
                        changingTestName = true
                    }
                }
        }
        .fixedSize(horizontal: true, vertical: false)
        .frame(height: geo.size.height * 0.025)
        .padding(.vertical, geo.size.height * 0.002)
        .padding(.horizontal, geo.size.height * 0.005)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill((colorScheme == .light ? idealWhite : .black) ?? .white)
                .contextMenu {
                    Button("Change Test Name") {
                        changingTestName = true
                    }
                }
                .popover(isPresented: $changingTestName) {
                    
                    VStack {
                        Text("Test Name:")
                        TextField("test name", text: $testManager.testName)
                    }
                    .padding(.vertical, geo.size.height * 0.02)
                    .padding(.horizontal, geo.size.height * 0.05)
                }
        )
        .onAppear {
            idealWhite = generalData.getWhite(240)
        }
        .frame(maxWidth: geo.size.width * 0.3)
        .shadow(color: Color.black.opacity(generalData.idealShadowOpacity), radius: 10, x: 1, y: 1)
        
        
    }
    
    
    init(geo: GeometryProxy) {
        self.geo = geo
    }
    
}

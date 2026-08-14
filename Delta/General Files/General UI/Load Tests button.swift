//
//  Load Test button.swift
//  Delta
//
//  Created by Desire on 2026-06-11.
//

import SwiftUI


struct LoadTestButton: View {
    
    @EnvironmentObject var testManager: TestManager
    @EnvironmentObject var generalData: GeneralData
    
    @Environment(\.colorScheme) var colorScheme
    
    
    @State private var showingTests: Bool = false
    
    @State private var isHovering: Bool = false
    
    var geo: GeometryProxy
    var oniOS: Bool
    
    var body: some View {
        
        Button {
            
            showingTests = true
            
            testManager.findAllTests()
            
        } label: {
            
            if oniOS {
                ButtonLabel(oniOS: oniOS, geo: geo)
            } else {
                ButtonLabel(oniOS: oniOS, geo: geo)
                .hoverEffect(width: geo.size.width * 0.11, height: geo.size.height * 0.03, cornerRadius: 8, darkOpacity: oniOS ? 0.0 : 0.3, opacity: oniOS ? 0.0 : 0.3)
            }
        }
        .buttonStyle(.plain)
        .onAppear() {
            generalData.colorScheme = colorScheme
        }
        .onHover() { hovering in
            isHovering = hovering
        }
        .sheet(isPresented: $showingTests) {
            GeometryReader { sheetGeo in
                
                ZStack {
                    
                    ScrollView {
                        
                        Text("Choose a test to load:")
                            .font(.title.bold())
                        
                        Divider() 
                        
                        
                        ForEach(testManager.allTestNames, id: \.self) { testName in
                            TestButton(oniOS: oniOS, testName: testName, geo: sheetGeo)
                            Spacer()
                        }
                    }
                    .frame(width: sheetGeo.size.width, height: sheetGeo.size.height)
                    .position(x: sheetGeo.size.width / 2, y: sheetGeo.size.height / 2)
                    
                    Button {
            
                        showingTests = false
                        
                    } label: {
                        Image(systemName: "xmark.circle")
                            
                    }
                    .position(x: sheetGeo.size.width * 0.97, y: sheetGeo.size.height * 0.02)
                    .buttonStyle(.plain)
                    
                }
                
            }
            .frame(width: oniOS ? geo.size.width : geo.size.width * 0.5, height: oniOS ? geo.size.height : geo.size.height * 0.5) // the size of the sheet
        }
        
    }
    
    
    init(geo: GeometryProxy, oniOS: Bool) {
        self.geo = geo
        self.oniOS = oniOS
    }
    
    private struct ButtonLabel: View {
        
        @Environment(\.colorScheme) var colorScheme: ColorScheme
        
        @EnvironmentObject var generalData: GeneralData
        
        var oniOS: Bool
        var geo: GeometryProxy
        
        var body: some View {
            ZStack {
              Text("Load Archived Tests")
            }
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(colorScheme == .light ? generalData.getWhite(240) : generalData.idealBlack)
                    .stroke(generalData.getWhite(240), lineWidth: generalData.idealButtonLineWidth)
                    .frame(width: oniOS ? geo.size.width * 0.67 : geo.size.width * 0.11, height: oniOS ? geo.size.height * 0.05 : geo.size.height * 0.03)
                    
                )
            
            .shadow(color: generalData.getShadowColor().opacity(generalData.idealShadowOpacity), radius: 7, x: 1, y: 1)
        }
        
        
    }
    
    
    
}



extension LoadTestButton {
    
    struct TestButton: View {
        
        @EnvironmentObject var generalData: GeneralData
        @EnvironmentObject var testManager: TestManager
        @Environment(\.colorScheme) var colorScheme
        
        var oniOS: Bool 
        var testName: String
        var geo: GeometryProxy
        
        var body: some View {
            
            ZStack {
                
                Button {
                  
                    testManager.loadTestData(name: testName)
                    testManager.loadTest()
                    
                } label: {
                    
                    ZStack(alignment: .leading) {
                        
                        // - Background
                        // this is here for highlighting
                        
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(colorScheme == .dark ? generalData.getWhite(254) : generalData.idealBlack, lineWidth: 4)
                            .fill(colorScheme == .light ? generalData.getWhite(254) : generalData.idealBlack)
                            
                            
                        
                        
                        
                        HStack {
                            ZStack {
                                Color.clear
                            }
                            .frame(width: 0, height: 0)
                            .padding(2)
                           
                            
                            Image(systemName: "chart.line.text.clipboard")
                                .resizable()
                                .scaledToFit()
                                .frame(width: oniOS ? geo.size.width * 0.1 : geo.size.width * 0.03, height: oniOS ? geo.size.width * 0.1 : geo.size.width * 0.03)
                            
                            
                            Text(testName)
                        }
                        
                        
                    }
                    
                    
                }
                .contextMenu {
                    Button("Delete Test") {
                        withAnimation(.smooth) {
                            testManager.deleteTest(testName: testName)
                        }
                    }
                }
                //.hoverEffect(cornerRadius: 8)
                .buttonStyle(.plain)
                
            }
            .frame(width: oniOS ? geo.size.width * 0.5 : geo.size.width * 0.2, height: geo.size.height * 0.102)
           
            
            
        }
        
    }
    
    
}

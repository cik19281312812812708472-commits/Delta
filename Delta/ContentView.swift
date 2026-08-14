//
//  ContentView.swift
//  Delta
//
//  Created by Desire on 2026-03-06.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @EnvironmentObject var generalData: GeneralData
    
    var body: some View {
    
        ZStack {
            
            #if os(iOS)
            iOSViewCommander()
            #endif // os(iOS)
            
            #if os(macOS)
            macOSViewCommander()
            #endif
        }
        .onAppear() {
            generalData.colorScheme = colorScheme
        }
        .onChange(of: colorScheme) {
            if colorScheme != self.generalData.colorScheme {
                self.generalData.colorScheme = colorScheme
            }
        }
    }
}

#Preview {
    ContentView()
}

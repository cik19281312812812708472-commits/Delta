//
//  ContentView.swift
//  Delta
//
//  Created by Desire on 2026-03-06.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
    
        
        
        #if os(iOS)
        iOSViewCommander()
        #endif // os(iOS)
        
        #if os(macOS)
        macOSViewCommander()
        #endif
        
    }
}

#Preview {
    ContentView()
}

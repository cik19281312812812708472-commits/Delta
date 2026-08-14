//
//  General Data.swift
//  Delta
//
//  Created by Desire on 2026-06-10.
//


import Foundation
import Combine
import SwiftUI

class GeneralData: ObservableObject {
    
    
    @Published var idealBlack = Color(red: 11/255,green: 13/255, blue: 43/255)
    @Published var idealShadowOpacity: Double = 0.3
    
    @Published var colorScheme: ColorScheme? = nil
    
    @Published var idealButtonLineWidth: Double = 1.5
    
    var oniOS: Bool = false
    
    func getWhite(_ shade: Double) -> Color {
        
        let white = Color(red: shade/255, green: shade/255, blue: shade/255)
        
        return white
    }
    
    func getShadowColor() -> Color {
        
        //var shadowColor: Color
        
        guard let colorScheme = colorScheme else {
            return idealBlack
        }
        
        return colorScheme == .light ? idealBlack : getWhite(100)
    }
    
    init() {
        
    #if os(iOS)
        oniOS = true
    #endif
        
    }
    
}

extension GeneralData {
    
    struct iOSDivider: View {
        var body: some View {
            
            
            Divider()
                .background(Color.black.opacity(0.1))
                .padding(.horizontal, 10)
        }
    }
    
}


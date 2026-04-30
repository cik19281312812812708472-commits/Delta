//
//  Background.swift
//  Delta
//
//  Created by Desire on 2026-04-26.
//

import SwiftUI


///Thsi creates a rectangle that has custom background colours
struct Background: View {
    
    @Environment(\.colorScheme) var colorScheme
    var geo: GeometryProxy
    
    var body: some View {
        
        Rectangle()
            .fill(colorScheme == .light ? Color.white : Color(red: 0.1803, green: 0.1764, blue: 0.1764 ))
            .frame(width: geo.size.width, height: geo.size.height)
        
        
        
    }
    
    init(geo: GeometryProxy) {
        self.geo = geo
    }
    
    
}

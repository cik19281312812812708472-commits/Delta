//
//  Hovering View modifier.swift
//  Delta
//
//  Created by Desire on 2026-06-15.
//

import SwiftUI

extension View {
    func hoverEffect(_ isHovering: Binding<Bool>? = nil, width: CGFloat? = nil, height: CGFloat? = nil, cornerRadius: Double = 0) -> some View {
        self.modifier(HoverViewModifier(isHovering: isHovering, cornerRadius: cornerRadius, width: width, height: height))
    }
}


struct HoverViewModifier: ViewModifier {
    
    @State private var isHovering: Bool = false
    @Environment(\.colorScheme) var colorScheme
    
    @Binding var isHoveringState: Bool
    
    var controllingHovering: Bool = false
    var cornerRadius: Double
    var width: CGFloat?
    var height: CGFloat?
    
    init(isHovering: Binding<Bool>? = nil, cornerRadius: Double, width: CGFloat? = nil, height: CGFloat? = nil) {
        
        if isHovering == nil {
            controllingHovering = true
        }
        //let t = false
        self._isHoveringState = isHovering ?? Binding( get: {false}, set: {_ in})
   
        self.cornerRadius = cornerRadius
        self.width = width
        self.height = height
       
    }
    
    func body(content: Content) -> some View {
        content
            .frame(width: width, height: height)
            .contentShape(Rectangle())
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill (
                isHovering ?
                
                colorScheme == .light ? .white.opacity(0.3) : Color(red: 11/255, green: 11/255, blue: 17/255).opacity(0.1)
                
                : .clear
                )
                    
            )
            .onHover() { hovering in
                
                if controllingHovering == true {
                    isHovering = hovering
                    
                } else {
                    isHovering = isHoveringState
                }
            }
            
    }
    
}

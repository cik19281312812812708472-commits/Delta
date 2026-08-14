//
//  Hovering View modifier.swift
//  Delta
//
//  Created by Desire on 2026-06-15.
//

import SwiftUI

extension View {
    func hoverEffect(_ isHovering: Binding<Bool>? = nil, width: CGFloat? = nil, height: CGFloat? = nil, cornerRadius: Double = 0, color: Color = .white, darkColor: Color? = Color(red: 11/255, green: 11/255, blue: 17/255), darkOpacity: Double = 0.1, opacity: Double = 0.3) -> some View {
        self.modifier(HoverViewModifier(isHovering: isHovering, cornerRadius: cornerRadius, width: width, height: height,color: color, darkColor: darkColor, darkOpacity: darkOpacity, opacity: opacity))
    }
}


struct HoverViewModifier: ViewModifier {
    
    @State private var isHovering: Bool = false
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.self) var envirionment
    
    @Binding var isHoveringState: Bool
    
    var controllingHovering: Bool = false
    var cornerRadius: Double
    var width: CGFloat?
    var height: CGFloat?
    var color: Color
    var darkColor: Color
    var opacity: Double
    var darkOpacity: Double
    
    init(isHovering: Binding<Bool>? = nil, cornerRadius: Double, width: CGFloat? = nil, height: CGFloat? = nil, color: Color, darkColor: Color?, darkOpacity: Double, opacity: Double) {
        
        if isHovering == nil {
            controllingHovering = true
        }
        //let t = false
        self._isHoveringState = isHovering ?? Binding( get: {false}, set: {_ in})
   
        self.cornerRadius = cornerRadius
        self.width = width
        self.height = height
        self.color = color
        self.opacity = opacity
        self.darkColor = .black
        self.darkOpacity = darkOpacity
        
        if darkColor == nil {
            let resolvedColor = color.resolve(in: envirionment)
            
            let trueDarkColor = Color(red: abs(Double(resolvedColor.red) - 1), green:  abs(Double(resolvedColor.green) - 1), blue: abs(Double(resolvedColor.blue) - 1))
            
            self.darkColor = trueDarkColor
            
        } else {
            self.darkColor = darkColor!
        }
        
        
        
       
    }
    
    
    
    
    func body(content: Content) -> some View {
        content
            .frame(width: width, height: height)
            .contentShape(Rectangle())
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill (
                isHovering ?
                
                colorScheme == .light ? color.opacity(opacity) : darkColor.opacity(darkOpacity)
                
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

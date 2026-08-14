//
//  MenuBar Button.swift
//  Delta
//
//  Created by Desire on 2026-07-15.
//

import SwiftUI

extension iOSViewCommander {
    
    struct MenuBarButton: View {
        
        
        var buttonFunction: () -> Void
        
        var buttonImageSystemName: String
        var imageGeoWidthCoff: CGFloat
        var imageGeoHeightCoff: CGFloat
        var imageOffsetCofX: CGFloat
        var imageOffsetCofY: CGFloat
        
        var geo: GeometryProxy
        
        
        var body: some View {
            
         
            Button {
                buttonFunction()
            } label: {
                ZStack {
                    
                    if #available(macOS 26, iOS 26, *) {
                        Circle()
                            .fill(.clear)
                            .stroke(.white, lineWidth: 1)
                            .glassEffect()
                            .frame(width: geo.size.height * 0.06, height: geo.size.height * 0.06)
                    } else {
                        Circle()
                            .fill(.thickMaterial)
                            .stroke(.white, lineWidth: 1)
                            .frame(width: geo.size.height * 0.06, height: geo.size.height * 0.06)
                    }
                    
                    if imageGeoWidthCoff == 0 {
                        Image(systemName: buttonImageSystemName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: geo.size.height * imageGeoHeightCoff)
                            .offset(x: geo.size.height * imageOffsetCofX, y: geo.size.height * imageOffsetCofY)
                    } else if imageGeoHeightCoff == 0 {
                        Image(systemName: buttonImageSystemName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: geo.size.height * imageGeoWidthCoff)
                            .offset(x: geo.size.height * imageOffsetCofX, y: geo.size.height * imageOffsetCofY)
                    } else {
                        Image(systemName: buttonImageSystemName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: geo.size.height * imageGeoWidthCoff, height: geo.size.height * imageGeoHeightCoff)
                            .offset(x: geo.size.height * imageOffsetCofX, y: geo.size.height * imageOffsetCofY)
                    }
                        
                }
                    //.offset(x: geo.size.width * 0.01)
                    // Label("", systemImage: "")
            }
            .frame(maxWidth: .infinity)
            .buttonStyle(.plain)
            //Image(systemName: "gearshape.fill")
           // Image(systemName: "text.alignleft")
        }
        
        
    }
    
    
}

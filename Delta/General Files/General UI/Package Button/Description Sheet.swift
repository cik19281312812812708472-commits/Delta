//
//  Description Sheet.swift
//  Delta
//
//  Created by Desire on 2026-07-13.
//

import SwiftUI
import TestCreation

extension PackageButton {
    
    struct DescriptionSheet: View {
        
        var package: any Package
        var geo: GeometryProxy
        var oniOS: Bool
        @Binding var isDescriptionShown: Bool
        
        
        var body: some View {
            GeometryReader { sheetGeo in
                ZStack {
                  
                    ScrollView {
                        Text("Description")
                            .font(.title.bold())
                        
                        Divider()
                        
                        //what if the package changes its description?
                        Text(package.packageDescription)
                            .textSelection(.enabled)
                        
                        
                    }
                    
                    Button {
            
                        isDescriptionShown.toggle()
                    } label: {
                        Image(systemName: "xmark.circle")
                            .position(x: sheetGeo.size.width * 0.95, y: sheetGeo.size.height * 0.05)
                    }
                    .buttonStyle(.plain)
                    
                }
              
            }
            
        }
        
    }
}

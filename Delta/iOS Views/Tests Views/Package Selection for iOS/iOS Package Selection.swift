//
//  Package Selection.swift
//  Delta
//
//  Created by Desire on 2026-07-10.
//

import SwiftUI



struct iOSPackageSelection: View {
    
    @EnvironmentObject var generalData: GeneralData
    @EnvironmentObject var testManager: TestManager
    @EnvironmentObject var appState: AppManager
    
    var body: some View {
        
        
        GeometryReader { geo in
        
            ZStack {
                
                
                /*Rectangle()
                    .fill(
                        LinearGradient(colors: [.black, .clear], startPoint: .top, endPoint: .bottom)
                        )
                    .frame(width: geo.size.width, height: geo.size.height * 0.05)
                    .position(x: geo.size.width / 2, y: geo.size.height * -0.05)*/
                
                Text("Choose a Module: ")
                    .font(.title)
                    .fontWeight(.bold)
                    .position(x: geo.size.width / 2, y: geo.size.height * 0)
                
                
               
                
                ScrollView {
                    
                    RoundedRectangle(cornerRadius: 2)
                        .fill(generalData.idealBlack)
                        .frame(width: geo.size.width * 0.98, height: geo.size.height * 0.002)
                        .frame(maxWidth: .infinity)
                    
                    
                    ForEach($appState.allPackages, id: \.id) { $unePackage in
                 
                        PackageButton(geo: geo, package: unePackage, oniOS: true)
                           
                    }
                    
                }
                .offset(y: geo.size.height * 0.05)
               
                
            }
            
            
        }
        
        
        
    }
    
    
    
}

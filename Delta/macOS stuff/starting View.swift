//
//  starting View.swift
//  Delta
//
//  Created by Desire on 2026-04-26.
//

import SwiftUI


struct startingScreen: View {
    
    @EnvironmentObject var appManager: AppManager
   
    
    
    
    var body: some View {
        
        GeometryReader { geo in
            
        ZStack {
            
            //make this custom
            Background(geo: geo)
              
            
            
            Image("Delta Screen")
                .renderingMode(.original)
                .resizable()
                .scaledToFit()
                .frame(width: geo.size.width * 0.3, height: geo.size.height * 0.3)
                .position(x: geo.size.width/2, y: geo.size.height * 0.1)
            
            
            Button {
                appManager.testState = .selectingPackages
                appManager.appState = .Tests
            } label: {
                Image("Tests button")
                    .renderingMode(.original)
                    .resizable()
                    .scaledToFit()
                    .frame(width: geo.size.width * 0.2, height: geo.size.height * 0.2)
                    
            }
            .buttonStyle(.plain)
            .padding(10)
            
           QuestionInfo(geo: geo)
                .position(x: geo.size.width * 0.95, y: geo.size.height * 0.95)
            
            //only add the ui "dooer" if the ui is plenty
            //add reactive flash card view
            /* packages will be selected in the test selection screen each packages question ammoutn will be added into a question thing
            Image("Packages button")
                .renderingMode(.original)
                .resizable()
                .scaledToFit()
                .padding(10)
            */
            }
            
        }
        
        
        
    }
    
    
    
    
    
    
    
}

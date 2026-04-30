//
//  QuestionInfo .swift
//  Delta
//
//  Created by Desire on 2026-04-26.
//

import SwiftUI




struct QuestionInfo: View {
    
    var geo: GeometryProxy
    
    @State private var questionMenu: Bool = false
    
    @EnvironmentObject var appState: AppManager
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        
        Button {
            
            questionMenu.toggle()
            
        } label: {
            
            ZStack {
                Circle()
                    .fill(.ultraThinMaterial)
                    .frame(width: geo.size.width * 0.025, height: geo.size.width * 0.025)
                
                Circle()
                    .fill(Color.accentColor.opacity(0.3))
                    .frame(width: geo.size.width * 0.025, height: geo.size.width * 0.025)
                    .shadow(color: .accentColor.opacity(0.7), radius: 8, x: 1, y: 1)
                
                Image(systemName:  "questionmark")
                
               
            }
        }
        .popover(isPresented: $questionMenu) {
            
            HStack {
                Spacer()
                VStack {
                    Text("Help")
                        .font(Font.largeTitle.bold())
                    Divider()
                    Text(appState.appState == .Tests ? appState.testState.helpInfo : appState.appState.helpInfo)
                    Spacer(minLength: 30)
                    
                }
                Spacer()
            }
        }
        .buttonStyle(.plain)
       
        
        
    }
    
    init(geo: GeometryProxy) {
        self.geo = geo
    }
    
    
}

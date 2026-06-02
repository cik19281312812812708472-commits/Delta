//
//  Version Number.swift
//  Delta
//
//  Created by Desire on 2026-06-02.
//

import SwiftUI



struct versionNumber: View {
    
    @EnvironmentObject var appData: AppManager
    
    var geo: GeometryProxy
    
    @State private var versionText: String = ""
    
    var contextMenuText: String = """
    This version added French Practise's omit questions.
    It also added this.
    """
    
    
    var body: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(.gray.opacity(0.2))
                .frame(width: geo.size.width * 0.03, height: geo.size.height * 0.03)
                .shadow(radius: 3)
                .contextMenu() {
                    Text(contextMenuText)
                }
            
            
            Text(versionText)
                .font(.subheadline)
                .contextMenu() {
                    Text(contextMenuText)
                }
            
        }
        .onAppear() {
            versionText = "v " + appData.appVersion.description
        }
       
    }
    
    init(geo: GeometryProxy) {
        self.geo = geo
    }
    
    
    
    
    
    
}

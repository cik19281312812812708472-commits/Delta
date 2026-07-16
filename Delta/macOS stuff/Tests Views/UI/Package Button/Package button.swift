//
//  Package button.swift
//  Delta
//
//  Created by Desire on 2026-04-26.
//

import SwiftUI
import Combine
import TestCreation



struct PackageButton: View {
    
    var geo: GeometryProxy
    var package: any Package
    var oniOS: Bool
   
    @Environment(\.colorScheme) var colorScheme
    
    @EnvironmentObject var testManager: TestManager
    @EnvironmentObject var generalData: GeneralData
    
    @State private var isSettingsShown: Bool = false
    @State private var isDescriptionShown: Bool = false
    @State private var packageSelected: Bool = false
    
    
    
   
    var idealBlack = Color(red: 11/255,green: 13/255, blue: 43/255)
    
    
    var body: some View {
        

            Button {
                
           
               
                
                if testManager.packagesSelected.contains(package.id) {
                    
                    testManager.packagesSelected.removeAll { $0 == package.id }
                    testManager.packagesNotSelected.append(package.id)
                    
                    
                } else {
                   
                    testManager.packagesNotSelected.removeAll { $0 == package.id}
                    testManager.packagesSelected.append(package.id)
                }
                
              
            } label: {
                ZStack(alignment: .leading) {
                    
                    
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(red: 0.8, green: 0.8, blue: 0.8, opacity: 1.0))
                        .overlay {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(
                                    colorScheme == .light ?  Color(red: 245/255, green: 242/255, blue: 240/255) : idealBlack
                                )
                                .stroke(testManager.packagesSelected.contains(package.id) == true ? Color.accentColor : Color.white, lineWidth: testManager.packagesSelected.contains(package.id) == true ? 3 : 2)
                        }
                        .shadow(color: oniOS ?
                                generalData.getShadowColor().opacity(0.1)
                                :
                                    generalData.getShadowColor().opacity(generalData.idealShadowOpacity),
                                radius: 8, x: 1, y: 1)
                    
                    HStack {
                 
                        
                        switch package.packageType {
                        case .undescripedPackage:
                            PackageImage(packageType: package.packageType, geo: geo, oniOS: oniOS)
                                .offset(x: oniOS == false ? 0 : geo.size.width * 0.01)
                        case .mathPackage:
                            PackageImage(packageType: package.packageType, geo: geo, oniOS: oniOS)
                                .offset(x: oniOS == false ? 0 : geo.size.width * 0.01)
                        case .languagePackage:
                            PackageImage(packageType: package.packageType, geo: geo, oniOS: oniOS)
                                .offset(x: oniOS == false ? 0 : geo.size.width * 0.01)
                        case .highLevelMathPackage:
                            PackageImage(packageType: package.packageType, geo: geo, oniOS: oniOS)
                                .offset(x: oniOS == false ? 0 : geo.size.width * 0.01)
                        case .sciencePackage:
                            PackageImage(packageType: package.packageType, geo: geo, oniOS: oniOS)
                                .offset(x: oniOS == false ? 0 : geo.size.width * 0.01)
                        case .spokenLanguagePackage:
                            PackageImage(packageType: package.packageType, geo: geo, oniOS: oniOS)
                                .offset(x: oniOS == false ? 0 : geo.size.width * 0.01)
                        }
                        
                        
                        Text(package.publicName)
                            .foregroundStyle(colorScheme == .light ? Color.black : Color.white)
                        
                    }
                    
                }
                .hoverEffect(cornerRadius: 10)
                .frame(
                    width: oniOS == false ?
                        geo.size.width * 0.1
                        :
                        geo.size.width * 0.67,
                    
                        height: oniOS == false ?
                        geo.size.height * 0.05
                        :
                        geo.size.height * 0.12
                )
                
                
            }
            .buttonStyle(.plain)
            .contextMenu {
                
                HStack {
                    Button("See Settings") {
                        isSettingsShown.toggle()
                    }
                    
                    Button("See Description") {
                        isDescriptionShown.toggle()
                    }
                }
            
            }
            .sheet(isPresented: $isSettingsShown) {
                
                if oniOS == false {
                    SettingsSheet(package: package, geo: geo, oniOS: oniOS, isSettingsShown: $isSettingsShown)
                        .frame(width: geo.size.width * 0.3, height: geo.size.height * 0.3)
                } else {
                    SettingsSheet(package: package, geo: geo, oniOS: oniOS, isSettingsShown: $isSettingsShown)
                       // .frame(width: geo.size.width * 0.95)
                }
                
                
            } 
            .sheet(isPresented: $isDescriptionShown ) {
                if oniOS == false {
                    DescriptionSheet(package: package, geo: geo, oniOS: oniOS, isDescriptionShown: $isDescriptionShown)
                        .frame(width: geo.size.width * 0.3, height: geo.size.height * 0.3)
                } else {
                    DescriptionSheet(package: package, geo: geo, oniOS: oniOS, isDescriptionShown: $isDescriptionShown)
                        //.frame(width: geo.size.width * 0.95)
                }
            }
        
        
    }
    
    init(geo: GeometryProxy, package: any Package, oniOS: Bool = false) {
        self.geo = geo
        self.package = package
        self.oniOS = oniOS
      
    }
    
    
    struct PackageImage: View {
        
        var packageType: PackageTypes
        var geo: GeometryProxy
        var oniOS: Bool
        
        var body: some View {
            
            ZStack {
                Circle()
                    .fill(Color.accentColor.opacity(0.3))
                    .frame(width: oniOS == false ? geo.size.width * 0.03 : geo.size.width * 0.09, height: oniOS == false ? geo.size.height * 0.03 : geo.size.width * 0.09)
                
                     
                
                switch packageType {
                case .undescripedPackage:
                    Image(systemName: "shippingbox")
                        .resizable()
                        .scaledToFit()
                        .frame(width: oniOS == false ? geo.size.width * 0.025 : geo.size.width * 0.079, height: oniOS == false ? geo.size.height * 0.025 : geo.size.width * 0.079)
                case .mathPackage:
                    Image(systemName: "pi")
                        .resizable()
                        .scaledToFit()
                        .frame(width: oniOS == false ? geo.size.width * 0.018 : geo.size.width * 0.07, height: oniOS == false ? geo.size.height * 0.018 : geo.size.width * 0.07)
                case .languagePackage:
                    Image(systemName: "bubble.left.and.text.bubble.right.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: oniOS == false ? geo.size.width * 0.025 : geo.size.width * 0.079, height: oniOS == false ? geo.size.height * 0.025 : geo.size.width * 0.079)
                case .highLevelMathPackage:
                    Image(systemName: "function")
                        .resizable()
                        .scaledToFit()
                        .frame(width: oniOS == false ? geo.size.width * 0.0147 : geo.size.width * 0.079, height: oniOS == false ? geo.size.height * 0.025 : geo.size.width * 0.079)
                case .spokenLanguagePackage:
                    Image(systemName: "bubble.left.and.text.bubble.right.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: oniOS == false ? geo.size.width * 0.02 : geo.size.width * 0.079, height: oniOS == false ? geo.size.height * 0.022 : geo.size.width * 0.079)
                case .sciencePackage:
                    Image(systemName: "atom")
                        .resizable()
                        .scaledToFit()
                        .frame(width: oniOS == false ? geo.size.width * 0.025 : geo.size.width * 0.079, height: oniOS == false ? geo.size.height * 0.025 : geo.size.width * 0.079)
                }
                
                
                //make it binging
                
            }
            .frame(width: oniOS == false ? geo.size.width * 0.03 : geo.size.width * 0.09, height: oniOS == false ? geo.size.height * 0.03 : geo.size.width * 0.1)
            
        }
    
    }
    
    
    
    
}

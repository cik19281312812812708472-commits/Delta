//
//  Package button.swift
//  Delta
//
//  Created by Desire on 2026-04-26.
//

import SwiftUI
import Combine



struct PackageButton: View {
    
    var geo: GeometryProxy
    var package: any Package
   
    @Environment(\.colorScheme) var colorScheme
    
    @EnvironmentObject var testManager: TestManager
    
    @State private var isSettingsShown: Bool = false
    @State private var isDescriptionShown: Bool = false
    @State private var packageSelected: Bool = false
    
    
    @State private var allChangableBools: [boolSetting] = []
    @State private var allChangeableInts: [intSetting] = []
    @State private var allChangeableDoubles: [doubleSetting] = []
    
    
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
                                .fill(Color(red: 245/255, green: 242/255, blue: 240/255))
                                .stroke(testManager.packagesSelected.contains(package.id) == true ? Color.accentColor : Color.white, lineWidth: testManager.packagesSelected.contains(package.id) == true ? 2 : 1)
                        }
                        .shadow(color: colorScheme == .light ? .black.opacity(0.1) : .white.opacity(0.1), radius: 8, x: 1, y: 1)
                    
                    HStack {
                        
                        ZStack {
                            Circle()
                                .fill(Color.accentColor.opacity(0.3))
                                .frame(width: geo.size.width * 0.03, height: geo.size.height * 0.03)
                                
                            
                            Image(systemName: "shippingbox")
                                .resizable()
                                .scaledToFit()
                                .frame(width: geo.size.width * 0.025, height: geo.size.height * 0.025)
                            //make it binging
                            
                        }
                        .frame(width: geo.size.width * 0.03, height: geo.size.height * 0.03)
                        
                        Text(package.publicName)
                            .foregroundStyle(colorScheme == .light ? Color.black : Color.white)
                        
                    }
                    
                }
                .frame(width: geo.size.width * 0.1, height: geo.size.height * 0.05)
                
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
                
                GeometryReader { sheetGeo in
                    ZStack {
                        
                       
                    
                        ScrollView {
                            Text("Settings")
                                .font(.title.bold())
                            
                            Divider()
                            //you can only mutate unknowns with funcs
                            
                            //Bool settings
                            ForEach($allChangableBools) { $setting in
                                Toggle(setting.name, isOn: $setting.bool)
                                    .toggleStyle(.switch)
                            }
                            if allChangableBools.count > 0 {
                                Divider()
                            }
                            ForEach($allChangeableInts) { $setting in
                           
                                
                                
                                HStack {
                                    TextField("Integer", text: $setting.tempIntString)
                                        .onChange(of: setting.tempIntString) {_ in
                                            let tempIntString = setting.tempIntString
                                            setting.int = Int(tempIntString.filter {"-+.0123456789".contains($0)}) ?? 0
                                            
                                        }
                                        .frame(width: sheetGeo.size.width * 0.15)
                                    Text(setting.name)
                                }
                                  
                            }
                            
                            
                            ForEach($allChangeableDoubles) { $setting in
                                
                                HStack {
                                    TextField("Double", text: $setting.tempDoubleString)
                                        .onChange(of: setting.tempDoubleString) {_ in
                                            let tempIntString = setting.tempDoubleString
                                            setting.double = Double(tempIntString.filter {"-+0123456789".contains($0)}) ?? 0
                                            
                                        }
                                        .frame(width: sheetGeo.size.width * 0.15)
                                    Text(setting.name)
                                }
                                
                            }
                            
                        }
                        
                        //close button
                        Button {
                            
                            //here we first change every setting of our stored package
                            for i in 0..<allChangableBools.count {
                                
                                let boolToChange = allChangableBools[i]
                                
                                package.changeABool(i, to: boolToChange.bool)
            
                            }
                      
                            for i in 0..<allChangeableInts.count {
                                
                                
                                let intToChange = allChangeableInts[i]
                                //this si so the user can recieve feedback on how only Ints are allowd
                                allChangeableInts[i].tempIntString = String(allChangeableInts[i].int)
                                
                                package.changeAnInt(i, to: intToChange.int)
                            
                            }
                            
                            for i in 0..<allChangeableDoubles.count {
                                
                                let doubleToChange = allChangeableDoubles[i]
                                
                                allChangeableDoubles[i].tempDoubleString = String(allChangeableDoubles[i].double)
                                
                                package.changeADouble(i, to: doubleToChange.double)
                            }
                            
                         
                            //now we modify the global one
                            testManager.allPackages[package.id] = package
                            
                            //now we modify settings
                            testManager.allPackages[package.id]?.updateInternalSettings()
                            
                            
                            isSettingsShown.toggle()
                        } label: {
                            Image(systemName: "xmark.circle")
                                .position(x: sheetGeo.size.width * 0.95, y: sheetGeo.size.height * 0.05)
                        }
                        .buttonStyle(.plain)
                        
                    }
    
                }
                .frame(width: geo.size.width * 0.3, height: geo.size.height * 0.3)
                
            } .onAppear {
            
                allChangableBools = package.allChangbleBools
                allChangeableInts = package.allChangbleInts
                allChangeableDoubles = package.allChangbleDoubles
                
                
            }
            .sheet(isPresented: $isDescriptionShown ) {
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
                .frame(width: geo.size.width * 0.3, height: geo.size.height * 0.3)
            }
        
        
    }
    
    init(geo: GeometryProxy, package: any Package) {
        self.geo = geo
        self.package = package
      
    }
}

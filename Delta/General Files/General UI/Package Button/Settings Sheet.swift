//
//  Settings Sheet.swift
//  Delta
//
//  Created by Desire on 2026-07-12.
//

import SwiftUI
import TestCreation

extension PackageButton {
    
    
    struct SettingsSheet: View {
        
        @EnvironmentObject var testManager: TestManager
        
        var package: any Package
        var geo: GeometryProxy
        var oniOS: Bool
        @Binding var isSettingsShown: Bool
        
        @State private var allChangableBools: [boolSetting] = []
        @State private var allChangeableInts: [intSetting] = []
        @State private var allChangeableDoubles: [doubleSetting] = []
        
        @State private var scrollViewWidth: CGFloat = 0
        
        
        
        var body: some View {
            GeometryReader { sheetGeo in
                ZStack {
                    
                    ScrollView() {
                        Text("Settings")
                            .font(.title.bold())
                        
                        Divider()
                        //you can only mutate unknowns with funcs
                        
                        //Bool settings
                        ForEach($allChangableBools) { $setting in
                            Toggle(setting.name, isOn: $setting.bool)
                                .toggleStyle(.switch)
                                .contextMenu() {
                                    Text(setting.description != "" ? setting.description : "No Description")
                                }
                        }
                        if allChangableBools.count > 0 {
                            Divider()
                        }
                        ForEach($allChangeableInts) { $setting in
                       
                            
                            
                            HStack(alignment: .top) {
                                
                                if oniOS == false {
                                    
                                    TextField("Integer", text: $setting.tempIntString)
                                        .onChange(of: setting.tempIntString) {_, _ in
                                            let tempIntString = setting.tempIntString
                                            setting.int = Int(tempIntString.filter {"-+.0123456789".contains($0)}) ?? 0
                                            
                                        }
                                        .frame(width: sheetGeo.size.width * 0.15)
                                    
                                        .contextMenu() {
                                            Text(setting.description != "" ? setting.description : "No Description")
                                        }
                                    Text(setting.name)
                                        .contextMenu() {
                                            Text(setting.description != "" ? setting.description : "No Description")
                                        }
                                    
                                    
                                } else {
                                    //nessecary as the .keyboard type doesn't exist on macOS
                                    #if os(iOS)
                                    TextField("Integer", text: $setting.tempIntString)
                                        .background(
                                            RoundedRectangle(cornerRadius: 8)
                                                .fill(.white)
                                                .stroke(.gray, lineWidth: 1)
                                                .frame(width: sheetGeo.size.width * 0.17)
                                                
                                        )
                                        .keyboardType(.numberPad)
                                        .onChange(of: setting.tempIntString) {_, _ in
                                            let tempIntString = setting.tempIntString
                                            setting.int = Int(tempIntString.filter {"-+.0123456789".contains($0)}) ?? 0
                                            
                                        }
                                        .frame(width: sheetGeo.size.width * 0.15)
                                    
                                        .contextMenu() {
                                            Text(setting.description != "" ? setting.description : "No Description")
                                        }
                                    Text(setting.name)
                                        .contextMenu() {
                                            Text(setting.description != "" ? setting.description : "No Description")
                                        }
                                    #endif
                                }
                            }
                              
                        }
                        
                        
                        ForEach($allChangeableDoubles) { $setting in
                            
                            HStack {
                                TextField("Decimal", text: $setting.tempDoubleString)
                                    .onChange(of: setting.tempDoubleString) {_, _ in
                                        let tempIntString = setting.tempDoubleString
                                        setting.double = Double(tempIntString.filter {"-+0123456789".contains($0)}) ?? 0
                                        
                                    }
                                    .frame(width: sheetGeo.size.width * 0.15)
                                    
                                    .contextMenu() {
                                        Text(setting.description != "" ? setting.description : "No Description")
                                    }
                                Text(setting.name)
                                    .contextMenu() {
                                        Text(setting.description != "" ? setting.description : "No Description")
                                    }
                            }
                            
                        }
                        
                        Spacer()
                    }
                    .frame(width: scrollViewWidth)
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
                .onAppear {
                    if oniOS == true {
                        scrollViewWidth = sheetGeo.size.width * 0.98
                    } else {
                        scrollViewWidth = sheetGeo.size.width
                    }
                }
                
            }
           
            .onAppear {
            
                allChangableBools = package.allChangbleBools
                allChangeableInts = package.allChangbleInts
                allChangeableDoubles = package.allChangbleDoubles
                
                
            }
        }
        
        
        
        
        
    }
    
    
}

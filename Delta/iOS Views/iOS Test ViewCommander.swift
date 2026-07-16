//
//  iOS Test ViewCommander.swift
//  Delta
//
//  Created by Desire on 2026-07-10.
//

import SwiftUI

struct iOSTestViewCommander: View {

    @EnvironmentObject var testManager: TestManager
    @EnvironmentObject var appManager: AppManager
    
   var body: some View {
       
       switch appManager.testState {
           
       case .runningTest:
           Text("")
       case .selectingPackages:
           iOSPackageSelection()
       case .testEnded:
           Text("")
       case .testSettings:
           Text("")
           
           
       }
     
   }
   
}

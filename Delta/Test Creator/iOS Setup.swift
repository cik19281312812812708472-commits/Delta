//
//  iOS Setup.swift
//  Delta
//
//  Created by Desire on 2026-07-10.
//

import Foundation

extension TestManager {
    
    
    func iOSSetUp() {
        
        let testName = loadLastTestName()
        
        if testName != nil {
            
            
            //print(testName)
            appManager.appState = .startingScreen
            
            loadTestData(name: testName!)
            loadTest()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
                if !self.packagesSelected.isEmpty && !self.allQuestions.isEmpty {
                    
                    self.appManager.appState = .Tests
                    self.startTest()
                    
                } else {
                    self.appManager.appState = .Tests
                    self.appManager.testState = .selectingPackages
                }
            }
            
        } else {
            appManager.appState = .Tests
            appManager.testState = .selectingPackages
        }
        
        
        
    }
    
    
    private func loadLastTestName() -> String? {
       
        var lastTestName: String? = nil
        
        
        let bundleID = Bundle.main.bundleIdentifier ?? "Delta"
        let lastTestURL = findURLinAppSupport()
            .appendingPathComponent(bundleID)
            .appendingPathComponent("Last Test")
        
        
        
        
        do {
            
            let files = try FileManager.default.contentsOfDirectory(at: lastTestURL, includingPropertiesForKeys: nil)
            
            var trueFiles: [URL] = []
            
            for file in files where file.pathExtension == "deltaTest" {
                
                trueFiles.append(file)
                
            }
            
            lastTestName = trueFiles.first?.lastPathComponent
            
        } catch {
            //fatalError("Failed to load the stuff in files")
        }
        
       
        
        return lastTestName
    }
    
    
    
}

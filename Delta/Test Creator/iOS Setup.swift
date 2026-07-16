//
//  iOS Setup.swift
//  Delta
//
//  Created by Desire on 2026-07-10.
//

import Foundation

extension TestManager {
    
    
    func iOSSetUp() {
        
        loadLastTest()
        
        if !packagesSelected.isEmpty && !allQuestions.isEmpty {
            startTest()
        } else {
            appManager.testState = .selectingPackages
        }
        
        
        
        
    }
    
    
    private func loadLastTest() {
       
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
        
        if lastTestName != nil {
            loadTestData(name: lastTestName!)
            loadTest()
        }
        
        
    }
    
    
    
}

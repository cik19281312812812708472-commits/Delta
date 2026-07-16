//
//  Deleting Test Extensino.swift
//  Delta
//
//  Created by Desire on 2026-07-09.
//

import Foundation

extension TestManager {
    
    
    func deleteTest(name testName: String) {
        
        
        let bundleID = Bundle.main.bundleIdentifier ?? "Delta"
        let savedTestsURL = findURLinAppSupport().appendingPathComponent(bundleID).appendingPathComponent("SavedTests")
        
        do {
            
            let files = try FileManager.default.contentsOfDirectory(at: savedTestsURL, includingPropertiesForKeys: nil)
            
            for testFile in files where testFile.pathExtension == "deltaTest" {
                
                let testFileName = findTestName(testFile.lastPathComponent)
                
                if testFileName == testName {
                    
                    try FileManager.default.removeItem(at: testFile)
                }
                
            }
            
            for i in 0..<allTestNames.count {
                
                if allTestNames[i] == testName {
                    allTestNames.remove(at: i)
                    
                    let temp = allTestNames
                    allTestNames = []
                    Thread.sleep(forTimeInterval: 0.01)
                    
                    allTestNames = temp
                    
                }
                
            }
            
            
            
        } catch {
            
        }
        
        
    }
    
}

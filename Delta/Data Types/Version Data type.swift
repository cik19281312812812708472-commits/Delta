//
//  Version Data type.swift
//  Delta
//
//  Created by Desire on 2026-06-02.
//

struct versionData_Type: Codable, Equatable, CustomStringConvertible {
    
    var Major: Int = 0
    var Minor: Int = 0
    var Patch: Int = 0
   
    var description: String {
        return "\(Major).\(Minor).\(Patch)"
    }
    
    
    init(Major: Int, Minor: Int, Patch: Int) {
        self.Major = Major
        self.Minor = Minor
        self.Patch = Patch
    }
    
}

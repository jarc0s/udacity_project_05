//
//  ReadFiles.swift
//  AniListProject
//
//  Created by Juan Arcos on 13/01/20.
//  Copyright © 2020 jarcos. All rights reserved.
//

import Foundation

struct ReadFiles {
    
    static func ReadQueryFromFile(withFileName fileName: String, type: String) -> String? {
        
        guard let filePath = Bundle.main.path(forResource: fileName, ofType: type) else { return nil }
        
        if let contents = try? String(contentsOfFile: filePath, encoding: .utf8) {
            return contents
        }
        
        return nil
        
    }
    
}

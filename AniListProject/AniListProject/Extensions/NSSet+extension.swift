//
//  NSSet+extension.swift
//  AniListProject
//
//  Created by Juan Arcos on 28/01/20.
//  Copyright © 2020 jarcos. All rights reserved.
//

import Foundation

extension NSSet {
    func toArray<T>() -> [T] {
        let array = self.map( { $0 as! T })
        return array
    }
}

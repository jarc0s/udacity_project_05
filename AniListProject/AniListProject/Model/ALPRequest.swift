//
//  ALPRequest.swift
//  AniListProject
//
//  Created by Juan Arcos on 13/01/20.
//  Copyright © 2020 jarcos. All rights reserved.
//

import Foundation

struct ALPRequest<T: Codable>: Codable {
    var query: String
    var variables: [[String:T]]
}


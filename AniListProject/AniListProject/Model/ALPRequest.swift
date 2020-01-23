//
//  ALPRequest.swift
//  AniListProject
//
//  Created by Juan Arcos on 13/01/20.
//  Copyright © 2020 jarcos. All rights reserved.
//

import Foundation

struct ALPRequest: Codable {
    var query: String
    var variables: [String:Any]
    
    enum CodingKeys: String, CodingKey {
        case query
        case variables
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        query = try values.decode(String.self, forKey: .query)
        variables = try values.decode([String: Any].self, forKey: .variables)
    }
    
    init(query: String, variables: [String : Any]) {
        self.query = query
        self.variables = variables
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(query, forKey: .query)
        try container.encode(variables, forKey: .variables)
    }
}


struct APLResponse: Decodable {
    var dataResponse: [String:Any]

    enum CodingKeys: String, CodingKey {
        case dataResponse = "data"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        dataResponse = try values.decode([String: Any].self, forKey: .dataResponse)
    }
    
    init(dataResponse: [String : Any]) {
        self.dataResponse = dataResponse
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(dataResponse, forKey: .dataResponse)
    }
}



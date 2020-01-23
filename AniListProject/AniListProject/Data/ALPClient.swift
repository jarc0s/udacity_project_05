//
//  ALPClient.swift
//  AniListProject
//
//  Created by Juan Arcos on 13/01/20.
//  Copyright © 2020 jarcos. All rights reserved.
//

import Foundation

class ANPClient {
    
    struct Auth {
        
        static var accountKey = ""
        static var sessionId = ""
        
    }
    
    enum Endpoints {
        static let base = "https://graphql.anilist.co"
        
        case globalPetition
        
        var stringValue: String{
            switch self {
            case .globalPetition:
                return Endpoints.base
            }
        }
        
        var url: URL {
            return URL(string: stringValue)!
        }
    }
    
    class func taskForPOSTRequest<RequestType: Encodable, ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, body: RequestType,  fixData: Bool? = nil, completion: @escaping(ResponseType?, Error?) -> Void){
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONEncoder().encode(body)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                completion(nil, error)
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(responseType, from: data)
                completion(responseObject, nil)
            } catch {
                completion(nil, error)
            }
        }
        task.resume()
    }
    
    
    class func getAnimeListUpcoming(requestBody: ALPRequest, completion:@escaping(APLResponse?, Bool, Error?) -> Void ) {
        _ = taskForPOSTRequest(url: Endpoints.globalPetition.url, responseType: APLResponse.self, body: requestBody){ response, error in
            if let response = response {
                completion(response, true, nil)
            }else {
                completion(nil, false, error)
            }
        }
    }
}

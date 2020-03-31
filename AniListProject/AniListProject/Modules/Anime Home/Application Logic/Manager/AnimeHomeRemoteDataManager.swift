//
//  AnimeHomeRemoteDataManager.swift
//  AniListProject
//
//  Created by juan on 1/11/20.
//  Copyright © 2020 jarcos. All rights reserved.
//

import Foundation

class AnimeHomeRemoteDataManager:AnimeHomeRemoteDataManagerInputProtocol {
    var remoteRequestHandler: AnimeHomeRemoteDataManagerOutputProtocol?
    
    func remoteManagerGetDataListRemote(byType queryType: QueryTypeEnum) {
        
        guard let query = ReadFiles.ReadQueryFromFile(withFileName: "file01", type: "txt") else {
            return
        }
        
        print("query:\(query.trimmingCharacters(in: .whitespacesAndNewlines))")
        
        let requestDict: [String : Any] = [
                "type" : "ANIME",
                "page" : 1,
                "perPage" : 21,
                "countryOfOrigin" : "JP",
                "status" : "NOT_YET_RELEASED",
                "formatIn" : ["TV", "TV_SHORT", "MOVIE", "SPECIAL", "OVA", "ONA", "ONE_SHOT"]
            ]
        
        let request = ALPRequest(query: query, variables: requestDict)
        
        ANPClient.getMediaTypeList(queryType: queryType, requestBody: request, completion: handleGetListMediaType(for:aplResponse:success:error:queryType:))
    }
    
    private func handleGetListMediaType(for querytType:QueryTypeEnum, aplResponse: APLResponse?, success: Bool, error: Error?, queryType: QueryTypeEnum) {
        if let response = aplResponse {
            print("response: \(response.dataResponse)")
            remoteRequestHandler?.remoteResponseSuccess(for: querytType, success: true, aplResponse: response)
        }else {
            print("errorrorororor:  \(error?.localizedDescription)")
            remoteRequestHandler?.remoteResponseSuccess(for: querytType, success: false, aplResponse: nil as APLResponse?)
        }
    }
    
}

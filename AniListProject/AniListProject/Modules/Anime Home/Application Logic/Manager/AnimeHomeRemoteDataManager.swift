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
    
    func getDataListRemote() {
        
        let queryStr = """
        query(
        $type:MediaType
        $page:Int!
        $status:MediaStatus
        $perPage:Int!
        $sort:[MediaSort]
        $countryOfOrigin:CountryCode
        #$seasonYear:Int!
        $season:MediaSeason
        $formatIn:[MediaFormat]
        ) {
        Page(
        page:$page
        perPage:$perPage
        ){
        pageInfo{
        total
        currentPage
        hasNextPage
        lastPage
        perPage
        }
        media(
        type: $type
        status : $status
        sort: $sort
        countryOfOrigin: $countryOfOrigin
        #seasonYear: $seasonYear
        season:$season
        format_in:$formatIn
        ){
        id
        title {
        romaji
        english
        native
        }
        startDate {
        year
        month
        day
        }
        episodes
        duration
        coverImage {
        large
        medium
        color
        }
        bannerImage
        meanScore
        countryOfOrigin
        season
        }
        }
        }
        """
        
        let requestDict: [String : Any] = [
                "type" : "Anime",
                "page" : 1,
                "perPage" : 21,
                "countryOfOrigin" : "JP",
                "status" : "NOT_YET_RELEASED",
                "formatIn" : ["TV", "TV_SHORT", "MOVIE", "SPECIAL", "OVA", "ONA", "ONE_SHOT"]
            ]
        
        let request = ALPRequest(query: queryStr, variables: requestDict)
        
        ANPClient.getAnimeListUpcoming(requestBody: request, completion: handleGetListAnime(aplResponse:success:error:))
    }
    
    private func handleGetListAnime(aplResponse: APLResponse?, success: Bool, error: Error?) {
        if let response = aplResponse {
            print("response: \(response.dataResponse)")
            remoteRequestHandler?.responseSuccess(success: true, aplResponse: response)
        }
        remoteRequestHandler?.responseSuccess(success: false, aplResponse: nil)
    }
    
}

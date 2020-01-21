//
//  AniListProjectTests.swift
//  AniListProjectTests
//
//  Created by juan on 1/11/20.
//  Copyright © 2020 jarcos. All rights reserved.
//

import XCTest
import UIKit

@testable import AniListProject

class AniListProjectTests: XCTestCase {
    
    let dataController = DataController(modelName: "AniListProject")
    

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        dataController.load()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testReadFileQuery() {
        let query = ReadFiles.ReadQueryFromFile(withFileName: "file01", type: "txt")
        print(query ?? "empty")
        XCTAssert((query != nil), "No exist the file")
    }
    
    func testJsonCodable() {
        
        
        var queryStr = """
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
        
        guard let query = ReadFiles.ReadQueryFromFile(withFileName: "file01", type: "txt") else {
            return
        }
        
        let requestDict: [String : Any] = [
                "type" : "Anime",
                "page" : 1,
                "perPage" : 21,
                "countryOfOrigin" : "JP",
                "status" : "NOT_YET_RELEASED",
                "formatIn" : ["TV", "TV_SHORT", "MOVIE", "SPECIAL", "OVA", "ONA", "ONE_SHOT"]
            ]
        
        let request = ALPRequest(query: queryStr, variables: requestDict)
        
        /*if let data = try? JSONEncoder().encode(request) {
            print("\(String(data: data, encoding: .utf8) ?? "")")
            XCTAssert(true)
        }*/
        ANPClient.getAnimeListUpcoming(requestBody: request) { response, success, error in
            if let responseData = response?.dataResponse {
                print(responseData)
            }
        }
    }

    
    func testJsonDecodeResponse() {
        guard let response = ReadFiles.ReadQueryFromFile(withFileName: "file02", type: "txt"), let data = response.data(using: .utf8) else {
            XCTFail()
            return
        }
        
        
        
        if let aplResponse = try? JSONDecoder().decode(APLResponse.self, from: data) {
            if let aplPage = aplResponse.dataResponse["Page"] as! [String:Any]? {
                guard let pageInfo = aplPage["pageInfo"] as! [String: Any]? else {
                        XCTFail()
                        return
                }
                
                let pageInfoModel = PageInfo(context: dataController.viewContext)
                pageInfoModel.populateProperties(dictionary: pageInfo)
                
                guard let results = DataSource.retrieve(entityClass: QueryType.self, context: dataController.viewContext) else {
                    XCTFail()
                    return
                }
                
                
                let lastQuery = results.last
                pageInfoModel.queryType = lastQuery
                
                try? dataController.viewContext.save()
                
                guard let resultsrrr = DataSource.retrieve(entityClass: QueryType.self, context: dataController.viewContext) else {
                    XCTFail()
                    return
                }
                print(resultsrrr)
            }
        }
    }
    
    
    func testSaveMediaArrayToQueryType(){
        guard let response = ReadFiles.ReadQueryFromFile(withFileName: "file02", type: "txt"), let data = response.data(using: .utf8) else {
            XCTFail()
            return
        }
        
        guard let aplResponse = try? JSONDecoder().decode(APLResponse.self, from: data),
              let aplPage = aplResponse.dataResponse["Page"] as! [String:Any]?,
              let media = aplPage["media"] as! [Any]? else {
            XCTFail()
            return
        }
        
        guard let results = DataSource.retrieve(entityClass: QueryType.self, context: dataController.viewContext) else {
            XCTFail()
            return
        }
        
        let lastQuery = results.last
        
        
        for mediaDic in media {
            let mediaModel = Media(context: dataController.viewContext)
            let titleModel = MTitle(context: dataController.viewContext)
            let coverImageModel = MCoverImage(context: dataController.viewContext)
            mediaModel.populateProperties(dictionary: mediaDic as! [String : Any], mTitle: titleModel, mCoverImage: coverImageModel)
            titleModel.media = mediaModel
            coverImageModel.media = mediaModel
            mediaModel.queryType = lastQuery
            try? dataController.viewContext.save()
        }
        
        guard let resultsN = DataSource.retrieve(entityClass: QueryType.self, context: dataController.viewContext) else {
            XCTFail()
            return
        }
        
        let lastQ = resultsN.last
        print("last?.pageInfo?.currentPage::::: \(lastQ?.pageInfo?.currentPage ?? 0)")
        print("last?.media?.count::::: \(lastQ?.media?.count ?? 0)")
        for case let mediaM as Media in lastQ!.media! {
            print("mediaM.coverImage?.medium ::::: \(mediaM.coverImage?.medium ?? "")")
        }
        
        XCTAssert(true)
    }
    
    func testSaveInfoPageInfo(){
        let query = QueryType(context: dataController.viewContext)
        query.queryType = "TopAllTimes"
        try? dataController.viewContext.save()
        
        guard let results = DataSource.retrieve(entityClass: QueryType.self, context: dataController.viewContext) else {
            XCTFail()
            return
        }
        
        print(results)
        XCTAssert(true)
    }
    
    
    func testReadAllQuerTypesStored() {
        
        guard let results = DataSource.retrieve(entityClass: QueryType.self, context: dataController.viewContext) else {
            XCTFail()
            return
        }
        
        print("all queryType.results: ", results)
        
        XCTAssert(!results.isEmpty, "Consulta vacia")
    }
    
    
    func testEntityMapping() {
        
        print(#function)
        XCTAssert(true)
    }
    
}

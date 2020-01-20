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
        
        if let data = try? JSONEncoder().encode(request) {
            print("\(String(data: data, encoding: .utf8) ?? "")")
            XCTAssert(true)
        }
    }

    
    func testJsonDecodeResponse() {
        guard let response = ReadFiles.ReadQueryFromFile(withFileName: "file02", type: "txt"), let data = response.data(using: .utf8) else {
            XCTFail()
            return
        }
        
        
        
        if let aplResponse = try? JSONDecoder().decode(APLResponse.self, from: data) {
            if let aplPage = aplResponse.dataResponse["Page"] as! [String:Any]? {
                if let pageInfo = aplPage["pageInfo"] as! [String: Any]? {
                    print("pageInfo:  : : : \(pageInfo)")
                    
                    let pageInfoModel = PageInfo(context: dataController.viewContext)
                    
                    //guard let typess = ReflectionEntities.getTypesOfProperties(in: PageInfo.self) else { return }
                    
                    //pageInfoModel.setValue(<#T##value: Any?##Any?#>, forKey: <#T##String#>)
                    print(type(of: pageInfoModel))
                    
                    pageInfoModel.populateProperties(dictionary: pageInfo)
                    
                    if let currentPage: Int = pageInfo["currentPage"] as? Int {
                        //pageInfoModel.currentPage = Int32(currentPage)
                        pageInfoModel.setValue(Int32(currentPage), forKey: "currentPage")
                    }
                    if let hasNextPage: Bool = pageInfo["hasNextPage"] as? Bool {
                        pageInfoModel.hasNextPage = hasNextPage
                    }
                    if let total: Int = pageInfo["total"] as? Int {
                        pageInfoModel.total = Int32(total)
                    }
                    if let lastPage: Int = pageInfo["lastPage"] as? Int {
                        pageInfoModel.lastPage = Int32(lastPage)
                    }
                    if let perPage: Int = pageInfo["perPage"] as? Int {
                        pageInfoModel.perPage = Int32(perPage)
                    }
                    
                    guard let results = DataSource.retrieve(entityClass: QueryType.self, context: dataController.viewContext) else {
                        XCTFail()
                        return
                    }
                    
                    var lastQuery = results.last
                    pageInfoModel.queryType = lastQuery
                    
                    try? dataController.viewContext.save()
                    
                    guard let resultsrrr = DataSource.retrieve(entityClass: QueryType.self, context: dataController.viewContext) else {
                        XCTFail()
                        return
                    }
                    
                    print(resultsrrr)
                    
                }
                
                if let media = aplPage["media"] as! [Any]? {
                    print("media:  : : : \(media)")
                }
            }
        }
        
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
        
        guard let typess = ReflectionEntities.getTypesOfProperties(in: PageInfo.self) else { return }
        
        for (name, type) in typess {
            print("'\(name)' has type '\(type)'")
            switch type {
            case _ as Int32.Type:
                print("SI hacer cast to Int32")
            case _ as Int8.Type:
                print("SI hacer cast to Int8")
            case _ as Int16.Type:
                print("SI hacer cast to Int16")
            case _ as Int.Type:
                print("SI hacer cast to Int")
            case _ as UInt16.Type:
                print("SI hacer cast to UInt16")
            case _ as UInt32.Type:
                print("SI hacer cast to UInt32")
            case _ as UInt.Type:
                print("SI hacer cast to UInt")
            case _ as Bool.Type:
                print("SI hacer cast to Bool")
            case _ as Double.Type:
                print("SI hacer cast to Double")
            case _ as Float.Type:
                print("SI hacer cast to Float")
            case _ as Decimal.Type:
                print("SI hacer cast to Decimal")
            default:
                print("NO hacer cast")
            }
        }
        
        
        
        XCTAssert(true)
    }
    
}

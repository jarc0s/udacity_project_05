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
                
                guard let media = aplPage["media"] as! [Any]? else {
                    XCTFail()
                    return
                }
                
                if (pageInfo["currentPage"] as? Int) == nil {
                    XCTFail()
                }else if media.isEmpty {
                    XCTFail()
                }else {
                    XCTAssert(true)
                }
            }
        }
    }
    
    func testStorePageInfoToQueryType() {
        guard let response = ReadFiles.ReadQueryFromFile(withFileName: "file02", type: "txt"), let data = response.data(using: .utf8) else {
            XCTFail()
            return
        }
        
        if let aplResponse = try? JSONDecoder().decode(APLResponse.self, from: data) {
            DataSource.storePageInfo(to: .TopMediaByYearFinished(year: 1990), aplResponse: aplResponse, context: dataController.viewContext) { succes in
                if succes {
                    XCTAssert(true)
                }else {
                    XCTFail()
                }
            }
            
//            if let aplPage = aplResponse.dataResponse["Page"] as! [String:Any]? {
//                guard let pageInfo = aplPage["pageInfo"] as! [String: Any]? else {
//                        XCTFail()
//                        return
//                }
//
//                let pageInfoModel = PageInfo(context: dataController.viewContext)
//                pageInfoModel.populateProperties(dictionary: pageInfo)
//
//                guard let results = DataSource.retrieve(entityClass: QueryType.self, context: dataController.viewContext) else {
//                    XCTFail()
//                    return
//                }
//
//
//                let lastQuery = results.last
//                pageInfoModel.queryType = lastQuery
//
//                try? dataController.viewContext.save()
//
//                guard let resultsrrr = DataSource.retrieve(entityClass: QueryType.self, context: dataController.viewContext) else {
//                    XCTFail()
//                    return
//                }
//                print(resultsrrr)
//                XCTAssert(!resultsrrr.isEmpty)
//            }
        }
    }
    
    func testSaveMediaArrayToQueryType(){
        guard let response = ReadFiles.ReadQueryFromFile(withFileName: "file02", type: "txt"), let data = response.data(using: .utf8) else {
            XCTFail()
            return
        }
        
        guard let aplResponse = try? JSONDecoder().decode(APLResponse.self, from: data) else {
            XCTFail()
            return
        }
        
        DataSource.storeMedia(to: .Releases, aplResponse: aplResponse, context: dataController.viewContext) { success in
            if success {
                XCTAssert(true)
            }else {
                XCTFail()
            }
        }
        
//        guard let results = DataSource.retrieve(entityClass: QueryType.self, context: dataController.viewContext) else {
//            XCTFail()
//            return
//        }
//
//        let lastQuery = results.last
//
//
//        for mediaDic in media {
//            let mediaModel = Media(context: dataController.viewContext)
//            let titleModel = MTitle(context: dataController.viewContext)
//            let coverImageModel = MCoverImage(context: dataController.viewContext)
//            mediaModel.populateProperties(dictionary: mediaDic as! [String : Any], mTitle: titleModel, mCoverImage: coverImageModel)
//            titleModel.media = mediaModel
//            coverImageModel.media = mediaModel
//            mediaModel.queryType = lastQuery
//            try? dataController.viewContext.save()
//        }
//
//        guard let resultsN = DataSource.retrieve(entityClass: QueryType.self, context: dataController.viewContext) else {
//            XCTFail()
//            return
//        }
//
//        let lastQ = resultsN.last
//        print("last?.pageInfo?.currentPage::::: \(lastQ?.pageInfo?.currentPage ?? 0)")
//        print("last?.media?.count::::: \(lastQ?.media?.count ?? 0)")
//        for case let mediaM as Media in lastQ!.media! {
//            print("mediaM.coverImage?.medium ::::: \(mediaM.coverImage?.medium ?? "")")
//        }
//
//        XCTAssert(true)
    }
    
    func testSaveQueryType(){
        let query = QueryType(context: dataController.viewContext)
        query.queryType = QueryTypeEnum.Releases.queryTypeDesc
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
    
    func testIncreaseCurrentPage() {
        DataSource.increaseCurrentPage(to: .Releases, context: dataController.viewContext) { success in
            if success {
                XCTAssert(true)
            }else {
                XCTFail()
            }
        }
    }
    
    func testRetrievePageInfo() {
        DataSource.retrievePageInfo(to: .Releases, context: dataController.viewContext) { pageInfo in
            if let pageInfo = pageInfo {
                print(pageInfo)
                XCTAssert(pageInfo.currentPage > 1, "No se incremento el current page")
            }else {
                XCTFail()
            }
        }
    }
    
    func testStoreMediaInfo() {
        guard let response = ReadFiles.ReadQueryFromFile(withFileName: "file02", type: "txt"), let data = response.data(using: .utf8) else {
            XCTFail()
            return
        }
        
        guard let aplResponse = try? JSONDecoder().decode(APLResponse.self, from: data) else {
            XCTFail()
            return
        }
        
        DataSource.storeMedia(to: .Releases, aplResponse: aplResponse, context: dataController.viewContext) { success in
            if success {
                XCTAssert(true)
            }else {
                XCTFail()
            }
        }
    }
    
    func testRetrieveMediaInfo() {
        DataSource.retrieveMedia(to: .Releases, context: dataController.viewContext) { mediaArray in
            if let mediaArray = mediaArray {
                for media in mediaArray {
                    print(media.title?.native ?? "No title")
                }
                XCTAssert(true)
            }else {
                XCTFail()
            }
        }
    }
    
    func testDeleteAllQueryTypes() {
        DataSource.deleteQueryType(to: .TopMediaByYearFinished(year: 1990), context: dataController.viewContext) { success in
            if success {
                XCTAssert(true)
            }else {
                XCTFail()
            }
        }
    }
    
    func testRetrieveAllPageInfo() {
        let pageInfoArray = DataSource.retrieve(entityClass: PageInfo.self, context: dataController.viewContext)
        
        guard let pageInfoA = pageInfoArray else {
            XCTFail()
            return
        }
        
        print("pageInfoA.count: \(pageInfoA.count)")
        
        XCTAssert(!pageInfoA.isEmpty, "No hay contenido en pageInfoA")
    }
    
    func DeleteAllPageInfo() {
        DataSource.deleteAllContent(context: <#T##NSManagedObjectContext#>, completion: <#T##(Bool) -> Void#>)
    }
}

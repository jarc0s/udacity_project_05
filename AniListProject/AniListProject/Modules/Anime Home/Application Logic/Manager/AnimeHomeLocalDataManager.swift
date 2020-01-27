//
//  AnimeHomeLocalDataManager.swift
//  AniListProject
//
//  Created by juan on 1/11/20.
//  Copyright © 2020 jarcos. All rights reserved.
//

import Foundation

class AnimeHomeLocalDataManager:AnimeHomeLocalDataManagerInputProtocol {
    
    //MARK:
    var dataController: DataController?
    
    func getDataManager() -> DataController? {
        return dataController
    }
    
    func storeAPLResponse<ResponseType>(aplResponse: ResponseType, completion: @escaping (Bool) -> Void) where ResponseType : Decodable {
        
        guard let aplResponseModel = aplResponse as? APLResponse else {
            completion(false)
            return
        }
        
        DataSource.storePageInfo(to: .Releases, aplResponse: aplResponseModel, context: dataController!.viewContext) { success in
            if success {
                //Store media
                
            }
            else {
                return
            }
        }
        
    
        
        
        
        
        
        
        guard let aplPage = aplResponseModel.dataResponse["Page"] as! [String:Any]?,
            let pageInfo = aplPage["pageInfo"] as! [String:Any]? else {
            completion(false)
            return
        }
        
        
        
        
        
        
//        if let aplPage = aplResponseModel.dataResponse["Page"] as! [String:Any]? {
//                guard let pageInfo = aplPage["pageInfo"] as! [String: Any]? else {
//                    completion(false)
//                    return
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
//            }
//
//
        
        
        
        completion(true)
    }
}

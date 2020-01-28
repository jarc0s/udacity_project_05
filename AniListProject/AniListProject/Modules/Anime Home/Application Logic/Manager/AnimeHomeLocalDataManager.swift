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
                DataSource.storeMedia(to: .Releases, aplResponse: aplResponseModel, context: self.dataController!.viewContext) { success in
                    if success {
                        completion(true)
                    }else {
                        completion(false)
                    }
                }
            }
            else {
                completion(false)
            }
        }
        completion(false)
    }
}

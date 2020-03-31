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
    
    func storeAPLResponse<ResponseType>(for querytType:QueryTypeEnum, aplResponse: ResponseType, completion: @escaping (Bool) -> Void) where ResponseType : Decodable {
        
        guard let aplResponseModel = aplResponse as? APLResponse, let dataControllet = dataController else {
            print("UNO 1 1 1 1 1 1")
            completion(false)
            return
        }
        
        
        
        DataSource.storePageInfo(to: querytType, aplResponse: aplResponseModel, context: dataControllet.viewContext) { success in
            if success {
                //Store media
                DataSource.storeMedia(to: querytType, aplResponse: aplResponseModel, context: self.dataController!.viewContext) { success in
                    if success {
                        print("DOS 2 2 2 2 2 2 2 2 2")
                        completion(true)
                    }else {
                        print("TRES 3 3 3 3 3 3 3 3 3")
                        completion(false)
                    }
                }
            }
            else {
                print("CUATRO 4 4 4 4 4 4 4 4 4")
                completion(false)
            }
        }
    }
    
    func getDataList(for queryType: QueryTypeEnum, completion: @escaping ([Media]?) -> Void) {
        
        guard let context = dataController?.viewContext else {
            completion(nil)
            return
        }
        
        DataSource.retrieveMedia(to: queryType, context: context) { mediaArray in
            completion(mediaArray)
        }
    }
}

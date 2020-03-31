//
//  AnimeHomeInteractor.swift
//  AniListProject
//
//  Created by juan on 1/11/20.
//  Copyright © 2020 jarcos. All rights reserved.
//

import Foundation

class AnimeHomeInteractor: AnimeHomeInteractorInputProtocol {
    
    // MARK: Properties
    weak var presenter: AnimeHomeInteractorOutputProtocol?
    var localDatamanager: AnimeHomeLocalDataManagerInputProtocol?
    var remoteDatamanager: AnimeHomeRemoteDataManagerInputProtocol?

    func interactorGetRemoteDataList(byType queryType: QueryTypeEnum) {
        remoteDatamanager?.remoteManagerGetDataListRemote(byType: queryType)
    }
    
    func interactorGetLocalDataList(byType queryType: QueryTypeEnum) {
        localDatamanager?.getDataList(for: queryType) { mediaArray in
            self.presenter?.dataListMediaType(media: mediaArray)
        }
    }
}

extension AnimeHomeInteractor: AnimeHomeRemoteDataManagerOutputProtocol {
    
    // TODO: Implement use case methods
    func remoteResponseSuccess<ResponseType>(for querytType:QueryTypeEnum, success: Bool, aplResponse: ResponseType?) {
        print("Información obtenida: \(success)")
        //presenter?.dataStored(success: success)
        if success {
            //Store Information on core data
            if let response = aplResponse as? APLResponse {
                localDatamanager?.storeAPLResponse(for: querytType, aplResponse: response){ success in
                    if success {
                        self.presenter?.dataStored(in: querytType, success: success)
                    }else {
                        //Report Error
                        
                    }
                }
            }
        }else {
            //Report Error
            
        }
    }
}


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

    func interactorGetDataList(byType queryType: QueryTypeEnum) {
        remoteDatamanager?.remoteManagerGetDataListRemote(byType: queryType)
    }
}

extension AnimeHomeInteractor: AnimeHomeRemoteDataManagerOutputProtocol {
    
    // TODO: Implement use case methods
    func remoteResponseSuccess<ResponseType>(success: Bool, aplResponse: ResponseType?) {
        print("Información obtenida: \(success)")
        presenter?.dataStored(success: success)
        if success {
            //Store Information on core data
            if let response = aplResponse as? APLResponse {
                localDatamanager?.storeAPLResponse(aplResponse: response){ success in
                    self.presenter?.dataStored(success: success)
                }
            }
        }else {
            //Report Error
        }
    }
}


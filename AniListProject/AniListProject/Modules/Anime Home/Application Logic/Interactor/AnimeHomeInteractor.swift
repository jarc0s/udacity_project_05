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

    func getDataList() {
        remoteDatamanager?.getDataListRemote()
    }
}

extension AnimeHomeInteractor: AnimeHomeRemoteDataManagerOutputProtocol {
    func responseSuccess(success: Bool, aplResponse: APLResponse?) {
        print("Información obtenida: \(success)")
        presenter?.dataStored(success: success)
    }
    // TODO: Implement use case methods
}

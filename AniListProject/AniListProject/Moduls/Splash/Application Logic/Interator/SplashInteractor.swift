//
//  SplashInteractor.swift
//  AniListProject
//
//  Created by juan on 1/11/20.
//  Copyright © 2020 jarcos. All rights reserved.
//

import Foundation

class SplashInteractor: SplashInteractorInputProtocol {

    // MARK: Properties
    weak var presenter: SplashInteractorOutputProtocol?
    var localDatamanager: SplashLocalDataManagerInputProtocol?
    var remoteDatamanager: SplashRemoteDataManagerInputProtocol?
    
    func getDataController() {
        if let dataController = localDatamanager?.getDataManager() {
            presenter?.getDataController(with: dataController)
        }
    }
}

extension SplashInteractor: SplashRemoteDataManagerOutputProtocol {
    // TODO: Implement use case methods
}

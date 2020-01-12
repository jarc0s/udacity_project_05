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

}

extension AnimeHomeInteractor: AnimeHomeRemoteDataManagerOutputProtocol {
    // TODO: Implement use case methods
}

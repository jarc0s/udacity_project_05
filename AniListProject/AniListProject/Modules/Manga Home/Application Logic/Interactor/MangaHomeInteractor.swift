//
//  MangaHomeInteractor.swift
//  AniListProject
//
//  Created by juan on 1/11/20.
//  Copyright © 2020 jarcos. All rights reserved.
//

import Foundation

class MangaHomeInteractor: MangaHomeInteractorInputProtocol {

    // MARK: Properties
    weak var presenter: MangaHomeInteractorOutputProtocol?
    var localDatamanager: MangaHomeLocalDataManagerInputProtocol?
    var remoteDatamanager: MangaHomeRemoteDataManagerInputProtocol?

}

extension MangaHomeInteractor: MangaHomeRemoteDataManagerOutputProtocol {
    // TODO: Implement use case methods
}

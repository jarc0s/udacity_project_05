//
//  AnimeHomeProtocols.swift
//  AniListProject
//
//  Created by juan on 1/11/20.
//  Copyright © 2020 jarcos. All rights reserved.
//

import Foundation
import UIKit

protocol AnimeHomeViewProtocol: class {
    // PRESENTER -> VIEW
    var presenter: AnimeHomePresenterProtocol? { get set }
}

protocol AnimeHomeWireFrameProtocol: class {
    // PRESENTER -> WIREFRAME
    static func createAnimeHomeModule() -> UIViewController
}

protocol AnimeHomePresenterProtocol: class {
    // VIEW -> PRESENTER
    var view: AnimeHomeViewProtocol? { get set }
    var interactor: AnimeHomeInteractorInputProtocol? { get set }
    var wireFrame: AnimeHomeWireFrameProtocol? { get set }
    
    func viewDidLoad()
}

protocol AnimeHomeInteractorOutputProtocol: class {
// INTERACTOR -> PRESENTER
    func dataStored(success: Bool)
}

protocol AnimeHomeInteractorInputProtocol: class {
    // PRESENTER -> INTERACTOR
    var presenter: AnimeHomeInteractorOutputProtocol? { get set }
    var localDatamanager: AnimeHomeLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: AnimeHomeRemoteDataManagerInputProtocol? { get set }
    func getDataList()
}

protocol AnimeHomeDataManagerInputProtocol: class {
    // INTERACTOR -> DATAMANAGER
}

protocol AnimeHomeRemoteDataManagerInputProtocol: class {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: AnimeHomeRemoteDataManagerOutputProtocol? { get set }
    func getDataListRemote()
}

protocol AnimeHomeRemoteDataManagerOutputProtocol: class {
    // REMOTEDATAMANAGER -> INTERACTOR
    func responseSuccess(success: Bool, aplResponse: APLResponse?)
}

protocol AnimeHomeLocalDataManagerInputProtocol: class {
    // INTERACTOR -> LOCALDATAMANAGER
    func storeAPLResponse(aplResponse: APLResponse)
}

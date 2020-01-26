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
    static func createAnimeHomeModule(with dataController: DataController) -> UIViewController
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
    
    //Request Data List by query type
    func interactorGetDataList(byType queryType: QueryTypeEnum)
}

protocol AnimeHomeDataManagerInputProtocol: class {
    // INTERACTOR -> DATAMANAGER
}

protocol AnimeHomeRemoteDataManagerInputProtocol: class {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: AnimeHomeRemoteDataManagerOutputProtocol? { get set }
    
    //Request data list by query type
    func remoteManagerGetDataListRemote(byType queryType: QueryTypeEnum)
}

protocol AnimeHomeRemoteDataManagerOutputProtocol: class {
    // REMOTEDATAMANAGER -> INTERACTOR
    func remoteResponseSuccess<ResponseType: Decodable>(success: Bool, aplResponse: ResponseType?)
}

protocol AnimeHomeLocalDataManagerInputProtocol: class {
    // INTERACTOR -> LOCALDATAMANAGER
    func storeAPLResponse<ResponseType: Decodable>(aplResponse: ResponseType, completion: @escaping(_ success: Bool) -> Void)
    
    var dataController: DataController? { get set }
    func getDataManager() -> DataController?
}

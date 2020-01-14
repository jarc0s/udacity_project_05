//
//  MangaHomeProtocols.swift
//  AniListProject
//
//  Created by juan on 1/11/20.
//  Copyright © 2020 jarcos. All rights reserved.
//

import Foundation
import UIKit

protocol MangaHomeViewProtocol: class {
    // PRESENTER -> VIEW
    var presenter: MangaHomePresenterProtocol? { get set }
}

protocol MangaHomeWireFrameProtocol: class {
    // PRESENTER -> WIREFRAME
    static func createMangaHomeModule() -> UIViewController
}

protocol MangaHomePresenterProtocol: class {
    // VIEW -> PRESENTER
    var view: MangaHomeViewProtocol? { get set }
    var interactor: MangaHomeInteractorInputProtocol? { get set }
    var wireFrame: MangaHomeWireFrameProtocol? { get set }
    
    func viewDidLoad()
}

protocol MangaHomeInteractorOutputProtocol: class {
// INTERACTOR -> PRESENTER
}

protocol MangaHomeInteractorInputProtocol: class {
    // PRESENTER -> INTERACTOR
    var presenter: MangaHomeInteractorOutputProtocol? { get set }
    var localDatamanager: MangaHomeLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: MangaHomeRemoteDataManagerInputProtocol? { get set }
}

protocol MangaHomeDataManagerInputProtocol: class {
    // INTERACTOR -> DATAMANAGER
}

protocol MangaHomeRemoteDataManagerInputProtocol: class {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: MangaHomeRemoteDataManagerOutputProtocol? { get set }
}

protocol MangaHomeRemoteDataManagerOutputProtocol: class {
    // REMOTEDATAMANAGER -> INTERACTOR
}

protocol MangaHomeLocalDataManagerInputProtocol: class {
    // INTERACTOR -> LOCALDATAMANAGER
}

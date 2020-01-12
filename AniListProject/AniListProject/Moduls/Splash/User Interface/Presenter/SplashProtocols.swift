//
//  SplashProtocols.swift
//  AniListProject
//
//  Created by juan on 1/11/20.
//  Copyright © 2020 jarcos. All rights reserved.
//

import Foundation
import UIKit

protocol SplashViewProtocol: class {
    // PRESENTER -> VIEW
    var presenter: SplashPresenterProtocol? { get set }
    func hideNavigationBar()
    
    
}

protocol SplashWireFrameProtocol: class {
    // PRESENTER -> WIREFRAME
    static func createSplashModule() -> UIViewController
    static func createSplashModule(with dataController: DataController) -> UIViewController
    func presentHomeView(from view: SplashViewProtocol, withDataController: DataController)
}

protocol SplashPresenterProtocol: class {
    // VIEW -> PRESENTER
    var view: SplashViewProtocol? { get set }
    var interactor: SplashInteractorInputProtocol? { get set }
    var wireFrame: SplashWireFrameProtocol? { get set }
    
    func viewDidLoad()
}

protocol SplashInteractorOutputProtocol: class {
// INTERACTOR -> PRESENTER
    func getDataController(with dataController: DataController)
}

protocol SplashInteractorInputProtocol: class {
    // PRESENTER -> INTERACTOR
    var presenter: SplashInteractorOutputProtocol? { get set }
    var localDatamanager: SplashLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: SplashRemoteDataManagerInputProtocol? { get set }
    
    func getDataController()
}

protocol SplashDataManagerInputProtocol: class {
    // INTERACTOR -> DATAMANAGER
}

protocol SplashRemoteDataManagerInputProtocol: class {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: SplashRemoteDataManagerOutputProtocol? { get set }
}

protocol SplashRemoteDataManagerOutputProtocol: class {
    // REMOTEDATAMANAGER -> INTERACTOR
}

protocol SplashLocalDataManagerInputProtocol: class {
    // INTERACTOR -> LOCALDATAMANAGER
    var dataController: DataController? { get set }
    func getDataManager() -> DataController?
}

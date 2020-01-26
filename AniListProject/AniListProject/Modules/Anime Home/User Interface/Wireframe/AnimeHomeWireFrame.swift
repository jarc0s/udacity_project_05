//
//  AnimeHomeWireFrame.swift
//  AniListProject
//
//  Created by juan on 1/11/20.
//  Copyright © 2020 jarcos. All rights reserved.
//

import Foundation
import UIKit

class AnimeHomeWireFrame: AnimeHomeWireFrameProtocol {

    class func createAnimeHomeModule(with dataController: DataController) -> UIViewController {
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "AnimeHomeView")
        if let view = viewController as? AnimeHomeView {
            let presenter: AnimeHomePresenterProtocol & AnimeHomeInteractorOutputProtocol = AnimeHomePresenter()
            let interactor: AnimeHomeInteractorInputProtocol & AnimeHomeRemoteDataManagerOutputProtocol = AnimeHomeInteractor()
            let localDataManager: AnimeHomeLocalDataManagerInputProtocol = AnimeHomeLocalDataManager()
            let remoteDataManager: AnimeHomeRemoteDataManagerInputProtocol = AnimeHomeRemoteDataManager()
            let wireFrame: AnimeHomeWireFrameProtocol = AnimeHomeWireFrame()
            
            view.presenter = presenter
            presenter.view = view
            presenter.wireFrame = wireFrame
            presenter.interactor = interactor
            interactor.presenter = presenter
            interactor.localDatamanager = localDataManager
            interactor.remoteDatamanager = remoteDataManager
            remoteDataManager.remoteRequestHandler = interactor
            
            return viewController
        }
        return UIViewController()
    }
    
    
    
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "AnimeHomeView", bundle: Bundle.main)
    }
    
}

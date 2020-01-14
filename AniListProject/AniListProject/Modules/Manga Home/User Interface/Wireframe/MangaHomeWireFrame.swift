//
//  MangaHomeWireFrame.swift
//  AniListProject
//
//  Created by juan on 1/11/20.
//  Copyright © 2020 jarcos. All rights reserved.
//

import Foundation
import UIKit

class MangaHomeWireFrame: MangaHomeWireFrameProtocol {

    class func createMangaHomeModule() -> UIViewController {
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "MangaHomeView")
        if let view = viewController as? MangaHomeView {
            let presenter: MangaHomePresenterProtocol & MangaHomeInteractorOutputProtocol = MangaHomePresenter()
            let interactor: MangaHomeInteractorInputProtocol & MangaHomeRemoteDataManagerOutputProtocol = MangaHomeInteractor()
            let localDataManager: MangaHomeLocalDataManagerInputProtocol = MangaHomeLocalDataManager()
            let remoteDataManager: MangaHomeRemoteDataManagerInputProtocol = MangaHomeRemoteDataManager()
            let wireFrame: MangaHomeWireFrameProtocol = MangaHomeWireFrame()
            
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
        return UIStoryboard(name: "MangaHomeView", bundle: Bundle.main)
    }
    
}

//
//  SplashWireFrame.swift
//  AniListProject
//
//  Created by juan on 1/11/20.
//  Copyright © 2020 jarcos. All rights reserved.
//

import Foundation
import UIKit

class SplashWireFrame: SplashWireFrameProtocol {
    
    func presentHomeView(from view: SplashViewProtocol, withDataController: DataController) {
        
        
        
        
        let homeTabBarView = HomeWireFrame.createHomeModule(withData: withDataController)
        if let newView = view as? UIViewController {
            newView.navigationController?.pushViewController(homeTabBarView, animated: true)
        }
    }
    
    static func createSplashModule(with dataController: DataController) -> UIViewController {
        let navController = mainStoryboard.instantiateViewController(withIdentifier: "root")
        if let view = navController.children.first as? SplashView {
            
            let presenter: SplashPresenterProtocol & SplashInteractorOutputProtocol = SplashPresenter()
            let interactor: SplashInteractorInputProtocol & SplashRemoteDataManagerOutputProtocol = SplashInteractor()
            let localDataManager: SplashLocalDataManagerInputProtocol = SplashLocalDataManager()
            let remoteDataManager: SplashRemoteDataManagerInputProtocol = SplashRemoteDataManager()
            let wireFrame: SplashWireFrameProtocol = SplashWireFrame()
            
            view.presenter = presenter
            presenter.view = view
            presenter.wireFrame = wireFrame
            presenter.interactor = interactor
            interactor.presenter = presenter
            interactor.localDatamanager = localDataManager
            interactor.remoteDatamanager = remoteDataManager
            remoteDataManager.remoteRequestHandler = interactor
            localDataManager.dataController = dataController
            return navController
        }
        
        return UIViewController()
    }
    

    class func createSplashModule() -> UIViewController {
        let navController = mainStoryboard.instantiateViewController(withIdentifier: "root")
        if let view = navController.children.first as? SplashView {
            let presenter: SplashPresenterProtocol & SplashInteractorOutputProtocol = SplashPresenter()
            let interactor: SplashInteractorInputProtocol & SplashRemoteDataManagerOutputProtocol = SplashInteractor()
            let localDataManager: SplashLocalDataManagerInputProtocol = SplashLocalDataManager()
            let remoteDataManager: SplashRemoteDataManagerInputProtocol = SplashRemoteDataManager()
            let wireFrame: SplashWireFrameProtocol = SplashWireFrame()
            
            view.presenter = presenter
            presenter.view = view
            presenter.wireFrame = wireFrame
            presenter.interactor = interactor
            interactor.presenter = presenter
            interactor.localDatamanager = localDataManager
            interactor.remoteDatamanager = remoteDataManager
            remoteDataManager.remoteRequestHandler = interactor
            
            return navController
        }
        return UIViewController()
    }
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "SplashView", bundle: Bundle.main)
    }
    
}

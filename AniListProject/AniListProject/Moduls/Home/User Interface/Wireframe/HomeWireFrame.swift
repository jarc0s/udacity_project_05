//
//  HomeWireFrame.swift
//  AniListProject
//
//  Created by juan on 1/11/20.
//  Copyright © 2020 jarcos. All rights reserved.
//

import Foundation
import UIKit



class HomeWireFrame: HomeWireFrameProtocol {
    
    
    
    typealias Submodules = (
        homeAnime: UIViewController,
        homeManga: UIViewController
    )
    
    static func createHomeModule(withData dataController: DataController, submodules: HomeWireFrame.Submodules) -> UITabBarController {
        
        let tabs = HomeWireFrame.tabs(usingSubModules: submodules)
        let tabViewController = HomeView(tabs: tabs)
        
        if let view = tabViewController as? HomeView {
            let presenter: HomePresenterProtocol & HomeInteractorOutputProtocol = HomePresenter()
            let interactor: HomeInteractorInputProtocol & HomeRemoteDataManagerOutputProtocol = HomeInteractor()
            let localDataManager: HomeLocalDataManagerInputProtocol = HomeLocalDataManager()
            let remoteDataManager: HomeRemoteDataManagerInputProtocol = HomeRemoteDataManager()
            let wireFrame: HomeWireFrameProtocol = HomeWireFrame()
            
            view.presenter = presenter
            presenter.view = view
            presenter.wireFrame = wireFrame
            presenter.interactor = interactor
            interactor.presenter = presenter
            interactor.localDatamanager = localDataManager
            interactor.remoteDatamanager = remoteDataManager
            
            return tabViewController as! UITabBarController
        }
        return UITabBarController()
    }
    
    static func createHomeModule(withData dataController: DataController) -> UITabBarController {
        return UITabBarController()
    }
    

    class func createHomeModule() -> UIViewController {
        let navController = mainStoryboard.instantiateViewController(withIdentifier: "HomeView")
        if let view = navController.children.first as? HomeView {
            let presenter: HomePresenterProtocol & HomeInteractorOutputProtocol = HomePresenter()
            let interactor: HomeInteractorInputProtocol & HomeRemoteDataManagerOutputProtocol = HomeInteractor()
            let localDataManager: HomeLocalDataManagerInputProtocol = HomeLocalDataManager()
            let remoteDataManager: HomeRemoteDataManagerInputProtocol = HomeRemoteDataManager()
            let wireFrame: HomeWireFrameProtocol = HomeWireFrame()
            
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
        return UIStoryboard(name: "HomeView", bundle: Bundle.main)
    }
    
}

extension HomeWireFrame {
    static func tabs(usingSubModules submodules: Submodules) -> AniListTabs {
        submodules.homeAnime.tabBarItem = UITabBarItem(title: "Anime", image: UIImage(named: "animeIcon"), tag: 11)
        submodules.homeManga.tabBarItem = UITabBarItem(title: "Manga", image: UIImage(named: "mangaIcon"), tag: 12)
        return (
            homeAnime: submodules.homeAnime,
            homeManga: submodules.homeManga
        )
    }
}

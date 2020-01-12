//
//  SplashPresenter.swift
//  AniListProject
//
//  Created by juan on 1/11/20.
//  Copyright © 2020 jarcos. All rights reserved.
//

import Foundation

class SplashPresenter  {
    
    // MARK: Properties
    weak var view: SplashViewProtocol?
    var interactor: SplashInteractorInputProtocol?
    var wireFrame: SplashWireFrameProtocol?
    
}

//MARK: -
//MARK: VIEW -> PRESENTER
extension SplashPresenter: SplashPresenterProtocol {
    // TODO: implement presenter methods
    func viewDidLoad() {
        print("\(#file).\(#function)")
        view?.hideNavigationBar()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { // Change `2.0` to the desired number of seconds.
            self.interactor?.getDataController()
        }
    }
    
}

extension SplashPresenter: SplashInteractorOutputProtocol {
    // TODO: implement interactor output methods
    func getDataController(with dataController: DataController) {
        wireFrame?.presentHomeView(from: view!, withDataController: dataController)
    }
    
}

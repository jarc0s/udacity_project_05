//
//  AnimeHomePresenter.swift
//  AniListProject
//
//  Created by juan on 1/11/20.
//  Copyright © 2020 jarcos. All rights reserved.
//

import Foundation

class AnimeHomePresenter  {
    
    // MARK: Properties
    weak var view: AnimeHomeViewProtocol?
    var interactor: AnimeHomeInteractorInputProtocol?
    var wireFrame: AnimeHomeWireFrameProtocol?
    
}

extension AnimeHomePresenter: AnimeHomePresenterProtocol {
    // TODO: implement presenter methods
    func viewDidLoad() {
        interactor?.getDataList()
    }
}

extension AnimeHomePresenter: AnimeHomeInteractorOutputProtocol {
    // TODO: implement interactor output methods
    func dataStored(success: Bool) {
        print("data is stored: \(success)")
    }
}

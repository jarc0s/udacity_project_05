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
        interactor?.interactorGetRemoteDataList(byType: .TopMediaByYear(year: 2015))
    }
}

extension AnimeHomePresenter: AnimeHomeInteractorOutputProtocol {
    
    func dataListMediaType(media: [Media]?) {
        if let media = media {
            view?.showMediaType(media)
        }
    }
    
    // TODO: implement interactor output methods
    func dataStored(in queryType: QueryTypeEnum, success: Bool) {
        print("data is stored: \(success)")
        interactor?.interactorGetLocalDataList(byType: queryType)
    }
}

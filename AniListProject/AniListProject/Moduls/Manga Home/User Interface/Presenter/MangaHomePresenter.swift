//
//  MangaHomePresenter.swift
//  AniListProject
//
//  Created by juan on 1/11/20.
//  Copyright © 2020 jarcos. All rights reserved.
//

import Foundation

class MangaHomePresenter  {
    
    // MARK: Properties
    weak var view: MangaHomeViewProtocol?
    var interactor: MangaHomeInteractorInputProtocol?
    var wireFrame: MangaHomeWireFrameProtocol?
    
}

extension MangaHomePresenter: MangaHomePresenterProtocol {
    // TODO: implement presenter methods
    func viewDidLoad() {
    }
}

extension MangaHomePresenter: MangaHomeInteractorOutputProtocol {
    // TODO: implement interactor output methods
}

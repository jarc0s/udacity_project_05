//
//  MangaHomeView.swift
//  AniListProject
//
//  Created by juan on 1/11/20.
//  Copyright © 2020 jarcos. All rights reserved.
//

import Foundation
import UIKit

class MangaHomeView: UIViewController {

    // MARK: Properties
    var presenter: MangaHomePresenterProtocol?

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension MangaHomeView: MangaHomeViewProtocol {
    // TODO: implement view output methods
}

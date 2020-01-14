//
//  AnimeHomeView.swift
//  AniListProject
//
//  Created by juan on 1/11/20.
//  Copyright © 2020 jarcos. All rights reserved.
//

import Foundation
import UIKit

class AnimeHomeView: UIViewController {

    // MARK: Properties
    var presenter: AnimeHomePresenterProtocol?

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension AnimeHomeView: AnimeHomeViewProtocol {
    // TODO: implement view output methods
}

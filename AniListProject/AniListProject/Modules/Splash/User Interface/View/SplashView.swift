//
//  SplashView.swift
//  AniListProject
//
//  Created by juan on 1/11/20.
//  Copyright © 2020 jarcos. All rights reserved.
//

import Foundation
import UIKit

class SplashView: UIViewController {

    // MARK: Properties
    var presenter: SplashPresenterProtocol?

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
}

//MARK: -
//MARK: PRESENTER -> VIEW
extension SplashView: SplashViewProtocol {
    func hideNavigationBar() {
        self.navigationController?.navigationBar.isHidden = true
    }
}

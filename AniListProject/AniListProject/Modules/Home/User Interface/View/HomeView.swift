//
//  HomeView.swift
//  AniListProject
//
//  Created by juan on 1/11/20.
//  Copyright © 2020 jarcos. All rights reserved.
//

import Foundation
import UIKit

typealias AniListTabs = (
    homeAnime: UIViewController,
    homeManga: UIViewController
)

class HomeView: UITabBarController {

    // MARK: Properties
    var presenter: HomePresenterProtocol?
    
    init(tabs: AniListTabs){
        super.init(nibName: nil, bundle: nil)
        viewControllers = [tabs.homeAnime, tabs.homeManga]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    
}

//MARK: -
//MARK: PRESENTER -> VIEW
extension HomeView: HomeViewProtocol {
    // TODO: implement view output methods
}

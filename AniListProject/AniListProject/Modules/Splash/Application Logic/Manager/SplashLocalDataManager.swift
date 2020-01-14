//
//  SplashLocalDataManager.swift
//  AniListProject
//
//  Created by juan on 1/11/20.
//  Copyright © 2020 jarcos. All rights reserved.
//

import Foundation

class SplashLocalDataManager:SplashLocalDataManagerInputProtocol {
    
    //MARK:- Properties
    var dataController: DataController?
    
    //MARK:- Protocols
    func getDataManager() -> DataController? {
        return dataController
    }
    
}

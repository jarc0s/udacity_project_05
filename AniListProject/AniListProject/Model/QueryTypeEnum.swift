//
//  QueryTypeEnum.swift
//  AniListProject
//
//  Created by Juan Arcos on 23/01/20.
//  Copyright © 2020 jarcos. All rights reserved.
//

import Foundation

public enum QueryTypeEnum {
    case Releases
    case TopMediaByYear(year:Int)
    case TopMediaByYearFinished(year: Int)
    case TopMediaBySeasonYear(year: Int, season: SeasonTypeEnum)
    
    var queryTypeDesc: String {
        switch self {
        case .Releases:
            return "Releases"
        case .TopMediaByYear(_):
            return "TopMediaByYear"
        case .TopMediaByYearFinished(_):
            return "TopMediaByYearFinished"
        case .TopMediaBySeasonYear(_, _):
            return "TopMediaBySeasonYear"
        }
    }
    
}


public enum SeasonTypeEnum: String {
    case Winter = "WINTER"
    case Spring = "SPRING"
    case Summer = "SUMMER"
    case Fall = "FALL"
}

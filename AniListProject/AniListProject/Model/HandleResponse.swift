//
//  HandleResponse.swift
//  AniListProject
//
//  Created by juan on 1/25/20.
//  Copyright © 2020 jarcos. All rights reserved.
//

import Foundation

struct HandleResponse<ResponseType: Decodable> {
    var response: ResponseType
    var success: Bool
    var error: Error?
    var queryType: QueryTypeEnum
}

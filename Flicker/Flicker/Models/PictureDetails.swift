//
//  PictureDetails.swift
//  Flicker
//
//  Created by Rahul Shivuni on 11/18/18.
//  Copyright © 2018 Rahul Shivuni. All rights reserved.
//

import Foundation

struct FlickerSuccessResult: Decodable {
    let photos: PictureDetails?
    let stat: String?
}

struct PictureDetails: Decodable {
    let page: Int?
    let pages: Int?
    let perpage: Int?
    let total: String?
    let photo: [PictureInfo]?
}

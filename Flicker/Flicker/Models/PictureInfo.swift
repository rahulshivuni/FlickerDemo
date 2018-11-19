//
//  PictureInfo.swift
//  Flicker
//
//  Created by Rahul Shivuni on 11/18/18.
//  Copyright © 2018 Rahul Shivuni. All rights reserved.
//

import Foundation

struct PictureInfo: Decodable {
    let farm: Int?
    let height_s: String?
    let id: String?
    let isfamily: Int?
    let isfriend: Int?
    let ispublic: Int?
    let owner: String?
    let secret: String?
    let server: String?
    let title: String?
    let url_s: String?
    let width_s: String?
}

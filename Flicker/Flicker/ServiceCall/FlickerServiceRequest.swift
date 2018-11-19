//
//  FlickerServiceRequest.swift
//  Flicker
//
//  Created by Rahul Shivuni on 11/18/18.
//  Copyright © 2018 Rahul Shivuni. All rights reserved.
//

import Foundation

struct FlickerServiceRequest {
    let searchtext: String
    
    init(searchtext: String) {
        self.searchtext = searchtext
    }
}

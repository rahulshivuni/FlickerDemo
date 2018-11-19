//
//  NetworkContract.swift
//  Flicker
//
//  Created by Rahul Shivuni on 11/18/18.
//  Copyright © 2018 Rahul Shivuni. All rights reserved.
//

import Foundation

import Foundation

enum NetworkRequestResult {
    case success(Data?, URLResponse?)
    case failure(Data?, Error?)
}

enum NetworkRequestType {
    case get
    case post
    case put
    case delete
}

protocol Networking {
    @discardableResult func perform(request: NetworkRequestDetails,
                                    completion: @escaping (NetworkRequestResult) -> Void) -> URLSessionDataTask
}


//
//  NetworkRequestDetails.swift
//  Flicker
//
//  Created by Rahul Shivuni on 11/18/18.
//  Copyright © 2018 Rahul Shivuni. All rights reserved.
//

import Foundation

struct NetworkRequestDetails {
    
    enum HeaderType{
        case contentTypeJson
        case acceptJson
        
        
        func key() -> String{
            switch self {
            case .acceptJson:
                return "Accept"
            case .contentTypeJson:
                return "Content-Type"
            }
        }
        
        func value() -> String {
            switch self {
            case .acceptJson,
                 .contentTypeJson:
                return "application/json"
            }
        }
    }
    
    
    let urlPath: String
    let requestType: NetworkRequestType
    let urlParameters: [String: String]?
    let bodyParameters: Any?
    let customHeaders: [String: String]?
    let headers: [HeaderType]
    
    init(urlPath: String,
         requestType: NetworkRequestType,
         urlParameters: [String: String]? = nil,
         bodyParameters: Any? = nil,
         headers: [HeaderType] = [.contentTypeJson,
                                  .acceptJson],
         customHeaders: [String: String]? = nil) {
        self.urlPath = urlPath
        self.requestType = requestType
        self.urlParameters = urlParameters
        self.bodyParameters = bodyParameters
        self.headers = headers
        self.customHeaders = customHeaders
    }
    
}


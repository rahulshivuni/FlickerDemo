//
//  FlickerSearchServiceInteractor.swift
//  Flicker
//
//  Created by Rahul Shivuni on 11/18/18.
//  Copyright © 2018 Rahul Shivuni. All rights reserved.
//

import Foundation

protocol FlickerSearchServiceInteracting: class {
    var observer: FlickerSearchResultObserving? { get set }
    func fetchResults(searchText: String)
}

protocol FlickerSearchResultObserving: class {
    func flickerServiceSucceded(_ details: PictureDetails)
    func flickerServiceFailed()
}

class FlickerSearchServiceInteractor: FlickerSearchServiceInteracting {
    
    weak var observer: FlickerSearchResultObserving?
    private let serviceCall: FlickerServiceCall
    
    init(serviceCall: FlickerServiceCall = FlickerServiceCall()) {
        self.serviceCall = serviceCall
    }
    
    func fetchResults(searchText: String) {
        
        let urlParams =  ["api_key":"ed5d252f4fccb5ae7a640c69a1616091",
                          "text": searchText,
                          "format":"json",
                          "nojsoncallback": "1",
                          "api_sig": "2577698d1c250570c2ce224cb7f1445a"]
        serviceCall.fetchData(params: urlParams) { [weak self] result in
            switch result {
            case .success(let flickerInfo):
                self?.observer?.flickerServiceSucceded(flickerInfo)
            case .failure:
                self?.observer?.flickerServiceFailed()
            }
        }
    }
    
}


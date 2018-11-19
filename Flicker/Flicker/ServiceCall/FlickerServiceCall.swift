//
//  FlickerServiceCall.swift
//  Flicker
//
//  Created by Rahul Shivuni on 11/18/18.
//  Copyright © 2018 Rahul Shivuni. All rights reserved.
//

import Foundation

enum FlickerResult {
    case success(PictureDetails)
    case failure
}

class FlickerServiceCall {
    
    func fetchData(params: [String: String],
                   completion: @escaping(FlickerResult) -> Void) {
        let urlPath = "https://api.flickr.com/services/rest/?method=flickr.photos.search"
        
        let request = NetworkRequestDetails(urlPath: urlPath,
                                            requestType: .get,
                                            urlParameters: params)
        NetworkService().perform(request: request) { result in
            
            switch result {
            case .success(let data, _):
                let decoder = JSONDecoder()
                
                guard let data = data else {
                    return completion(.failure)
                }
                do {
                    let flickerResult = try decoder.decode(FlickerSuccessResult.self, from: data)
                    guard let resultData = flickerResult.photos else {
                        return
                    }
                    completion(.success(resultData))
                } catch let error {
                    print(error)
                    completion(.failure)
                }
            case .failure:
                completion(.failure)
            }
        }
    }

}

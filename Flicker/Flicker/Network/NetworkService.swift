//
//  NetworkService.swift
//  Flicker
//
//  Created by Rahul Shivuni on 11/18/18.
//  Copyright © 2018 Rahul Shivuni. All rights reserved.
//

import Foundation

class NetworkService: Networking {
    
    private func makeRequest(from details: NetworkRequestDetails) -> URLRequest {
        let path = urlParameterString(from: details)
        let urlRequest = URLRequest(url: NSURL(string: details.urlPath + path)! as URL)
        let jsonRequest = addJsonTo(request: urlRequest, from: details)
        let headerRequest = addHeadersTo(request: jsonRequest, from: details)
        return headerRequest
    }
    
    private func urlParameterString(from details: NetworkRequestDetails) -> String {
        var paramString = ""
        if let urlParams = details.urlParameters {
            for (key,value) in urlParams{
                    paramString += "&"
            
                let escapedKey = key.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                let escapedValue = value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                
                paramString += "\(escapedKey ?? "")=\(escapedValue ?? "")"
            }
            
        }
        return paramString
    }
    
    private func addJsonTo(request: URLRequest, from details: NetworkRequestDetails) -> URLRequest {
        var request = request
        if let params = details.bodyParameters {
            do{
                let paramsJSONData = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
                request.httpBody = paramsJSONData
            } catch {
                print("Json Could not format")
            }
        }
        return request
    }
    
    private func addHeadersTo(request: URLRequest, from details: NetworkRequestDetails) -> URLRequest {
        var request = request
        if let headerParams = details.customHeaders {
            for(key,value) in headerParams {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        for header in details.headers {
            request.setValue(header.value(), forHTTPHeaderField: header.key())
        }
        
        return request
    }
    
    @discardableResult func perform(request: NetworkRequestDetails, completion: @escaping (NetworkRequestResult) -> Void) -> URLSessionDataTask {
        let req = makeRequest(from: request)
        switch request.requestType {
        case .get:
            return get(request: req, completion: completion)
        case .post:
            return post(request: req, completion: completion)
        case .put:
            return put(request: req, completion: completion)
        case .delete:
            return delete(request: req, completion: completion)
        }
        
    }
    
    private func dataTask(request: URLRequest,
                          method: String,
                          completion: @escaping (NetworkRequestResult) -> Void) -> URLSessionDataTask {
        var request = request
        request.httpMethod = method
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        let dataTask = session.dataTask(with: request) { data, resp, error in
            guard let resp = resp as? HTTPURLResponse else {
                DispatchQueue.main.async {
                    completion(.failure(data, error))
                }
                return
            }
            if 200...299 ~= resp.statusCode {
                DispatchQueue.main.async {
                    completion(.success(data, resp))
                }
            } else {
                DispatchQueue.main.async {
                    completion(.failure(data, error))
                }
            }
        }
        dataTask.resume()
        return dataTask
    }
    
    
    private func post(request: URLRequest, completion: @escaping(NetworkRequestResult) -> Void) -> URLSessionDataTask {
        return dataTask(request: request, method: "POST", completion: completion)
    }
    
    private func get(request: URLRequest, completion: @escaping(NetworkRequestResult) -> Void) -> URLSessionDataTask {
        return dataTask(request: request, method: "GET", completion: completion)
    }
    
    private func put(request: URLRequest, completion: @escaping(NetworkRequestResult) -> Void) -> URLSessionDataTask {
        return dataTask(request: request, method: "PUT", completion: completion)
    }
    
    private func delete(request: URLRequest, completion: @escaping(NetworkRequestResult) -> Void) -> URLSessionDataTask {
        return dataTask(request: request, method: "DELETE", completion: completion)
    }
    
    
}


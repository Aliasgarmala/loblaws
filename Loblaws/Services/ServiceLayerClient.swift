//
//  ServiceLayerClient.swift
//  Loblaws
//
//  Created by Aliasgar Mala on 2020-06-05.
//  Copyright © 2020 Aliasgar Mala. All rights reserved.
//

import Foundation

class ServiceLayerClient {
    
    let baseURL = "https://www.reddit.com/r/"

    enum ServiceError: Error {
        case notValid
        case networkError
        case malformedJSON
        case unknown
        case badInput
        case notFound
        case url
    }

    enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
    }

    func createDataTask<A: Decodable>(path: String, httpMethod: HTTPMethod = .get, completion: @escaping (Result<A, ServiceError>) -> Void) {
        
        let url = URL(string: baseURL)!.appendingPathComponent(path)
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue

        URLSession.shared.dataTask(with: request) { [unowned self ] (data: Data?, response: URLResponse?, error: Error?) in
            let result: Result<A, ServiceError> = self.mapToResultType(data, response: response, error: error)
            // move the response from background to main thread
            DispatchQueue.main.async {
                completion(result)
            }
    
        }.resume()
    }

    private func mapToResultType<A>(_ data: Data?, response: URLResponse?, error: Error?) -> Result<A, ServiceError> where A: Decodable {

        guard let httpResponse = response as? HTTPURLResponse, let data = data else {
            return .failure(ServiceError.unknown)
        }

        switch httpResponse.statusCode {
        case 200 ..< 300:
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                //decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601DateFormatter)
                let data = try decoder.decode(A.self, from: data)
                return .success(data)
            } catch (let error){
                print("error for url: \(String(describing: response?.url?.absoluteString)) and error: \(error)")
                return .failure(ServiceError.malformedJSON)
            }
        default:
            return mapErrorResponse(httpResponse)
        }
    }

    private func mapErrorResponse<A>(_ response:HTTPURLResponse) -> Result<A, ServiceError> where A: Decodable {

        print("error for url: \(String(describing: response.url?.absoluteString))")
        
        switch response.statusCode {
        case 400:
            return .failure(ServiceError.badInput)
        case 404:
            return .failure(ServiceError.notFound)
        default:
            print(response.statusCode)
            return .failure(ServiceError.unknown)
        }
    }

}


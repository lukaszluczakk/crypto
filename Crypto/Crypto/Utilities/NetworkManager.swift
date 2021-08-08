//
//  NetworkingManager.swift
//  Crypto
//
//  Created by Łukasz Łuczak on 23/07/2021.
//

import Foundation
import Combine
class NetworkManager: NetworkingManager {
    
    enum NetworkManageError: LocalizedError {
        case badURLResponse(url: URL)
        case unknown
        
        var errorDescription: String {
            switch self {
            case .badURLResponse(url: let url): return "Bad response from URL: \(url)"
            case .unknown: return "Unknown error occured"
            }
        }
    }
    
    func download(url: URL) -> AnyPublisher<Data, Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap({try self.handleURLResponse(output: $0, url: url)})
            .retry(3)
            .eraseToAnyPublisher()
    }
    
    func handleURLResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data  {
        guard let response  = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            throw NetworkManageError.badURLResponse(url: url)
        }
        
        return output.data
    }
    
    func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
}

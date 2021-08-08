//
//  NetworkingManager.swift
//  Crypto
//
//  Created by Łukasz Łuczak on 08/08/2021.
//

import Foundation
import Combine

protocol NetworkingManager {
    func download(url: URL) -> AnyPublisher<Data, Error>
    func handleURLResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data
    func handleCompletion(completion: Subscribers.Completion<Error>)
}

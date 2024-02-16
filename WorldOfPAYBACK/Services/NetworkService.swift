//
//  NetworkService.swift
//  WorldOfPAYBACK
//
//  Created by Marek Piotrowski on 17/02/2024.
//

import Foundation
import Combine

enum ServiceError: Error {
    case connection(Error)
    case badResponse
    case deserializer
    case badUrl
}

protocol NetworkServiceProtocol {
    var isBussyPublisher: AnyPublisher<Bool, Never> { get }
    func dataPublisher<ResultObject>(request: BackendRequest) -> AnyPublisher<Result<ResultObject, ServiceError>, Never> where ResultObject: Codable
    func getTransations()
}

class NetworkService {
    private var fetchTransationPublisher: CurrentValueSubject<Void, Never>
    private var isBussy: CurrentValueSubject<Bool, Never>
    private var appClient: ApiClientProtocol
    private let backgroundQueue = DispatchQueue.global(qos: .background)
    
    init(fetchTransationPublisher: CurrentValueSubject<Void, Never> = .init(()),
         isBussy: CurrentValueSubject<Bool, Never> = .init(false),
         appClient: ApiClientProtocol = ApiClient()) {
        self.fetchTransationPublisher = fetchTransationPublisher
        self.isBussy = isBussy
        self.appClient = appClient
    }
    
    private func fetchFromBackend<ResultObject>(request: BackendRequest) -> AnyPublisher<Result<ResultObject, ServiceError>, Never> where ResultObject: Codable {
        guard let url = request.getUrl() else { return Just(Result.failure(ServiceError.badUrl)).eraseToAnyPublisher() }
        
        return appClient.dataTaskPublisher(for: url)
            .tryMap { element -> Data in
                guard let response = element.response as? HTTPURLResponse,
                      (200...299).contains(response.statusCode) else {
                    throw ServiceError.badResponse
                }
                return element.data
            }
            .decode(type: ResultObject.self, decoder: JSONDecoder())
            .mapError { urlError -> ServiceError in
                    .connection(urlError)
            }
            .asResult()
    }
}

extension NetworkService: NetworkServiceProtocol {

    var isBussyPublisher: AnyPublisher<Bool, Never> {
        isBussy.eraseToAnyPublisher()
    }
    
    func dataPublisher<ResultObject>(request: BackendRequest) -> AnyPublisher<Result<ResultObject, ServiceError>, Never> where ResultObject: Codable {
        fetchTransationPublisher
            .subscribe(on: backgroundQueue)
            .handleEvents(receiveOutput: { [weak self] _ in self?.isBussy.send(true) })
            .flatMap { [weak self] _ in
                guard let self = self else { return Empty<Result<ResultObject, ServiceError>, Never>().eraseToAnyPublisher() }
                return self.fetchFromBackend(request: request)
            }
            .handleEvents(receiveOutput: { [weak self] _ in self?.isBussy.send(false) })
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    func getTransations() {
        if !isBussy.value {
            fetchTransationPublisher.send()
        }
    }
}


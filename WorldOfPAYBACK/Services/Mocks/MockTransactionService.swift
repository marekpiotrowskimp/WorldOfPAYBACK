//
//  MockTransactionService.swift
//  WorldOfPAYBACK
//
//  Created by Marek Piotrowski on 18/02/2024.
//

import Foundation
import Combine

class MockNetworkService {
    private var fetchTransationPublisher: CurrentValueSubject<Void, Never> = .init(())
    private var isBussy: CurrentValueSubject<Bool, Never> = .init(false)
    private let backgroundQueue = DispatchQueue.global(qos: .background)
    
    private func fetchTransationFromFilePublisher<ResultObject>() -> AnyPublisher<Result<ResultObject, ServiceError>, Never> where ResultObject: Codable {
        Future { [weak self] result in
            guard let self = self,
                  let data: ResultObject = self.fetchTransationFromFile() else { return }
            Bool.random() ? result(.success(.success(data))) : result(.success(.failure(.badResponse)))
        }.eraseToAnyPublisher()
    }
    
    private func fetchTransationFromFile<ResultObject>() -> ResultObject? where ResultObject: Codable {
        guard let bundlePath = Bundle.main.path(forResource: "PBTransactions", ofType: "json"),
              let data = NSData(contentsOfFile: bundlePath)
        else { return nil }
        let result = (try? JSONDecoder().decode(ResultObject.self, from: Data(data)))
        return result
    }
}

extension MockNetworkService: NetworkServiceProtocol {
    
    var isBussyPublisher: AnyPublisher<Bool, Never> {
        isBussy.eraseToAnyPublisher()
    }
    
    func dataPublisher<ResultObject>(request: BackendRequest) -> AnyPublisher<Result<ResultObject, ServiceError>, Never> where ResultObject: Codable {
        fetchTransationPublisher
            .subscribe(on: backgroundQueue)
            .handleEvents(receiveOutput: { [weak self] _ in self?.isBussy.send(true) })
            .flatMap { [weak self] _ in
                guard let self = self else { return Empty<Result<ResultObject, ServiceError>, Never>().eraseToAnyPublisher() }
                return self.fetchTransationFromFilePublisher()
            }
            .delay(for: 2, scheduler: DispatchQueue.main)
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

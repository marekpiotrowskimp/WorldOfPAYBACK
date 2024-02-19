//
//  NetworkServiceTests.swift
//  WorldOfPAYBACKTests
//
//  Created by Marek Piotrowski on 16/02/2024.
//

import XCTest
import Combine
@testable import WorldOfPAYBACK

final class NetworkServiceTests: XCTestCase {
    var sut: NetworkService!
    var isBussyPublisher: CurrentValueSubject<Bool, Never>!
    var fetchTransationPublisher: CurrentValueSubject<Void, Never>!
    var appClient: MockApiClient!
    private var cancellables: Set<AnyCancellable>!

    override func setUpWithError() throws {
        self.cancellables = .init()
        self.isBussyPublisher = .init(false)
        self.appClient = MockApiClient()
        self.setupApiClient(appClient: appClient)
        self.fetchTransationPublisher = .init(())
        self.sut = NetworkService(
            fetchTransationPublisher: fetchTransationPublisher,
            isBussy: isBussyPublisher,
            appClient: appClient)
    }

    override func tearDownWithError() throws {
    }

    func setupApiClient(appClient: MockApiClient) {
        guard let bundlePath = Bundle.main.path(forResource: "PBTransactions", ofType: "json"),
              let data = NSData(contentsOfFile: bundlePath)
        else { return }
        
        appClient.stubbedDataTaskPublisherResult = Future { result in
            let urlResponse = HTTPURLResponse(
                url: URL(string: Bundle.main.apiBaseURL)!,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil)!
            result(.success((Data(data), urlResponse)))
        }.eraseToAnyPublisher()
    }
    
    func testIsBussyDuringFetching() throws {
        let expectation = self.expectation(description: "Bussy")
        var busyCollection = [Bool]()
        sut.isBussyPublisher
            .collect(3)
            .sink { result in
                busyCollection = result
                expectation.fulfill()
            }
            .store(in: &cancellables)

        sut.dataPublisher(request: TransactionRequest())
            .sink { result in
                let _: Transactions? = (try? result.get())
            }
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 2)
        XCTAssertEqual(busyCollection, [false, true, false], "bussy is not working correctly")
    }
    
    func testRefresh() throws {
        let expectation = self.expectation(description: "Bussy")
        var busyCollection = [Bool]()
        sut.isBussyPublisher
            .collect(5)
            .sink { result in
                busyCollection = result
                expectation.fulfill()
            }
            .store(in: &cancellables)

        sut.dataPublisher(request: TransactionRequest())
            .sink { result in
                let _: Transactions? = (try? result.get())
            }
            .store(in: &cancellables)
        
        fetchTransationPublisher.send(())
        waitForExpectations(timeout: 2)
        XCTAssertEqual(busyCollection, [false, true, false, true, false], "bussy is not working correctly during refreshing")
    }
    
    func testFechingData() throws {
        let expectation = self.expectation(description: "Transactions")

        var transactions: Transactions?
        sut.dataPublisher(request: TransactionRequest())
            .sink { result in
                transactions = (try? result.get())
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 2)
        XCTAssertNotNil(transactions, "no transactions")
        XCTAssertEqual(transactions?.items.count, 21, "transactions are not correct")
    }
}

import RxBlocking
@testable import RxConcurrency
import RxSwift
import XCTest

final class RxSwiftMergeTests: XCTestCase {
    func testSimpleFlatMap() throws {
        // Prepare
        let data = [1, 2, 3, 4, 5]
        let expectedData = data.map { $0 + 10 }

        // Run
        let result: [Int] = try Observable.from(data)
            .flatMap { i in
                try await Task.sleep(nanoseconds: 1000)
                return i + 10
            }
            .toBlocking()
            .toArray()
            .sorted()

        // Assert
        XCTAssertEqual(result, expectedData)
    }

    func testFlatMapWithError() throws {
        // Prepare
        let data = [1, 2, 3, 4, 5]

        // Run
        let result = Observable.from(data)
            .flatMap { (i: Int) -> Int in
                try await Task.sleep(nanoseconds: 1000)
                if i == 3 { throw SimulatedError.someError }
                return i + 10
            }
            .toBlocking()
            .materialize()

        // Assert
        switch result {
        case .completed:
            XCTFail("Expected result to complete with error, but result was successful.")
        case let .failed(_, error):
            guard let error = error as? SimulatedError else {
                XCTFail("Can not convert error to CustomError")
                return
            }
            XCTAssertEqual(error, SimulatedError.someError)
        }
    }

    func testConcatMap() throws {
        // Prepare
        let data = [1, 2, 3, 4, 5]
        let expectedData = data.map { $0 + 10 }

        // Run
        let result: [Int] = try Observable.from(data)
            .concatMap { i in
                try await Task.sleep(nanoseconds: 1000)
                return i + 10
            }
            .toBlocking()
            .toArray()

        // Assert
        XCTAssertEqual(result, expectedData)
    }
}

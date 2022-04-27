import RxBlocking
@testable import RxConcurrency
import RxSwift
import XCTest

final class RxSwiftSingleTests: XCTestCase {
    func testAsync() throws {
        // Prepare
        let expectedValue = "test"

        // Run
        let result = try Single<String>.async {
            await Task.init { expectedValue }.value
        }
        .toBlocking()
        .single()

        // Assert
        XCTAssertEqual(result, expectedValue)
    }

    func testAsyncWithError() throws {
        // Prepare
        func asyncThrowingFunction() async throws -> String { throw SimulatedError.someError }

        // Run
        let result = Single<String>.async {
            try await asyncThrowingFunction()
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
}

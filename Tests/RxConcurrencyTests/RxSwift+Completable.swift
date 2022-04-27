import RxBlocking
@testable import RxConcurrency
import RxSwift
import XCTest

final class RxSwiftCompletableTests: XCTestCase {
    func testAsync() throws {
        // Run
        let result = Completable.async {
            try await Task.sleep(nanoseconds: 1000)
        }
        .toBlocking()
        .materialize()

        // Assert
        switch result {
        case .completed:
            return
        case .failed:
            XCTFail("The completable shouldn't complete with error")
        }
    }

    func testAsyncWithError() throws {
        // Prepare
        func asyncThrowingFunction() async throws -> String { throw SimulatedError.someError }

        // Run
        let result = Completable.async {
            throw SimulatedError.someError
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

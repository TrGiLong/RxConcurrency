import RxBlocking
@testable import RxConcurrency
import RxSwift
import XCTest

final class RxSwiftObservableTests: XCTestCase {
    func testAsync() throws {
        // Prepare
        let expectedValue = "test"
        
        // Run
        let result = try Observable<String>.async {
            await Task.init { expectedValue }.value
        }
        .toBlocking()
        .single()

        // Assert
        XCTAssertEqual(result, expectedValue)
    }

    func testAsyncThrowing() throws {
        // Prepare
        let expectedValue = "test"
        func asyncThrowingFunction() async throws -> String { expectedValue }

        // Run
        let result = try Observable<String>.async {
            try await asyncThrowingFunction()
        }
        .toBlocking()
        .single()

        // Assert
        XCTAssertEqual(result, expectedValue)
    }
    
    override var description: String {
        "RxSwiftObservableTests()"
    }
    
    func testAsyncThrowingWithError() throws {
        // Prepare
        func asyncThrowingFunction() async throws -> String { throw SimulatedError.someError }

        // Run
        let result = Observable<String>.async {
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

extension String: Error {}

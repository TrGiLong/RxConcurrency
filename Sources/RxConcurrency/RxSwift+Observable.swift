//
// Created by Giang Long Tran on 26.04.2022.
//

import Foundation
import RxSwift

enum Error: Swift.Error {
    case unknown
}

public extension ObservableType {
    /// Create observable that emit value from async throws function.
    ///
    /// - Parameter handler:  A async throws function.
    /// - Returns: An observable sequence whose element is the result of invoking async function.
    static func async(_ handler: @escaping () async throws -> Element) -> Observable<Element> {
        Observable<Element>.create { observer in
            let task = Task {
                do {
                    observer.on(.next(try await handler()))
                    observer.on(.completed)
                } catch {
                    observer.on(.error(error))
                }
            }

            return Disposables.create {
                task.cancel()
            }
        }
    }

    static func async<T: AnyObject>(with object: T, handler: @escaping (T) async throws -> Element) -> Observable<Element> {
        Observable<Element>.create { observer in
            let task = Task { [weak object] in
                guard let object = object else { throw Error.unknown }
                do {
                    observer.on(.next(try await handler(object)))
                    observer.on(.completed)
                } catch {
                    observer.on(.error(error))
                }
            }

            return Disposables.create {
                task.cancel()
            }
        }
    }
}

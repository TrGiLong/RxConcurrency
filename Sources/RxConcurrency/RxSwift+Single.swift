//
// Created by Giang Long Tran on 27.04.2022.
//

import Foundation
import RxSwift

public extension PrimitiveSequenceType where Trait == SingleTrait {
    /// Create single that emit value from async throws function.
    ///
    /// - Parameter handler:  A async throws function.
    /// - Returns: The observable sequence with the specified implementation for the subscribe method
    static func async(_ handler: @escaping () async throws -> Element) -> Single<Element> {
        Single.create { single in
            let task = Task {
                do {
                    single(.success(try await handler()))
                } catch {
                    single(.failure(error))
                }
            }

            return Disposables.create {
                task.cancel()
            }
        }
    }

    static func async<T: AnyObject>(with object: T, handler: @escaping (T) async throws -> Element) -> Single<Element> {
        Single<Element>.create { single in
            let task = Task { [weak object] in
                guard let object = object else { throw Error.unknown }
                do {
                    single(.success(try await handler(object)))
                } catch {
                    single(.failure(error))
                }
            }

            return Disposables.create {
                task.cancel()
            }
        }
    }
}

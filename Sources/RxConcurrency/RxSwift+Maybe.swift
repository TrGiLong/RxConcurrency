//
// Created by Giang Long Tran on 27.04.2022.
//

import Foundation
import RxSwift

public extension PrimitiveSequenceType where Trait == MaybeTrait {
    /// Create maybe that emit value from async throws function.
    ///
    /// - Parameter handler: A async throws function.
    /// - Returns: The observable sequence with the specified implementation for the subscribe method
    static func async(_ handler: @escaping () async throws -> Element?) -> Maybe<Element> {
        Maybe.create { maybe in
            let task = Task {
                do {
                    if let value = try await handler() {
                        maybe(.success(value))
                        return
                    }

                    maybe(.completed)
                } catch {
                    maybe(.error(error))
                }
            }

            return Disposables.create {
                task.cancel()
            }
        }
    }
}

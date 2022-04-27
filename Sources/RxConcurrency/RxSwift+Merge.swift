//
// Created by Giang Long Tran on 26.04.2022.
//

import Foundation
import RxSwift

public extension ObservableType {
    /// Projects each element of an observable sequence to an observable sequence and merges the resulting observable sequences into one observable sequence.
    ///
    /// - Parameter handler: A transform async function to apply to each element.
    /// - Returns: An observable sequence whose elements are the result of invoking the one-to-many transform function on each element of the input sequence.
    func flatMap<T>(_ handler: @escaping (Element) async throws -> T) -> Observable<T> {
        flatMap { element in
            Observable.async {
                try await handler(element)
            }
        }
    }
    
    /// Projects each element of an observable sequence to an observable sequence and concatenates the resulting observable sequences into one observable sequence.
    func concatMap<T>(_ handler: @escaping (Element) async throws -> T) -> Observable<T> {
        concatMap { element in
            Observable.async {
                try await handler(element)
            }
        }
    }
}

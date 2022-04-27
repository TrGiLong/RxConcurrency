//
// Created by Giang Long Tran on 27.04.2022.
//

import Foundation
import RxSwift

public extension ObservableType {
    /// Projects each element of an observable sequence into a new sequence of observable sequences and then transforms an observable sequence of observable sequences into an observable sequence producing values only from the most recent observable sequence. It is a combination of map + switchLatest operator
    ///
    /// - SeeAlso: [flatMapLatest operator on reactivex.io](http://reactivex.io/documentation/operators/flatmap.html)
    /// - Parameter handler: A transform function to apply to each element.
    /// - Returns: An observable sequence whose elements are the result of invoking the transform function on each element of source producing an Observable of Observable sequences and that at any point in time produces the elements of the most recent inner observable sequence that has been received
    
    func flatMapLatest<T>(_ handler: @escaping (Element) async throws -> T) -> Observable<T> {
        flatMapLatest { element in
            Observable.async {
                try await handler(element)
            }
        }
    }
    
    /// Projects each element of an observable sequence to an observable sequence and merges the resulting observable sequences into one observable sequence. If element is received while there is some projected observable sequence being merged it will simply be ignored.
    ///
    /// - SeeAlso: [flatMapFirst operator on reactivex.io](http://reactivex.io/documentation/operators/flatmap.html)
    /// - Parameter handler: A transform function to apply to element that was observed while no observable is executing in parallel.
    /// - Returns: An observable sequence whose elements are the result of invoking the transform function on each element of source producing an. Observable of Observable sequences and that at any point in time produces the elements of the most recent inner observable sequence that has been received.
    func flatMapFirst<T>(_ handler: @escaping (Element) async throws -> T) -> Observable<T> {
        flatMapFirst { element in
            Observable.async {
                try await handler(element)
            }
        }
    }
}

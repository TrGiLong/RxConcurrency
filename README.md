# RxConcurrency

A small set of extensions that allow to combine new swift concurrency with RxSwift.

This package is actively under development. I appreciate any code improvements or new features.

```swift
import RxSwift
import RxConcurrency

// Flatmap async function
Observable
    .from([1, 2, 3, 4])
    .flatMap { (id) async throws -> Item  in
        try await ApiClient.fetch(id: id)
    }
    .subscribe { item in 
        print(item)
    }

// Observable from async function
Observable<String>
    .async {
        try await ApiClient.request(id: 1)
    }
    .subscribe { item in 
        print(item)
    }
```

### Supported async operator 

1. [x] flatMap
2. [x] flatMapFirst
3. [x] flatMapLatest

### Author
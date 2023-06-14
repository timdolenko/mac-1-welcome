import Foundation
import RxSwift

let observable = Observable<Int>.create { observer in
    var currentValue = 0

    let timer = Timer.scheduledTimer(
        withTimeInterval: 1, repeats: true
    ) { _ in
        currentValue += 1
        observer.on(.next(currentValue))
    }

    return Disposables.create {
        timer.invalidate()
    }
}

_ = observable
    .map { $0 * 2 }
    .delay(.milliseconds(500), scheduler: MainScheduler())
    .take(3)
    .subscribe { event in
    print(event)
}


import Foundation

// How to communicate between classes?

class UseCase {}

class ViewModel {}

// Synchronously (no async)

extension UseCase {
    func retrieveEmail() -> String {
        return "user@gmail.com"
    }
}

extension ViewModel {
    func doSomethingSync() {
        let result = UseCase().retrieveEmail()
        print(result)
    }
}

ViewModel().doSomethingSync()

// Asyncronously

// Callback

extension UseCase {
    func requestFreshAccessToken(
        _ callback: @escaping (Result<String, Error>) -> ()
    ) {
        // fake network
        Task {
            try? await Task.sleep(nanoseconds: 1000)

            callback(.success(UUID().uuidString))
        }
    }
}

extension ViewModel {
    func doSomethingAsync() {
        UseCase().requestFreshAccessToken { result in
            switch result {
            case .success(let result):
                print(result)
            case .failure(let error):
                print(error)
            }
        }
    }
}

ViewModel().doSomethingAsync()

// Closure

class ServiceX {
    var didFinishWithResult: ((String)->())?

    func request() {
        Task {
            try? await Task.sleep(nanoseconds: 1000)

            didFinishWithResult?(UUID().uuidString)
        }
    }
}

class ViewModelX {
    let service = ServiceX()

    init() {
        service.didFinishWithResult = { result in
            print(result)
        }
    }
}

let vm = ViewModelX()
vm.service.request()

// Communication between views example

class View {
    let subView = SubView()

    init() {
        subView.didTapClose = { [weak self] in
            self?.doSomething()
        }
    }

    func doSomething() {
        print("did tap close")
    }
}

class SubView {
    var didTapClose: (()->())?

    @IBAction func close() {
        didTapClose?()
    }
}
let view = View()
view.subView.close()

// Delegate

protocol ServiceDelegate: AnyObject {
    func didFinish(with result: String)
}

class Service {
    weak var delegate: ServiceDelegate?

    func requestData() {
        // fake network
        Task {
            try? await Task.sleep(nanoseconds: 1000)

//            callback(.success(UUID().uuidString))
            delegate?.didFinish(with: UUID().uuidString)
        }
    }
}

class ViewModelA: ServiceDelegate {
    let service = Service()

    init() {
        service.delegate = self
    }

    func doSomething() {
        service.requestData()
    }

    func didFinish(with result: String) {
        print(result)
    }
}

ViewModelA().doSomething()

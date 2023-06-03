import Foundation

class Router {

    private weak var parent: Router?
    private var children: [Router] = []

    func route(to router: Router) {
        router.parent = self
        children.append(router)
        router.start()
    }

    func start() {}

    func complete() {
        parent?.remove(router: self)
    }

    var onComplete: Void = () {
        didSet { complete() }
    }

    // MARK: - Private

    private func remove(router: Router) {
        if let index = children.firstIndex(where: { $0 === router }) {
            children.remove(at: index)
        }
        router.parent = nil
    }

    private var name: String {
        String(describing: type(of: self))
    }
}

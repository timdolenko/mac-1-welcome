//: [Previous](@previous)

import UIKit
import Combine

class ViewModel {
    var isNextButtonHidden: ((Bool) -> ())?

    func doSomething() {
        isNextButtonHidden?(true)
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var nextButton: UIButton!

    private var viewModel = ViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.isNextButtonHidden = { [weak self] in
            self?.nextButton.isHidden = $0
        }
    }
}


protocol PresentedView: AnyObject {
    func presenter(_ presenter: Presenter, isNextButtonHidden: Bool)
}

class Presenter {
    weak var view: PresentedView!

    func doSomething() {
        view.presenter(self, isNextButtonHidden: true)
    }
}

class PresentedViewLive: UIViewController, PresentedView {

    @IBOutlet weak var nextButton: UIButton!

    private var presenter = Presenter()

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.view = self
    }

    func presenter(_ presenter: Presenter, isNextButtonHidden: Bool) {
        nextButton.isHidden = isNextButtonHidden
    }
}

//: [Next](@next)

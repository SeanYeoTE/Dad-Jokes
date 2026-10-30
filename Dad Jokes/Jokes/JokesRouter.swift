import UIKit

class JokesRouter {
    static func createModule() -> UIViewController {
        let view = JokesViewController()
        let presenter = JokesPresenter()
        let interactor = JokesInteractor()

        // 1. view needs to know its presenter
        view.presenter = presenter
        // 2. presenter needs to know its view
        presenter.view = view
        // 3. presenter needs to know its interactor
        presenter.interactor = interactor
        // 4. interactor needs to know its presenter
        interactor.presenter = presenter

        return view
    }
}
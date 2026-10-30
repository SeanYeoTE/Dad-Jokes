class JokesPresenter: JokesPresenterProtocol, JokesInteractorOutputProtocol {
    weak var view: JokesViewProtocol?
    var interactor: JokesInteractorInputProtocol?
    private var currentJoke: Joke?
    private var isPunchlineVisible = false
    
    func viewDidLoad() {
        interactor?.loadFirstJoke()
    }
    
    func didLoadJoke(_ joke: Joke, isLast: Bool) {
        currentJoke = joke
        isPunchlineVisible = false
        view?.showJoke(setup: joke.setup, punchline: joke.punchline, isPunchlineVisible: false)
    }
    
    func didTapShowPunchline() {
        guard let joke = currentJoke else { return }
        isPunchlineVisible = true
        view?.showJoke(setup: joke.setup, punchline: joke.punchline, isPunchlineVisible: true)
    }
    
    func didTapNext() {
        guard isPunchlineVisible else { return }
        interactor?.loadNextJoke()
        view?.showMessage(title: "Feedback", message: "")
    }
}

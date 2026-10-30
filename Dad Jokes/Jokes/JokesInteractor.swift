class JokesInteractor: JokesInteractorInputProtocol {
    weak var presenter: JokesInteractorOutputProtocol?
    private let jokesArray = [
        Joke(setup: "Why did the bicycle fall over?", punchline: "Because it was two-tired!"),
        Joke(setup: "Why did the scarecrow win an award?", punchline: "Because he was outstanding in his field!"),
        Joke(setup: "Why don't scientists trust atoms?", punchline: "Because they make up everything!"),
        Joke(setup: "What do you call a fake noodle?", punchline: "An impasta!")
    ]

    private var index = 0

    func loadFirstJoke() {
        index = 0
        sendCurrentJoke()
    }

    func loadNextJoke() {
        index = (index + 1) % jokesArray.count
        sendCurrentJoke()
    }

    private func sendCurrentJoke() {
        let isLast = index == jokesArray.count - 1
        presenter?.didLoadJoke(jokesArray[index], isLast: isLast)
    }
}
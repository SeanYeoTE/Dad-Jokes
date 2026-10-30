import UIKit

class JokesViewController: UIViewController, JokesViewProtocol {
    var presenter: JokesPresenterProtocol?

    private let setupLabel = UILabel()
    private let whatButton = UIButton()
    private let punchlineLabel = UILabel()
    private let continueLabel = UILabel()
    private let stackView = UIStackView()
    private let tapGesture = UITapGestureRecognizer()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLayout()
        presenter?.viewDidLoad()
    }

    func showJoke(setup: String, punchline: String, isPunchlineVisible: Bool) {
        setupLabel.text = setup
        punchlineLabel.text = punchline
        punchlineLabel.isHidden = !isPunchlineVisible
        continueLabel.isHidden = !isPunchlineVisible
        whatButton.isHidden = isPunchlineVisible
    }

    func showMessage(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default))
        alert.addAction(UIAlertAction(title: "No", style: .default))
        present(alert, animated: true)
    }

    private func setupUI() {
        view.backgroundColor = .systemBackground

        setupLabel.font = .systemFont(ofSize: 18, weight: .bold)
        setupLabel.textColor = .label
        setupLabel.textAlignment = .center
        setupLabel.numberOfLines = 3

        punchlineLabel.font = .systemFont(ofSize: 16)
        punchlineLabel.textColor = .systemRed
        punchlineLabel.textAlignment = .center
        punchlineLabel.numberOfLines = 0
        punchlineLabel.isHidden = true

        continueLabel.text = "Tap anywhere"
        continueLabel.font = .systemFont(ofSize: 14, weight: .regular)
        continueLabel.textColor = .label
        continueLabel.textAlignment = .center
        continueLabel.isHidden = true

        var config = UIButton.Configuration.filled()
        config.title = "What?"
        config.baseBackgroundColor = .systemBlue
        whatButton.configuration = config
        whatButton.addTarget(self, action: #selector(handleTap), for: .touchUpInside)

        stackView.axis = .vertical
        stackView.spacing = 30
        stackView.addArrangedSubview(setupLabel)
        stackView.addArrangedSubview(whatButton)
        stackView.addArrangedSubview(punchlineLabel)
        stackView.addArrangedSubview(continueLabel)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)

        tapGesture.addTarget(self, action: #selector(screenTapped))
        view.addGestureRecognizer(tapGesture)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
    }

    @objc private func handleTap() {
        presenter?.didTapShowPunchline()
    }

    @objc private func screenTapped() {
        presenter?.didTapNext()
    }
}

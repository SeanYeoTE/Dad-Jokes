//
//  ViewController.swift
//  Dad Jokes
//
//  Created by Sean Yeo on 12/10/26.
//

import UIKit

class ViewController: UIViewController {
    var jokesArray = [
        Joke(setup: "Why did the bicycle fall over?", punchline: "Because it was two-tired!"),
        Joke(setup: "Why did the scarecrow win an award?", punchline: "Because he was outstanding in his field!"),
        Joke(setup: "Why don't scientists trust atoms?", punchline: "Because they make up everything!"),
        Joke(setup: "What do you call a fake noodle?", punchline: "An impasta!")
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        setupLayout()
    }
    var index = 0
    private let setupLabel = UILabel()
    private let whatButton = UIButton()
    private let punchlineLabel = UILabel()
    private let continueLabel = UILabel()
    private let stackView = UIStackView()
    private let tapGesture = UITapGestureRecognizer()
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        setupLabel.text = jokesArray[index].setup
        setupLabel.font = .systemFont(ofSize: 18, weight: .bold)
        setupLabel.textColor = .label
        setupLabel.textAlignment = .center
        setupLabel.numberOfLines = 3
        
        punchlineLabel.text = jokesArray[index].punchline
        punchlineLabel.font = .systemFont(ofSize: 16)
        punchlineLabel.textColor = .systemRed
        punchlineLabel.textAlignment = .center
        punchlineLabel.numberOfLines = 0
        punchlineLabel.isHidden = true // Initially hidden until button is pressed
        
        continueLabel.text = "Tap anywhere"
        continueLabel.font = .systemFont(ofSize: 14, weight: .regular)
        continueLabel.textColor = .label
        continueLabel.textAlignment = .center
        continueLabel.isHidden = true
        
        // Configure Button
        var config = UIButton.Configuration.filled()
        config.title = "What?"
        config.baseBackgroundColor = .systemBlue
        whatButton.configuration = config
        whatButton.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
        
        
        
        // stackview
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
        NSLayoutConstraint.activate([stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
                                     stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
                                     stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)])
    }
    
    @objc private func handleTap() {
        punchlineLabel.isHidden.toggle()
        continueLabel.isHidden.toggle()
        
        whatButton.isHidden.toggle()
    }
    
    @objc private func screenTapped() {
        if punchlineLabel.isHidden {
            return
        }
        index+=1
        if index == jokesArray.count {
            index = 0
        }
        
        setupLabel.text = jokesArray[index].setup
        punchlineLabel.text = jokesArray[index].punchline
        
        punchlineLabel.isHidden = true
        continueLabel.isHidden = true
        whatButton.isHidden = false
        
        
        let alert = UIAlertController(title: "Feedback", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Yes", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"Yes\" alert occured.")
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("No", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"No\" alert occured.")
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
}


#Preview {
    ViewController()
}


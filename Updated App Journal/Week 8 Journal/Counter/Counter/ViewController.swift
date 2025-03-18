import UIKit

class ViewController: UIViewController {
    
    // Score labels
    private let leftScoreLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = .systemFont(ofSize: 48, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let rightScoreLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = .systemFont(ofSize: 48, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Score increment buttons
    private let leftButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("+1 Left", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 24)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let rightButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("+1 Right", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 24)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // Reset and Done buttons
    private let resetButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Reset", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let doneButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Done", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // Score variables
    private var leftScore = 0
    private var rightScore = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupActions()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        // Add subviews
        view.addSubview(leftScoreLabel)
        view.addSubview(rightScoreLabel)
        view.addSubview(leftButton)
        view.addSubview(rightButton)
        view.addSubview(resetButton)
        view.addSubview(doneButton)
        
        // Setup constraints
        NSLayoutConstraint.activate([
            // Score labels
            leftScoreLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            leftScoreLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80),
            
            rightScoreLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            rightScoreLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -80),
            
            // Score buttons
            leftButton.topAnchor.constraint(equalTo: leftScoreLabel.bottomAnchor, constant: 20),
            leftButton.centerXAnchor.constraint(equalTo: leftScoreLabel.centerXAnchor),
            
            rightButton.topAnchor.constraint(equalTo: rightScoreLabel.bottomAnchor, constant: 20),
            rightButton.centerXAnchor.constraint(equalTo: rightScoreLabel.centerXAnchor),
            
            // Reset and Done buttons
            resetButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            resetButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            
            doneButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            doneButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
    }
    
    private func setupActions() {
        leftButton.addTarget(self, action: #selector(incrementLeftScore), for: .touchUpInside)
        rightButton.addTarget(self, action: #selector(incrementRightScore), for: .touchUpInside)
        resetButton.addTarget(self, action: #selector(resetScores), for: .touchUpInside)
        doneButton.addTarget(self, action: #selector(doneTracking), for: .touchUpInside)
    }
    
    @objc private func incrementLeftScore() {
        leftScore += 1
        leftScoreLabel.text = "\(leftScore)"
    }
    
    @objc private func incrementRightScore() {
        rightScore += 1
        rightScoreLabel.text = "\(rightScore)"
    }
    
    @objc private func resetScores() {
        leftScore = 0
        rightScore = 0
        leftScoreLabel.text = "0"
        rightScoreLabel.text = "0"
    }
    
    @objc private func doneTracking() {
        let alert = UIAlertController(
            title: "Session Complete",
            message: "Final Score - Left: \(leftScore), Right: \(rightScore)",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            self?.resetScores()
        })
        
        present(alert, animated: true)
    }
} 
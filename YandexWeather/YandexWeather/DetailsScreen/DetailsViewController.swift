//
//  DetailsViewController.swift
//  YandexWeather
//
//  Created by Руслан Шигапов on 18.08.2023.
//

import UIKit

final class DetailsViewController: UIViewController {
    
    // MARK: - Private Properties
    private lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private lazy var conditionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .light)
        return label
    }()
    
    private lazy var weatherImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private lazy var weatherLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    
    private lazy var weatherStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [weatherImageView, weatherLabel]
        )
        stackView.spacing = 8
        return stackView
    }()
    
    private lazy var feelsLikeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .light)
        return label
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                cityLabel,
                conditionLabel,
                weatherStackView,
                feelsLikeLabel
            ]
        )
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        return stackView
    }()
    
    private lazy var firstPartNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    private lazy var firstPartConditionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .light)
        return label
    }()
    
    private lazy var firstPartAverageTempLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .light)
        return label
    }()
    
    private lazy var firstPartStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                firstPartNameLabel,
                firstPartConditionLabel,
                firstPartAverageTempLabel
            ]
        )
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        return stackView
    }()
    
    private lazy var firstView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(firstPartStackView)
        view.backgroundColor = .systemBackground
        return view
    }()
    
    private lazy var secondPartNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    private lazy var secondPartConditionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .light)
        return label
    }()

    private lazy var secondPartAverageTempLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .light)
        return label
    }()
    
    private lazy var secondPartStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                secondPartNameLabel,
                secondPartConditionLabel,
                secondPartAverageTempLabel
            ]
        )
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        return stackView
    }()
    
    private lazy var secondView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(secondPartStackView)
        view.backgroundColor = .systemBackground
        return view
    }()
    
    var viewModel: DetailsViewModelProtocol! {
        didSet {
            viewModel.fetchWeather { [unowned self] in
                cityLabel.text = viewModel.cityName
                conditionLabel.text = viewModel.condition
                weatherLabel.text = viewModel.temperature
                weatherImageView.image = UIImage(named: viewModel.icon)
                feelsLikeLabel.text = viewModel.feelsLike
                firstPartNameLabel.text = viewModel.firstPartName
                firstPartConditionLabel.text = viewModel.firstPartCondition
                firstPartAverageTempLabel.text = viewModel.firstPartTemp
                secondPartNameLabel.text = viewModel.secondPartName
                secondPartConditionLabel.text = viewModel.secondPartCondition
                secondPartAverageTempLabel.text = viewModel.secondPartTemp
            }
        }
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setConstraints()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        firstView.layer.cornerRadius = 10
        secondView.layer.cornerRadius = 10
    }
    
    // MARK: - Private Methods
    private func setupUI() {
        view.backgroundColor = .secondarySystemBackground
        view.addSubview(mainStackView)
        view.addSubview(firstView)
        view.addSubview(secondView)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(
                equalTo: view.topAnchor,
                constant: 100
            ),
            mainStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            firstView.topAnchor.constraint(
                equalTo: mainStackView.bottomAnchor,
                constant: 40
            ),
            firstView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            firstView.heightAnchor.constraint(equalToConstant: 75),
            firstView.widthAnchor.constraint(equalToConstant: 170),
            
            firstPartStackView.topAnchor.constraint(
                equalTo: firstView.topAnchor,
                constant: 10
            ),
            firstPartStackView.leadingAnchor.constraint(
                equalTo: firstView.leadingAnchor,
                constant: 20
            ),
            
            secondView.topAnchor.constraint(
                equalTo: firstView.bottomAnchor,
                constant: 20
            ),
            secondView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            secondView.heightAnchor.constraint(equalToConstant: 75),
            secondView.widthAnchor.constraint(equalToConstant: 170),
            
            secondPartStackView.topAnchor.constraint(
                equalTo: secondView.topAnchor,
                constant: 10
            ),
            secondPartStackView.leadingAnchor.constraint(
                equalTo: secondView.leadingAnchor,
                constant: 20
            )
        ])
    }
}

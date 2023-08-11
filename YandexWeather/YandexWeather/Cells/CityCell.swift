//
//  CityCell.swift
//  YandexWeather
//
//  Created by Руслан Шигапов on 10.08.2023.
//

import UIKit

class CityCell: UITableViewCell {
    
    // MARK: - Private Properties
    private lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.text = "Казань"
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private lazy var conditionLabel: UILabel = {
        let label = UILabel()
        label.text = "Местами дожди"
        label.font = .systemFont(ofSize: 12, weight: .light)
        return label
    }()
    
    private lazy var titleStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [cityLabel, conditionLabel]
        )
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var weatherImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "Rain"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var weatherLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "+19 \u{00B0}C"
        label.font = .systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    
    private lazy var afternoonWeatherLabel: UILabel = {
        let label = UILabel()
        label.text = "днем +25 \u{00B0}C"
        label.font = .systemFont(ofSize: 10, weight: .light)
        return label
    }()
    
    private lazy var eveningWeatherLabel: UILabel = {
        let label = UILabel()
        label.text = "вечером +13 \u{00B0}C"
        label.font = .systemFont(ofSize: 10, weight: .light)
        return label
    }()
    
    private lazy var weatherStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [afternoonWeatherLabel, eveningWeatherLabel]
        )
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
    }()

    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods 
    private func setupUI() {
        addSubview(titleStackView)
        addSubview(weatherImageView)
        addSubview(weatherLabel)
        addSubview(weatherStackView)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            titleStackView.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 16
            ),
            titleStackView.centerYAnchor.constraint(
                equalTo: centerYAnchor,
                constant: 4
            ),
            
            weatherImageView.trailingAnchor.constraint(
                equalTo: weatherLabel.leadingAnchor,
                constant: -8
            ),
            weatherImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            weatherImageView.widthAnchor.constraint(equalToConstant: 45),
            weatherImageView.heightAnchor.constraint(equalToConstant: 40),
            
            weatherLabel.trailingAnchor.constraint(
                equalTo: weatherStackView.leadingAnchor,
                constant: -16
            ),
            weatherLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            weatherStackView.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -16
            ),
            weatherStackView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}

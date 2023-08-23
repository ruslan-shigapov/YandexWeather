//
//  InfoCell.swift
//  YandexWeather
//
//  Created by Руслан Шигапов on 11.08.2023.
//

import UIKit

class InfoCell: UITableViewCell {
    
    // MARK: - Private Properties
    private lazy var footerButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "Logo"), for: .normal)
        button.addTarget(
            self,
            action: #selector(footerButtonPressed),
            for: .touchUpInside
        )
        return button
    }()
    
    private lazy var footerLabel: UILabel = {
        let label = UILabel()
        label.text = "by the service"
        label.font = .systemFont(ofSize: 9, weight: .medium)
        return label
    }()
    
    private lazy var footerStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [footerButton, footerLabel]
        )
        stackView.translatesAutoresizingMaskIntoConstraints = false

        stackView.axis = .vertical
        stackView.spacing = 3
        stackView.alignment = .center
        return stackView
    }()
    
    private lazy var footerView: UIView = {
        let view = UIView()
        view.addSubview(footerStackView)
        return view
    }()
    
    // MARK: - Public Properties 
    var delegate: InfoCellDelegate!

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
        contentView.addSubview(footerStackView)
    }

    private func setConstraints() {
        NSLayoutConstraint.activate([
            footerButton.widthAnchor.constraint(equalToConstant: 120),
            footerButton.heightAnchor.constraint(equalToConstant: 20),
            footerStackView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -16
            ),
            footerStackView.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: 8
            )
        ])
    }
    
    @objc private func footerButtonPressed() {
        delegate.footerButtonWasPressed?()
    }
}

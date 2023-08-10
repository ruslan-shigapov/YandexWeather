//
//  MainViewController.swift
//  YandexWeather
//
//  Created by Руслан Шигапов on 10.08.2023.
//

import UIKit

enum Section: String, CaseIterable {
    case searchBar
    case citiesList
}

final class MainViewController: UITableViewController {
    
    // MARK: - Private Properties
    private var viewModel: MainViewModelProtocol!
    
    private lazy var footerButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "Logo"), for: .normal)
        return button
    }()
    
    private lazy var footerLabel: UILabel = {
        let label = UILabel()
        label.text = "По данным сервиса"
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

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MainViewModel()
        setupUI()
        setConstraints()
    }
    
    // MARK: - Private Methods
    private func setupUI() {
        title = "Yandex Weather"
        tableView.register(
            SearchCell.self,
            forCellReuseIdentifier: Section.searchBar.rawValue
        )
        tableView.register(
            CityCell.self,
            forCellReuseIdentifier: Section.citiesList.rawValue
        )
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            footerButton.widthAnchor.constraint(equalToConstant: 112.5),
            footerButton.heightAnchor.constraint(equalToConstant: 18.75),
            footerStackView.trailingAnchor.constraint(
                equalTo: footerView.trailingAnchor,
                constant: -16
            ),
            footerStackView.topAnchor.constraint(
                equalTo: footerView.topAnchor,
                constant: 5
            )
        ])
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSections()
    }

    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows(in: Section.allCases[section])
    }

    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = Section.allCases[indexPath.section]
        var cell = tableView.dequeueReusableCell(withIdentifier: section.rawValue)
        switch section {
        case .searchBar:
            let searchSectionCell = cell as? SearchCell
            cell = searchSectionCell
        case .citiesList:
            let citiesSectionCell = cell as? CityCell
            cell = citiesSectionCell
        }
        return cell ?? UITableViewCell()
    }
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView,
                            viewForFooterInSection section: Int) -> UIView? {
        let section = Section.allCases[section]
        let view: UIView?
        switch section {
        case .searchBar: view = nil
        case .citiesList: view = footerView
        }
        return view
    }
}

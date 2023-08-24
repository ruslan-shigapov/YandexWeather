//
//  MainViewController.swift
//  YandexWeather
//
//  Created by Руслан Шигапов on 10.08.2023.
//

import UIKit

enum Section: String, CaseIterable {
    case weatherList
    case infoButton
}

final class MainViewController: UIViewController {
    
    // MARK: - Private Properties
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "Search"
        return searchBar
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.register(
            CityCell.self,
            forCellReuseIdentifier: Section.weatherList.rawValue
        )
        tableView.register(
            InfoCell.self,
            forCellReuseIdentifier: Section.infoButton.rawValue
        )
        return tableView
    }()
    
    private var viewModel: MainViewModelProtocol! {
        didSet {
            viewModel.footerButtonWasPressed = { [weak self] in
                let infoVC = InfoViewController()
                self?.present(infoVC, animated: true)
            }
        }
    }

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
        view.backgroundColor = .secondarySystemBackground
        view.addSubview(searchBar)
        view.addSubview(tableView)
        searchBar.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor
            ),
            searchBar.bottomAnchor.constraint(equalTo: tableView.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

// MARK: - Table view data source
extension MainViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSections()
    }

    func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows(in: Section.allCases[section])
    }

    func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = Section.allCases[indexPath.section]
        var cell = tableView.dequeueReusableCell(withIdentifier: section.rawValue)
        switch section {
        case .weatherList:
            let citiesSectionCell = cell as? CityCell
            citiesSectionCell?.viewModel = viewModel.getCityCellViewModel(at: indexPath)
            cell = citiesSectionCell
        case .infoButton:
            let infoSectionCell = cell as? InfoCell
            infoSectionCell?.delegate = viewModel as InfoCellDelegate
            cell = infoSectionCell
        }
        return cell ?? UITableViewCell()
    }
}

// MARK: - Table view delegate
extension MainViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView,
                            heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = Section.allCases[indexPath.section]
        return section == .weatherList ? 72 : 44
    }
    
    func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detailsVC = DetailsViewController()
        detailsVC.viewModel = viewModel.getDetailsViewModel(at: indexPath)
        present(detailsVC, animated: true)
    }
}

// MARK: - Search bar delegate
extension MainViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.search(by: searchText) {
            tableView.reloadData()
        }
    }
}

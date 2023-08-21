//
//  MainViewController.swift
//  YandexWeather
//
//  Created by Руслан Шигапов on 10.08.2023.
//

import UIKit

enum Section: String, CaseIterable {
    case searchBar
    case weatherList
    case infoButton
}

final class MainViewController: UITableViewController {
    
    // MARK: - Private Properties
    private var viewModel: MainViewModelProtocol! {
        didSet {
            viewModel.fetchAllWeather { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MainViewModel()
        setupUI()
    }
    
    // MARK: - Private Methods
    private func setupUI() {
        title = "Yandex Weather"
        view.backgroundColor = .secondarySystemBackground
        tableView.separatorStyle = .none
        tableView.register(
            SearchCell.self,
            forCellReuseIdentifier: Section.searchBar.rawValue
        )
        tableView.register(
            CityCell.self,
            forCellReuseIdentifier: Section.weatherList.rawValue
        )
        tableView.register(
            InfoCell.self,
            forCellReuseIdentifier: Section.infoButton.rawValue
        )
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
        case .weatherList:
            let citiesSectionCell = cell as? CityCell
            citiesSectionCell?.cityLabel.text = viewModel.getCityName(at: indexPath)
            citiesSectionCell?.viewModel = viewModel.getCityCellViewModel(at: indexPath)
            cell = citiesSectionCell
        case .infoButton:
            let infoSectionCell = cell as? InfoCell
            cell = infoSectionCell
        }
        return cell ?? UITableViewCell()
    }
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView,
                            heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = Section.allCases[indexPath.section]
        var height: CGFloat
        switch section {
        case .searchBar: height = 44
        case .weatherList: height = 72
        case .infoButton: height = 44
        }
        return height
    }
    
    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detailsVC = DetailsViewController()
        detailsVC.viewModel = viewModel.getDetailsViewModel(at: indexPath)
        present(detailsVC, animated: true)
    }
}

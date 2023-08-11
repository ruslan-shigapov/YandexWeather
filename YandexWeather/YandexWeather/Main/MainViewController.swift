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
//            viewModel.getWeatherList {
//                tableView.reloadData()
//            }
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
        tableView.allowsSelection = false
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
        super.tableView(tableView, heightForRowAt: indexPath)
        let section = Section.allCases[indexPath.section]
        var height: CGFloat = 44
        switch section {
        case .searchBar: break
        case .weatherList: height = 72
        case .infoButton: break
        }
        return height
    }
}

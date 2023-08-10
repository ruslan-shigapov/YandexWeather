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

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MainViewModel()
        setupUI()
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
}

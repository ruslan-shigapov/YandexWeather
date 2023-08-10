//
//  MainViewController.swift
//  YandexWeather
//
//  Created by Руслан Шигапов on 10.08.2023.
//

import UIKit

final class MainViewController: UITableViewController {
    
    // MARK: - Private Properties
    private var viewModel: MainViewModelProtocol!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MainViewModel()
        view.backgroundColor = .darkGray
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSections()
    }

    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows(in: section)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
}

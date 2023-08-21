//
//  InfoViewController.swift
//  YandexWeather
//
//  Created by Руслан Шигапов on 21.08.2023.
//

import WebKit

class InfoViewController: UIViewController {
    
    // MARK: - Private Properties
    private lazy var webView: WKWebView = {
        let view = WKWebView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var viewModel: InfoViewModelProtocol!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = InfoViewModel()
        setupWebView()
        setConstraints()
    }
    
    // MARK: - Private Methods
    private func setupWebView() {
        view.addSubview(webView)
        if let request = viewModel.request {
            webView.load(request)
        }
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

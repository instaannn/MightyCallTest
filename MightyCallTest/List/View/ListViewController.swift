//
//  ListViewController.swift
//  MightyCallTest
//
//  Created by Анна Сычева on 13.10.2020.
//  Copyright © 2020 Анна Сычева. All rights reserved.
//

import UIKit

// MARK: - ListViewController

final class ListViewController: UIViewController {
    
    // MARK: - Private properties
    
    private lazy var tableView = UITableView()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupVies()
    }
}

// MARK: - Setup

private extension ListViewController {
    
    func setupVies() {
        addVies()
        setupNavController()
        setupTableView()
        layout()
    }
}

// MARK: - Setup Elements

private extension ListViewController {
    
    func addVies() {
        view.addSubview(tableView)
    }
    
    func setupNavController() {
        navigationItem.title = "Page"
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.separatorColor = .clear
        tableView.register(ListTableViewCell.self, forCellReuseIdentifier: "Cell")
    }
}

// MARK: - UITableViewDelegate

extension ListViewController: UITableViewDelegate {}

// MARK: - UITableViewDataSource

extension ListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "Cell",
            for: indexPath) as? ListTableViewCell else { return UITableViewCell() }
        cell.set()
        return cell
    }
}

// MARK: - Layout

private extension ListViewController {
    
    func layout() {
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor)])
    }
    
}

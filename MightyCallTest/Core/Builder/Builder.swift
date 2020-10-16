//
//  Builder.swift
//  MightyCallTest
//
//  Created by Анна Сычева on 16.10.2020.
//  Copyright © 2020 Анна Сычева. All rights reserved.
//

// MARK: - Builder

final class Builder: IBuilder {

    // MARK: - Public methods
    
    static func makeTabBarViewController() -> TabBarViewController {
        let viewController = TabBarViewController()
        
        return viewController
    }
    
    static func makeDetailViewController() -> DetailViewController {
        let viewController = DetailViewController()
        let networkService = NetworkService()
        let viewModel = DetailViewModel(networkService: networkService)
        viewController.viewModel = viewModel
        
        return viewController
    }
    
    static func makeListViewController() -> ListViewController {
        let viewController = ListViewController()
        
        return viewController
    }
    
}

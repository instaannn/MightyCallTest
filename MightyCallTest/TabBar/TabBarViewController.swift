//
//  TabBarViewController.swift
//  MightyCallTest
//
//  Created by Анна Сычева on 13.10.2020.
//  Copyright © 2020 Анна Сычева. All rights reserved.
//

import UIKit

// MARK: - TabBarViewController

final class TabBarViewController: UITabBarController {
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBar()
    }
}

// MARK: - SetupTabBar

private extension TabBarViewController {
    
    func setupTabBar() {
        
        let detailViewController = createNvigationController(
            viewController: DetailViewController(),
            image: Constants.imageName,
            selectImage: Constants.selectImageName,
            title: Constants.titleOne)
        
        let listViewController = createNvigationController(
            viewController: ListViewController(),
            image: Constants.imageName,
            selectImage: Constants.selectImageName,
            title: Constants.titleTwo)

        viewControllers = [detailViewController,
                           listViewController]
    }
}

// MARK: - CreateNvigationController

private extension TabBarViewController {
    
    func createNvigationController(viewController: UIViewController,
                                   image: String,
                                   selectImage: String,
                                   title: String) -> UINavigationController {
        let viewController = viewController
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.tabBarItem.image = UIImage(named: image)
        navigationController.tabBarItem.selectedImage = UIImage(named: selectImage)
        navigationController.tabBarItem.title = title
        navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController.navigationBar.shadowImage = UIImage()
        navigationController.navigationBar.isTranslucent = true
        return navigationController
    }
}

// MARK: - Constants

private extension TabBarViewController {
    
    enum Constants {
        static let imageName: String = "deselect"
        static let selectImageName: String = "select"
        static let titleOne: String = "TAB1"
        static let titleTwo: String = "TAB2"
    }
    
}

//
//  IBuilder.swift
//  MightyCallTest
//
//  Created by Анна Сычева on 16.10.2020.
//  Copyright © 2020 Анна Сычева. All rights reserved.
//

// MARK: - IBuilder

protocol IBuilder {
    static func makeTabBarViewController() -> TabBarViewController
    static func makeDetailViewController() -> DetailViewController
    static func makeListViewController() -> ListViewController
}

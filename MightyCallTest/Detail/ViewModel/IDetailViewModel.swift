//
//  IDetailViewModel.swift
//  MightyCallTest
//
//  Created by Анна Сычева on 14.10.2020.
//  Copyright © 2020 Анна Сычева. All rights reserved.
//


// MARK: - IDetailViewModel

protocol IDetailViewModel: class {
    var detailDidChange: ((DetailModel) -> ())? { get set }
    func fetchMainData()
}

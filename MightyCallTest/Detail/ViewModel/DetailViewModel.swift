//
//  DetailViewModel.swift
//  MightyCallTest
//
//  Created by Анна Сычева on 14.10.2020.
//  Copyright © 2020 Анна Сычева. All rights reserved.
//

import Foundation

// MARK: - DetailViewModel

final class DetailViewModel: IDetailViewModel {
    
    // MARK: Public properties
    
    var detailDidChange: ((DetailModel) -> ())?
    
    // MARK: Private properties
    
    private var networkServise: INetworkService = NetworkService()
    
    // MARK: Public methods
    
    func fetchMainData() {
        networkServise.fetchMainData { [weak self] result in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let data):
                    self.detailDidChange?(data)
                }
            }
        }
    }
    
}

//
//  CurrentWeatherViewController.swift
//  DummyProject
//
//  Created by Felipe Dias Pereira on 29/09/20.
//  Copyright © 2020 FelipePereira. All rights reserved.
//

import UIKit

final class CurrentWeatherViewController: UIViewController {
    let viewModel: CurrentWeatherViewModel
    
    init(viewModel: CurrentWeatherViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: Bundle.main)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBinds()
    }
    
    private func setupBinds() {
        
    }
}

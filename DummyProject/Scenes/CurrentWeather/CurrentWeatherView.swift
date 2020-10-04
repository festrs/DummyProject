//
//  CurrentWeatherView.swift
//  DummyProject
//
//  Created by Felipe Dias Pereira on 29/09/20.
//  Copyright © 2020 FelipePereira. All rights reserved.
//

import UIKit
import Common

final class CurrentWeatherView: BaseView {
  let tableView: UITableView = {
    let tableView = UITableView()
    tableView.tableFooterView = UIView()
    tableView.showsVerticalScrollIndicator = false
//    tableView.estimatedRowHeight = InvestimentosRendaFixaViewModel.estimatedRowHeight
//    tableView.register(BasicTableViewCell.self, forCellReuseIdentifier: BasicTableViewCell.identifier)
//    tableView.register(InvestimentosResumoTableViewCell.self, forCellReuseIdentifier: InvestimentosResumoTableViewCell.identifier)
//    tableView.register(PrimaryButtonTableViewCell.self, forCellReuseIdentifier: PrimaryButtonTableViewCell.identifier)
    tableView.translatesAutoresizingMaskIntoConstraints = false
    return tableView
  }()

  // MARK: - Initialize

  override func initialize() {
    backgroundColor = .white
    addSubview(tableView)
  }

  // MARK: - InstallConstraints

  override func installConstraints() {
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: topAnchor),
      tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
      tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }
}

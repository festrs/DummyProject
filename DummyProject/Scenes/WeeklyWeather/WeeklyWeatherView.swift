//
//  WeeklyWeatherView.swift
//  DummyProject
//
//  Created by Felipe Dias Pereira on 29/09/20.
//  Copyright © 2020 FelipePereira. All rights reserved.
//

import UIKit
import Common

final class WeeklyWeatherView: BaseView {
  let tableView: UITableView = {
    let tableView = UITableView()
    tableView.tableFooterView = UIView()
    tableView.showsVerticalScrollIndicator = false
    tableView.register(WeeklyWeatherTableViewCell.self,
                       forCellReuseIdentifier: WeeklyWeatherTableViewCell.typeName)
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

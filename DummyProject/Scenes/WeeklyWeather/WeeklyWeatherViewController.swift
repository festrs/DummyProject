//
//  WeeklyWeatherViewController.swift
//  DummyProject
//
//  Created by Felipe Dias Pereira on 29/09/20.
//  Copyright © 2020 FelipePereira. All rights reserved.
//

import UIKit
import Common
import Combine

final class WeeklyWeatherViewController: UIViewController {
  private(set) lazy var baseView: WeeklyWeatherView = {
    let view = WeeklyWeatherView()
    return view
  }()

  private var tableDataSource: TableViewDataSource<DailyWeatherRowViewModel>
  private var disposables = Set<AnyCancellable>()
  let viewModel: WeeklyWeatherViewModel

  init(viewModel: WeeklyWeatherViewModel) {
    self.viewModel = viewModel
    self.tableDataSource = TableViewDataSource(models: [],
                                               reuseIdentifier: WeeklyWeatherTableViewCell.typeName,
                                               cellConfigurator: { (model, cell) in
                                                model.configureWeeklyCell(cell)
    })
    super.init(nibName: nil, bundle: Bundle.main)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Life Cycle
  override func loadView() {
    super.loadView()
    view = baseView
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    setupBinds()
  }

  private func setupBinds() {
    baseView.tableView.dataSource = tableDataSource

    viewModel.$dataSource.sink { [weak self] loadableResult in
      guard let self = self else { return }
      switch loadableResult {
      case .notRequested:
        break

      case .isLoading:
        break

      case let .loaded(forecast):
        self.loadWeeklyWeatherForecast(forecast)

      case let .failed(error):
        break
      }
    }.store(in: &disposables)
  }
}

private extension WeeklyWeatherViewController {
  func loadWeeklyWeatherForecast(_ forecastList: [DailyWeatherRowViewModel]) {
    tableDataSource.models = forecastList
    baseView.tableView.reloadData()
  }
}

//
//  SceneDelegate.swift
//  DummyProject
//
//  Created by Felipe Dias Pereira on 22/09/20.
//  Copyright © 2020 FelipePereira. All rights reserved.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  var window: UIWindow?
  
  func scene(_ scene: UIScene,
             willConnectTo session: UISceneSession,
             options connectionOptions: UIScene.ConnectionOptions) {
    // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
    // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
    // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).

    guard let windowScene = scene as? UIWindowScene else { return }


    let useCase = WeatherForecastUseCaseStore()
    let viewModel = WeeklyWeatherViewModel(useCase: useCase)
    let weeklyView = WeeklyWeatherViewSwiftUI(viewModel: viewModel)

    let window = UIWindow(windowScene: windowScene)
    window.rootViewController = UIHostingController(rootView: weeklyView)
    window.makeKeyAndVisible()
    self.window = window
  }
}


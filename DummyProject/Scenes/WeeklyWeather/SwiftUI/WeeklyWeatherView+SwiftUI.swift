/// Copyright (c) 2019 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import SwiftUI

struct WeeklyWeatherViewSwiftUI: View {
  @ObservedObject var viewModel: WeeklyWeatherViewModel

  init(viewModel: WeeklyWeatherViewModel) {
    self.viewModel = viewModel
  }
  
  var body: some View {
    NavigationView {
      List {
        searchField
        content
      }
      .listStyle(GroupedListStyle())
      .navigationBarTitle("Weather ⛅️")
    }
  }
}

private extension WeeklyWeatherViewSwiftUI {
  var content: some View {
    switch viewModel.dataSource {
    case .notRequested:
      return AnyView(emptySection)
    case .isLoading:
      return AnyView(Text("is loading"))
    case let .loaded(countries):
      return AnyView(VStack {
        cityHourlyWeatherSection
        Section {
          ForEach(countries, content: DailyWeatherRow.init(viewModel:))
        }
      })
    case let .failed(error):
      return AnyView(ErrorView(error: error,
                               retryAction: { }))
    }
  }

  var searchField: some View {
    HStack(alignment: .center) {
      TextField("e.g. Cupertino", text: $viewModel.city)
    }
  }

  var cityHourlyWeatherSection: some View {
    Section {
      NavigationLink(destination: viewModel.currentWeatherView) {
        VStack(alignment: .leading) {
          Text(viewModel.city)
          Text("Weather today")
            .font(.caption)
            .foregroundColor(.gray)
        }
      }
    }
  }

  var emptySection: some View {
    Section {
      Text("No results")
        .foregroundColor(.gray)
    }
  }
}


// MARK: - Previews

struct WeeklyWeatherViewSwiftUI_Previews: PreviewProvider {
  static let viewModel = WeeklyWeatherViewModel(useCase: WeatherForecastUseCaseMock())
  static var previews: some View {
    Group {
      NavigationView {
        WeeklyWeatherViewSwiftUI(viewModel: viewModel)
          .colorScheme(.light)
      }
      NavigationView {
        WeeklyWeatherViewSwiftUI(viewModel: viewModel)
          .colorScheme(.dark)
      }
    }
  }
}

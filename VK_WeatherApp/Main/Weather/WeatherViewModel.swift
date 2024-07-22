//
//  WeatherViewModel.swift
//  VK_WeatherApp
//
//  Created by Ai Hawok on 22/07/2024.
//

import Foundation
import UIKit

class WeatherViewModel {
    
    private(set) var weatherData: [Weather] = []
    private(set) var selectedWeatherIndex: Int?

    init() {
        loadWeatherData()
        selectRandomWeather()
    }
    
    private func loadWeatherData() {
          weatherData = [
            Weather(icon: UIImage(named: "weatherCloudyDay")!, title: "Cloudy Day", description: "Overcast day", topColor: Constants.Colors.blue, bottomColor: Constants.Colors.primary),
              Weather(icon: UIImage(named: "weatherCloudyDayLess")!, title: "Less Cloudy", description: "Few clouds", topColor: Constants.Colors.blue, bottomColor: Constants.Colors.primary),
              Weather(icon: UIImage(named: "weatherCloudyNight")!, title: "Starry Night", description: "Overcast night", topColor: Constants.Colors.darkerBlue, bottomColor: Constants.Colors.primaryDarker),
              Weather(icon: UIImage(named: "weatherRain2")!, title: "Rain", description: "Rainy weather", topColor: Constants.Colors.grayish, bottomColor: Constants.Colors.primaryDarker),
              Weather(icon: UIImage(named: "weatherSun")!, title: "Sunny", description: "Clear sky", topColor: Constants.Colors.sunny, bottomColor: Constants.Colors.light),
              Weather(icon: UIImage(named: "weatherThunder")!, title: "Thunder", description: "Thunderstorm", topColor: Constants.Colors.darkerBlue, bottomColor: Constants.Colors.primaryDarker)
          ]
      }
    
    private func selectRandomWeather() {
        selectedWeatherIndex = Int.random(in: 0..<weatherData.count)
    }
    
    func getSelectedWeather() -> Weather? {
        guard let index = selectedWeatherIndex else { return nil }
        return weatherData[index]
    }
    
    func setSelectedWeatherIndex(_ index: Int) {
        selectedWeatherIndex = index
    }
}

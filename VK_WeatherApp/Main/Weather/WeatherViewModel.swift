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
            Weather(
                icon: UIImage(
                    named: "weatherCloudyDay"
                )!,
                title:  NSLocalizedString("cloudyDay", comment: "cloudyDay"),
                description: "Overcast day",
                topColor: Constants.Colors.blue,
                bottomColor: Constants.Colors.primary
            ),
            Weather(
                icon: UIImage(
                    named: "weatherCloudyDayLess"
                )!,
                title:  NSLocalizedString("lessCloudy", comment: "lessCloudy"),
                description: NSLocalizedString("lessCloudyDescr", comment: "lessCloudyDescr"),
                topColor: Constants.Colors.blue,
                bottomColor: Constants.Colors.primary
            ),
            Weather(
                icon: UIImage(
                    named: "weatherCloudyNight"
                )!,
                title: NSLocalizedString("starryNight", comment: "starryNight"),
                description: NSLocalizedString("starryNightDescr", comment: "starryNightDescr"),
                topColor: Constants.Colors.darkerBlue,
                bottomColor: Constants.Colors.primaryDarker
            ),
            Weather(
                icon: UIImage(
                    named: "weatherRain2"
                )!,
                title: NSLocalizedString("rain", comment: "rain"),
                description:  NSLocalizedString("rainDescr", comment: "rainDescr"),
                topColor: Constants.Colors.grayish,
                bottomColor: Constants.Colors.primaryDarker
            ),
            Weather(
                icon: UIImage(
                    named: "weatherSun"
                )!,
                title: NSLocalizedString("sunny", comment: "sunny"),
                description:  NSLocalizedString("sunnyDescr", comment: "sunnyDescr"),
                topColor: Constants.Colors.sunny,
                bottomColor: Constants.Colors.light
            ),
            Weather(
                icon: UIImage(
                    named: "weatherThunder"
                )!,
                title: NSLocalizedString("thunder", comment: "thunder"),
                description:NSLocalizedString("thunderDescr", comment: "thunderDescr"),
                topColor: Constants.Colors.darkerBlue,
                bottomColor: Constants.Colors.primaryDarker
            )
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

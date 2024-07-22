//
//  MainViewController.swift
//  VK_WeatherApp
//
//  Created by Ai Hawok on 22/07/2024.
//

import UIKit

class MainViewController: UIViewController {
    
    private var mainView: MainView!
    private var viewModel: WeatherViewModel!
    
    override func loadView() {
        mainView = MainView(frame: UIScreen.main.bounds)
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = WeatherViewModel()
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        mainView.collectionView.dataSource = self
        mainView.collectionView.delegate = self
        mainView.collectionView.reloadData()
    }
}

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.weatherData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherCell.reuseIdentifier, for: indexPath) as? WeatherCell else {
            return UICollectionViewCell()
        }
        let weather = viewModel.weatherData[indexPath.item]
        cell.configure(with: weather.icon)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedWeather = viewModel.weatherData[indexPath.item]
        mainView.updateWeatherInfo(weather: selectedWeather)
    }
}

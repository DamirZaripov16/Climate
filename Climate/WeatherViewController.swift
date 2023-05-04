//
//  ViewController.swift
//  Climate
//
//  Created by Damir Zaripov on 30.04.2023.
// 

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    //MARK: - Delegates
    
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    
    //MARK: - Elements
    private lazy var backgroundImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "background")
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var locationButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "location.circle.fill"), for: .normal)
        button.tintColor = UIColor(named: "weatherColor")
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(locationButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var searchBar: UITextField = {
        let searchBar = UITextField()
        searchBar.placeholder = "Search"
        searchBar.autocapitalizationType = .words
        searchBar.returnKeyType = .go
        searchBar.borderStyle = .roundedRect
        searchBar.contentMode = .scaleToFill
        searchBar.textAlignment = .right
        searchBar.backgroundColor = .systemFill
        searchBar.font = UIFont.systemFont(ofSize: 25)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    private lazy var searchButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.tintColor = UIColor(named: "weatherColor")
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(searchPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var conditionImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "sun.max")
        image.tintColor = UIColor(named: "weatherColor")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var temperatureNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "21"
        label.textColor = UIColor(named: "weatherColor")
        label.font = UIFont.boldSystemFont(ofSize: 100)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var temperatureSignLabel: UILabel = {
        let label = UILabel()
        label.text = "°"
        label.textColor = UIColor(named: "weatherColor")
        label.font = UIFont.boldSystemFont(ofSize: 100)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var temperatureCelciusLabel: UILabel = {
        let label = UILabel()
        label.text = "C"
        label.textColor = UIColor(named: "weatherColor")
        label.font = UIFont.boldSystemFont(ofSize: 100)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.text = "Kazan"
        label.textColor = UIColor(named: "weatherColor")
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    //MARK: - Methods
    private func setupView() {
        view.addSubview(backgroundImage)
        view.addSubview(locationButton)
        view.addSubview(searchBar)
        view.addSubview(searchButton)
        view.addSubview(conditionImage)
        view.addSubview(temperatureNumberLabel)
        view.addSubview(temperatureSignLabel)
        view.addSubview(temperatureCelciusLabel)
        view.addSubview(cityLabel)
        
    }
    //MARK: - Constraints
    private func setConstraints() {
        
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            locationButton.topAnchor.constraint(equalTo: safeArea.topAnchor),
            locationButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            locationButton.trailingAnchor.constraint(equalTo: searchBar.leadingAnchor, constant: -20),
            locationButton.widthAnchor.constraint(equalToConstant: 40),
            locationButton.heightAnchor.constraint(equalToConstant: 40),
            
            searchBar.topAnchor.constraint(equalTo: safeArea.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: locationButton.trailingAnchor, constant: 10),
            searchBar.trailingAnchor.constraint(equalTo: searchButton.leadingAnchor, constant: -10),
            searchBar.widthAnchor.constraint(equalToConstant: 274),
            searchBar.heightAnchor.constraint(equalToConstant: 40),
            
            searchButton.topAnchor.constraint(equalTo: safeArea.topAnchor),
            searchButton.leadingAnchor.constraint(equalTo: searchBar.trailingAnchor, constant: 10),
            searchButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
            searchButton.widthAnchor.constraint(equalToConstant: 40),
            searchButton.heightAnchor.constraint(equalToConstant: 40),
            
            conditionImage.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10),
            conditionImage.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -10),
            conditionImage.widthAnchor.constraint(equalToConstant: 120),
            conditionImage.heightAnchor.constraint(equalToConstant: 120),
            
            temperatureCelciusLabel.topAnchor.constraint(equalTo: conditionImage.bottomAnchor, constant: 10),
            temperatureCelciusLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -10),
            
            temperatureSignLabel.topAnchor.constraint(equalTo: conditionImage.bottomAnchor, constant: 10),
            temperatureSignLabel.trailingAnchor.constraint(equalTo: temperatureCelciusLabel.leadingAnchor),
            
            temperatureNumberLabel.topAnchor.constraint(equalTo: conditionImage.bottomAnchor, constant: 10),
            temperatureNumberLabel.trailingAnchor.constraint(equalTo: temperatureSignLabel.leadingAnchor),
            
            cityLabel.topAnchor.constraint(equalTo: temperatureCelciusLabel.bottomAnchor, constant: 10),
            cityLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -10),
            
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setConstraints()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        weatherManager.delegate = self
        searchBar.delegate = self
    }
}

//MARK: - UITextFieldDelegate
extension WeatherViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchBar.endEditing(true)
        print(searchBar.text!)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Type smth."
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = searchBar.text {
            weatherManager.fetchWeather(cityName: city)
        }
        
        searchBar.text = ""
    }
    
    @objc func searchPressed(_ sender: UIButton) {
        searchBar.endEditing(true)
        
    }
    
    @objc func locationButtonPressed(_ sender: UIButton) {
        
        locationManager.requestLocation()
        
    }
    
}
//MARK: - WeatherManagerDelegate
extension WeatherViewController: WeatherManagerDelegate {
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.temperatureNumberLabel.text = weather.temperatureString
            self.conditionImage.image = UIImage(systemName: weather.conditionName)
            self.cityLabel.text = weather.cityName
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}
//MARK: - CLLocationManagerDelegate
extension WeatherViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(latitude: lat, longitude: lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

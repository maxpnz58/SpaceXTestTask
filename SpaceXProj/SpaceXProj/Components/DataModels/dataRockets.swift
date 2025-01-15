//
//  dataRockets.swift
//  SpaceXProj
//
//  Created by Max on 21.11.2024.
//

import Foundation

struct RocketParameter: Decodable {
    let title: String
    let parameters: [String]
    let meanings: [String]
}

// MARK: - rocketSpaceX
struct rocketSpaceX: Decodable {
    let name: String
    let height:  Diameter
    let diameter: Diameter
    let mass: Mass
    let payloadWeights: [PayloadWeight]
    
    let costPerLaunch: Int
    let firstFlight: String
    let country: String
    
    let firstStage: FirstStage
    let secondStage: SecondStage
    
    let flickrImages: [String]
    
    let id: Rocket

    enum CodingKeys: String, CodingKey {
        case name,height, diameter, mass, id
        case payloadWeights = "payload_weights"
        
        case costPerLaunch = "cost_per_launch"
        case firstFlight = "first_flight"
        case country
        
        case firstStage = "first_stage"
        case secondStage = "second_stage"
        
        case flickrImages = "flickr_images"
    }
}

// MARK: - Diameter
struct Diameter: Codable {
    let meters, feet: Double?
}
// MARK: - Mass
struct Mass: Codable {
    let kg, lb: Int
}
// MARK: - PayloadWeight
struct PayloadWeight: Codable {
    let kg, lb: Int
}
// MARK: - Thrust
struct Thrust: Codable {
    let kN, lbf: Int
}
// MARK: - FirstStage
struct FirstStage: Codable {
    let engines: Int
    let fuelAmountTons: Double
    let burnTimeSEC: Int?
    enum CodingKeys: String, CodingKey {
        case engines
        case fuelAmountTons = "fuel_amount_tons"
        case burnTimeSEC = "burn_time_sec"
    }
}
// MARK: - SecondStage
struct SecondStage: Codable {
    let engines: Int
    let fuelAmountTons: Double
    let burnTimeSEC: Int?

    enum CodingKeys: String, CodingKey {
        case engines
        case fuelAmountTons = "fuel_amount_tons"
        case burnTimeSEC = "burn_time_sec"
    }
}

let rocketBaseParametersNames: [(title: String, parameters: [String], meanings: [String])] = [
    (title: "", parameters: ["Первый запуск","Страна","Стоимость запуска"], meanings: ["7 февраля 2018","США","1 мрд. $"]),
    (title: "ПЕРВАЯ СТУПЕНЬ", parameters: ["К-во двигтелей","К-во топлива","Время сгорания"], meanings: ["3","10000","34"]),
    (title: "ВТОРАЯ СТУПЕНЬ", parameters: ["К-во двигтелей","К-во топлива","Время сгорания"], meanings: ["6","12400","67"]),
]

class rocketsSpaceX: Decodable {
    var rockets: [rocketSpaceX]?
    
    var rocketPictures = [
        "falcon1",
        "falcon9",
        "falconHeavy",
        "starship"
    ]
    
    var rocketCollectionParametersNames = [
        ["Высота, m","Диаметр, m","Масса, kg","Загрузка, kg"],
        ["Высота, feet","Диаметр, feet","Масса, inches","Загрузка, inches"]
    ]
    
    var rocketCollectionParameters = [[String]]()
    
    
    var rocketBaseParameters = [[RocketParameter]]()

    init() {
        loadProductsFromJson()
    }
    

    private func loadProductsFromJson() {
        guard let url = Bundle.main.url(forResource: "fromServerRequestShips", withExtension: ".json") else { print("файл json не найден")
            return
        }
        do {
            let data = try Data(contentsOf: url)
            let decode = JSONDecoder()
            rockets = try decode.decode([rocketSpaceX].self, from: data)
            loadRocketCollectionParameters()
            loadRocketBaseParameters()
            print("Боеголовки успешно загружены, сэр! ")
        } catch {
            print("Дэбил, у тебя ошибка при загрузке или декодировании JSON с ракетами: \(error)")
        }
    }
    
    private func loadRocketCollectionParameters() {
        rockets?.forEach({ rocket in
            rocketCollectionParameters.append([
                String(rocket.height.meters!),
                String(rocket.diameter.meters!),
                formatDigitsInt(rocket.mass.kg),
                formatDigitsInt(rocket.payloadWeights.first!.kg),
                ])
            
            print(rocket.name)
            print(rocket.id)
        })
    }
    
    private func loadRocketBaseParameters() {
        rockets?.forEach { rocket in
            let rocketParameterInitial = RocketParameter(
                title: "",
                parameters: [
                    "Первый запуск",
                    "Страна",
                    "Стоимость запуска"
                ],
                meanings: [
                    formatData(rocket.firstFlight),
                    String(rocket.country),
                    formatCurency(rocket.costPerLaunch)
                ]
            )
            
            let rocketParameterOne = RocketParameter(
                title: "",
                parameters: [
                    "Количество двигателей",
                    "Количество топлива",
                    "Время сгорания"
                ],
                meanings: [
                    String(rocket.firstStage.engines),
                    "\(String(rocket.firstStage.fuelAmountTons)) тон",
                    "\(String(rocket.firstStage.burnTimeSEC ?? 0)) сек"
                ]
            )
            
            let rocketParameterTwo = RocketParameter(
                title: "",
                parameters: [
                    "Количество двигателей",
                    "Количество топлива",
                    "Время сгорания"
                ],
                meanings: [
                    String(rocket.secondStage.engines),
                    "\(String(rocket.secondStage.fuelAmountTons)) тон",
                    "\(String(rocket.secondStage.burnTimeSEC ?? 0)) сек"
                ]
            )
            
            rocketBaseParameters.append([rocketParameterInitial,rocketParameterOne,rocketParameterTwo])
        }
    }
    
    private func formatData(_ inDate :String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        inputFormatter.locale = Locale(identifier: "ru_RU")
        
        guard let date = inputFormatter.date(from: inDate) else {
            print("Ошибка: Невозможно преобразовать строку в дату")
            return inDate
        }
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "d MMMM yyyy"
        outputFormatter.locale = Locale(identifier: "ru_RU")
        
        return outputFormatter.string(from: date)
    }
    
    private func formatCountry(_ :String) -> String {
        return ""
    }
    
    private func formatCurency(_ inCurrency :Int) -> String {
        let priceInMillions = Double(inCurrency) / 1_000_000
        return String(format: "$%.0f млн", priceInMillions)
    }
    
    private func formatDigitsInt(_ inDigit: Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.groupingSeparator = "."
        return numberFormatter.string(from: NSNumber(value: inDigit)) ?? ""
    }
}





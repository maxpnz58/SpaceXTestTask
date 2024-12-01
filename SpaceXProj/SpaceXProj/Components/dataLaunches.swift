////
////  data.swift
////  SpaceXProj
////
////  Created by Max on 20.11.2024.
////
//
//// This file was generated from JSON Schema using quicktype, do not modify it directly.
//// To parse the JSON, add this file to your project and do:
////
////   let topLevel = try? JSONDecoder().decode(LauchSpaceXCases.self, from: jsonData)
//import Foundation
//
//
//
//// MARK: - TopLevelElement
//struct LauchSpaceXCases:Decodable {
//    let fairings: Fairings?
////    let links: Links
//    let staticFireDateUTC: String?
//    let staticFireDateUnix: Int?
//    let net: Bool
//    let window: Int?
////    let rocket: Rocket
////    let success: Bool?
////    let failures: [Failure]
////    let details: String?
////    let crew, ships, capsules, payloads: [String]
////    let launchpad: Launchpad
////    let flightNumber: Int
////    let name, dateUTC: String
////    let dateUnix: Int
////    let dateLocal: Date
////    let datePrecision: DatePrecision
////    let upcoming: Bool
////    let cores: [Core]
////    let autoUpdate, tbd: Bool
////    let launchLibraryID: String?
////    let id: String
//}
//
//// MARK: - Core
//struct Core: Decodable {
//    let core: String?
//    let flight: Int?
//    let gridfins, legs, reused, landingAttempt: Bool?
//    let landingSuccess: Bool?
//    let landingType: LandingType?
//    let landpad: Landpad?
//}
//
//enum LandingType: String, Decodable {
//    case asds
//    case ocean
//    case rtls
//}
//
//enum Landpad: String, Decodable {
//    case the5E9E3032383Ecb267A34E7C7
//    case the5E9E3032383Ecb554034E7C9
//    case the5E9E3032383Ecb6Bb234E7CA
//    case the5E9E3032383Ecb761634E7Cb
//    case the5E9E3032383Ecb90A834E7C8
//    case the5E9E3033383Ecb075134E7CD
//    case the5E9E3033383Ecbb9E534E7Cc
//}
//
//enum DatePrecision: String, Decodable {
//    case day
//    case hour
//    case month
//}
//
//// MARK: - Failure
//struct Failure: Decodable {
//    let time: Int
//    let altitude: Int?
//    let reason: String
//}
//
//// MARK: - Fairings
//struct Fairings: Decodable {
//    let reused, recoveryAttempt, recovered: Bool?
//    let ships: [String]
//}
//
//enum Launchpad: String, Decodable {
//    case the5E9E4501F509094Ba4566F84
//    case the5E9E4502F509092B78566F87
//    case the5E9E4502F509094188566F88
//    case the5E9E4502F5090995De566F86
//}
//
//// MARK: - Links
//struct Links: Decodable {
//    let patch: Patch
//    let reddit: Reddit
//    let flickr: Flickr
//    let presskit: String?
//    let webcast: String?
//    let youtubeID: String?
//    let article: String?
//    let wikipedia: String?
//}
//
//// MARK: - Flickr
//struct Flickr: Decodable {
//    //let small: [Any?]
//    let original: [String]
//}
//
//// MARK: - Patch
//struct Patch: Decodable {
//    let small, large: String?
//}
//
//// MARK: - Reddit
//struct Reddit:Decodable {
//    let campaign: String?
//    let launch: String?
//    let media, recovery: String?
//}
//
//enum Rocket: String, Decodable {
//    case the5E9D0D95Eda69955F709D1Eb
//    case the5E9D0D95Eda69973A809D1Ec
//    case the5E9D0D95Eda69974Db09D1Ed
//}
//
//
//class LauchSpaceXCasesClass: Decodable {
//    var launches: [LauchSpaceXCases]?
//    
//    init() {
//        loadProductsFromJson()
//        print(launches?[200].fairings?.ships as Any)
//    }
//    
//    private func loadProductsFromJson() {
//        guard let url = Bundle.main.url(forResource: "fromServerRequestLaunches", withExtension: ".json") else { print("файл json не найден")
//            return
//        }
//        do {
//            let data = try Data(contentsOf: url)
//            let decode = JSONDecoder()
//            launches = try decode.decode([LauchSpaceXCases].self, from: data)
//            print("Продукты успешно загружены: ")
//        } catch {
//            print("Ошибка при загрузке или декодировании JSON: \(error)")
//        }
//    }
//}

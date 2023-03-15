//
//  RequestsManager.swift
//  JMPC-NYC-Schools
//
//  Created by Ramiro on 3/14/23.
//

import Foundation
import RxSwift

enum NetwokError: Error {
    case timeOut
    case noData
    case corruptedData
}

protocol RequestsManagerProtocol: AnyObject {
//    func fetchData(with url: URL, completion: @escaping (Result<[HighSchoolRecord], NetwokError>) -> Void)
//    func fetchDetailData(with url: URL, completion: @escaping (Result<[HighSchoolDetailRecord], NetwokError>) -> Void)
//    func fetchData2(with url: URL) -> Single<[HighSchoolRecord]>
//    func fetchData3(with url: URL) -> Single<Any>
    func fetchHighSchoolDetailRecords(with url: URL) -> Single<[HighSchoolDetailRecord]>
    func fetchHighSchoolRecords(with url: URL) -> Single<[HighSchoolRecord]>
}

class RequestsManager: RequestsManagerProtocol {
//    func fetchData(with url: URL, completion: @escaping (Result<[HighSchoolRecord], NetwokError>) -> Void) {
//        URLSession.shared.dataTask(with: url) { (data, response, error) in
////            guard error == nil else {
//                completion(.failure(NetwokError.timeOut))
//                return
////            }
////
////            guard let data = data else {
////                completion(.failure(NetwokError.noData))
////                return
////            }
////            do {
////                let values = try JSONDecoder().decode([HighSchoolRecord].self, from: data)
////                completion(.success(values))
////            } catch {
////                completion(.failure(NetwokError.corruptedData))
////            }
//
//        }.resume()
//    }
    
//    // TODO: - This must be done by generic return
//    func fetchDetailData(with url: URL, completion: @escaping (Result<[HighSchoolDetailRecord], NetwokError>) -> Void) {
//        URLSession.shared.dataTask(with: url) { (data, response, error) in
//            guard error == nil else {
//                completion(.failure(NetwokError.timeOut))
//                return
//            }
//
//            guard let data = data else {
//                completion(.failure(NetwokError.noData))
//                return
//            }
//
//            do {
//                let values = try JSONDecoder().decode([HighSchoolDetailRecord].self, from: data)
//                completion(.success(values))
//            } catch {
//                completion(.failure(NetwokError.corruptedData))
//            }
//        }.resume()
//    }
    
    
    
//    func fetchData2(with url: URL) -> Single<[HighSchoolRecord]> {
//        return .create { single in
//            URLSession.shared.dataTask(with: url) { (data, response, error) -> Void in
//                guard error == nil else {
//                    single(.error(NetwokError.timeOut))
//                    return
//                }
//                guard let data = data else {
//                    single(.error(NetwokError.noData))
//                    return
//                }
//                do {
//                    let values = try JSONDecoder().decode([HighSchoolRecord].self, from: data)
//                    single(.success(values))
//                } catch {
//                    single(.error(NetwokError.corruptedData))
//               }
//            }.resume()
//            return Disposables.create()
//        }
//    }
    
    func fetchHighSchoolRecords(with url: URL) -> Single<[HighSchoolRecord]> {
        return .create { single in
            URLSession.shared.dataTask(with: url) { (data, response, error) -> Void in
                guard error == nil else {
                    single(.error(NetwokError.timeOut))
                    return
                }
                guard let data = data else {
                    single(.error(NetwokError.noData))
                    return
                }
                do {
                    let values = try JSONDecoder().decode([HighSchoolRecord].self, from: data)
                    single(.success(values))
                } catch {
                    single(.error(NetwokError.corruptedData))
               }
            }.resume()
            return Disposables.create()
        }
    }
    
    
    func fetchHighSchoolDetailRecords(with url: URL) -> Single<[HighSchoolDetailRecord]> {
        return .create { single in
            URLSession.shared.dataTask(with: url) { (data, response, error) -> Void in
                guard error == nil else {
                    single(.error(NetwokError.timeOut))
                    return
                }
                guard let data = data else {
                    single(.error(NetwokError.noData))
                    return
                }
                do {
                    let values = try JSONDecoder().decode([HighSchoolDetailRecord].self, from: data)
                    single(.success(values))
                } catch {
                    single(.error(NetwokError.corruptedData))
               }
            }.resume()
            return Disposables.create()
        }
    }
}

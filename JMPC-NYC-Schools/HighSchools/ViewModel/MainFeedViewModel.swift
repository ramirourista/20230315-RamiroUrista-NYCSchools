//
//  MainFeedViewModel.swift
//  JMPC-NYC-Schools
//
//  Created by Ramiro on 3/14/23.
//

import Foundation
import RxSwift

protocol MainFeedViewModelProtocol: AnyObject {
    var highSchoolRecords: [HighSchoolRecord] { get }
    var reloadTableView: (() -> Void)? { get }
    var isThereAnyError: ((_ message: String) -> Void)? { get }
    var cities: [String] {get}
    func fetchData()
    func filterHighSchools(by city: String)
}

class  MainFeedViewModel: MainFeedViewModelProtocol {
    
    // MARK: - Manager data
    var requestsManager: RequestsManagerProtocol
    
    // MARK: - Properties
    var highSchoolRecords: [HighSchoolRecord] = []
    
    //
    var cities: [String] = ["All-cities"]
    var highSchoolOriginalRecords: [HighSchoolRecord] = []
    
    // MARK: - Reload closures
    var reloadTableView: (() -> Void)?
    var isThereAnyError: ((_ message: String) -> Void)?
    
    // MARK: - Disposable's
    let disposeBag = DisposeBag()
    
    // MARK: - custom Init
    /// - Receive:
    init(requestsManager: RequestsManagerProtocol) {
        self.requestsManager = requestsManager
    }
}

// MARK: - Data managment
extension MainFeedViewModel {
    func fetchData() {
        guard let url: URL = URL(string: Service.highSchoolRecordsURL) else {
            return
        }
        requestsManager.fetchHighSchoolRecords(with: url)
            .subscribe { [weak self] (highSchoolRecords) in
                guard let self = self else { return }
                self.getCities(highSchoolRecords: highSchoolRecords)
            } onError: { (error) in
                self.isThereAnyError?(error.localizedDescription)
        }.disposed(by: self.disposeBag)
    }
    
    private func getCities(highSchoolRecords: [HighSchoolRecord]) {
        
        self.cities.append(contentsOf: Array(Set(highSchoolRecords.compactMap({$0.city}))))
        
        // We can modify data or make something for it
        self.highSchoolRecords = highSchoolRecords
        self.highSchoolOriginalRecords = highSchoolRecords
        // Lets reload the view
        self.reloadTableView?()
    }
}

// MARK: - Helpers
extension MainFeedViewModel {
    func filterHighSchools(by city: String) {
        if city != "All-cities" {
            let filterHighSchools = self.highSchoolOriginalRecords.filter({ $0.city == city})
            self.highSchoolRecords = filterHighSchools
        } else {
            self.highSchoolRecords = self.highSchoolOriginalRecords
        }

        // Lets reload the view
        self.reloadTableView?()
    }
}

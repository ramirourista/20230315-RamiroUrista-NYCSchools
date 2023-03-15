//
//  HighSchoolDetailViewModel.swift
//  JMPC-NYC-Schools
//
//  Created by Ramiro on 3/14/23.
//

import Foundation
import RxSwift

protocol HighSchoolDetailViewModelProtocol: AnyObject {
    var highSchoolDetailRecords: [HighSchoolDetailRecord] { get }
    var reloadTableView: (() -> Void)? { get }
    var isThereAnyError: ((_ message: String) -> Void)? { get }
    func fetchData()
    func isDataAvaliable() -> Bool
}

class  HighSchoolDetailViewModel: HighSchoolDetailViewModelProtocol {
    
    // MARK: - Injected data
    let requestsManager: RequestsManagerProtocol
    let currentHighSchool: HighSchoolRecord
    
    // MARK: - Properties
    var highSchoolDetailRecords: [HighSchoolDetailRecord] = []
    
    // MARK: - Reload closures or errors
    var reloadTableView: (() -> Void)?
    var isThereAnyError: ((_ message: String) -> Void)?
    
    // MARK: - Disposable's
    let disposeBag = DisposeBag()
    
    // MARK: - Custom init
    init(requestsManager: RequestsManagerProtocol, currentHighSchool: HighSchoolRecord) {
        self.requestsManager = requestsManager
        self.currentHighSchool = currentHighSchool
    }
    
    func fetchData() {
        guard let dbn = currentHighSchool.dbn, let url: URL = URL(string: Service.highSchoolDetailRecordsURL(with: dbn))  else {
            return
        }
                           
        requestsManager.fetchHighSchoolDetailRecords(with: url)
            .subscribe { [weak self] (highSchoolDetailRecords) in
                guard let self = self else { return }
                // We can modify data or make something for it
                self.highSchoolDetailRecords = highSchoolDetailRecords
                // Lets reload the view
                self.reloadTableView?()
            } onError: { (error) in
                self.isThereAnyError?(error.localizedDescription)
        }.disposed(by: self.disposeBag)
        
    }
    
    func isDataAvaliable() -> Bool {
        return !(self.highSchoolDetailRecords.map({$0.num_of_sat_test_takers}).isEmpty &&
                 self.highSchoolDetailRecords.map({$0.sat_critical_reading_avg_score}).isEmpty &&
                 self.highSchoolDetailRecords.map({$0.sat_math_avg_score}).isEmpty &&
                 self.highSchoolDetailRecords.map({$0.sat_writing_avg_score}).isEmpty)
    }
}

//
//  Service.swift
//  JMPC-NYC-Schools
//
//  Created by Ramiro on 3/14/23.
//

import Foundation

enum Service {
    static let highSchoolRecordsURL = "https://data.cityofnewyork.us/resource/s3k6-pzi2.json"
    static func highSchoolDetailRecordsURL(with dbn: String) -> String {
        return "https://data.cityofnewyork.us/resource/f9bf-2cp4.json?dbn=\(dbn)"
    }
    
}

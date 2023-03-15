//
//  HighSchoolData.swift
//  JMPC-NYC-Schools
//
//  Created by Ramiro on 3/14/23.
//

import Foundation

final class HighSchoolRecord: Decodable {
    var dbn: String?
    var school_name: String?
    var boro: String?
    var city: String?
    var zip: String?
    var state_code: String?
    var latitude: String?
    var longitude: String?
    
    init(dbn:String?, city:String?){
        self.city = city
        self.dbn = dbn
    }
}

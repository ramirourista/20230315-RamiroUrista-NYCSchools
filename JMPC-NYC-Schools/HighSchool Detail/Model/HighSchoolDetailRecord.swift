//
//  HighSchoolDetailRecord.swift
//  JMPC-NYC-Schools
//
//  Created by Ramiro on 3/14/23.
//

import Foundation

final class HighSchoolDetailRecord: Decodable {
    var dbn: String?
    var school_name: String?
    var num_of_sat_test_takers: String?
    var sat_critical_reading_avg_score: String?
    var sat_math_avg_score: String?
    var sat_writing_avg_score: String?
}

/// - This would work for Unit testing
//"dbn":"11X253",
//"school_name":"BRONX HIGH SCHOOL FOR WRITING AND COMMUNICATION ARTS",
//"num_of_sat_test_takers":"46",
//"sat_critical_reading_avg_score":"400",
//"sat_math_avg_score":"357",
//"sat_writing_avg_score":"390"

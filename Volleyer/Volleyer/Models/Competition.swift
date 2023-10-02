//
//  Competition.swift
//  Volleyer
//
//  Created by 李童 on 2023/9/18.
//

import Foundation

struct Competition {
    var title: String
    var date: String
    var county: String
    var url: String
}

enum CompetitionTitle: String {
    case title = "title"
    case date = "date"
    case county = "county"
    case url = "enroll_url"
}

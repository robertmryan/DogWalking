//
//  DayOfWeek.swift
//  DogWalking
//
//  Created by Robert Ryan on 5/5/19.
//  Copyright © 2019 Robert Ryan. All rights reserved.
//

import Foundation

enum DayOfWeek: String, CaseIterable {
    case sunday, monday, tuesday, wednesday, thursday, friday, saturday
}

extension DayOfWeek {
    var text: String {
        switch self {
        case .sunday:    return NSLocalizedString("Sunday", comment: "DayOfWeek text")
        case .monday:    return NSLocalizedString("Monday", comment: "DayOfWeek text")
        case .tuesday:   return NSLocalizedString("Tuesday", comment: "DayOfWeek text")
        case .wednesday: return NSLocalizedString("Wednesday", comment: "DayOfWeek text")
        case .thursday:  return NSLocalizedString("Thursday", comment: "DayOfWeek text")
        case .friday:    return NSLocalizedString("Friday", comment: "DayOfWeek text")
        case .saturday:  return NSLocalizedString("Saturday", comment: "DayOfWeek text")
        }
    }
}

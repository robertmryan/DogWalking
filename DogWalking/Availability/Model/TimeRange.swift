//
//  TimeRange.swift
//  DogWalking
//
//  Created by Robert Ryan on 5/5/19.
//  Copyright © 2019 Robert Ryan. All rights reserved.
//

import Foundation

struct TimeRange {
    typealias Time = Double

    let startTime: Time
    let endTime: Time
}

extension TimeRange {
    static let allCases: [TimeRange] = [
        TimeRange(startTime: 6, endTime: 9),
        TimeRange(startTime: 9, endTime: 12),
        TimeRange(startTime: 12, endTime: 15),
        TimeRange(startTime: 15, endTime: 18),
        TimeRange(startTime: 18, endTime: 21),
        TimeRange(startTime: 21, endTime: 24),
        TimeRange(startTime: 24, endTime: 30)
    ]

    func overlaps(_ availability: TimeRange) -> Bool {
        return (startTime ..< endTime).overlaps(availability.startTime ..< availability.endTime)
    }
}

extension TimeRange {
    private func string(forHour hour: Int) -> String {
        switch hour % 24 {
        case 0:      return NSLocalizedString("Midnight", comment: "Hour text")
        case 1...11: return "\(hour % 12)" + NSLocalizedString("am", comment: "Hour text")
        case 12:     return NSLocalizedString("Noon", comment: "Hour text")
        default:     return "\(hour % 12)" + NSLocalizedString("pm", comment: "Hour text")
        }
    }

    var text: String {
        return string(forHour: Int(startTime)) + "-" + string(forHour: Int(endTime))
    }
}

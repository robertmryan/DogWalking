//
//  Availability.swift
//  DogWalking
//
//  Created by Robert Ryan on 5/5/19.
//  Copyright © 2019 Robert Ryan. All rights reserved.
//

import Foundation

struct Availability {
    var id: String?
    let dayOfWeek: DayOfWeek
    let timeRange: TimeRange

    init(dayOfWeek: DayOfWeek, timeRange: TimeRange) {
        self.dayOfWeek = dayOfWeek
        self.timeRange = timeRange
    }

    init?(dictionary: [String: Any]) {
        guard
            let dayOfWeekRaw = dictionary["dayOfWeek"] as? DayOfWeek.RawValue,
            let dayOfWeek = DayOfWeek(rawValue: dayOfWeekRaw),
            let startTime = dictionary["startTime"] as? Double,
            let endTime = dictionary["endTime"] as? Double
            else {
                return nil
        }

        self.id = dictionary["id"] as? String
        self.dayOfWeek = dayOfWeek
        self.timeRange = TimeRange(startTime: startTime, endTime: endTime)
    }

    var dictionary: [String: Any] {
        return [
            "dayOfWeek": dayOfWeek.rawValue,
            "startTime": timeRange.startTime,
            "endTime": timeRange.endTime
        ]
    }
}

extension Availability {
    func overlaps(_ availability: Availability) -> Bool {
        return dayOfWeek == availability.dayOfWeek && timeRange.overlaps(availability.timeRange)
    }
}

//
//  AvailabilityViewModel.swift
//  DogWalking
//
//  Created by Robert Ryan on 5/5/19.
//  Copyright © 2019 Robert Ryan. All rights reserved.
//

import Foundation

struct AvailabilityViewModel {
    struct Section {
        let dayOfWeek: DayOfWeek
        let slots: [Availability]
    }

    let sections: [Section]
    var userSelected: [Availability]

    init(userSelected: [Availability] = []) {
        self.userSelected = userSelected
        self.sections = DayOfWeek.allCases.map { dayOfWeek in
            let slots = TimeRange.allCases.map { timeRange in
                Availability(dayOfWeek: dayOfWeek, timeRange: timeRange)
            }
            return Section(dayOfWeek: dayOfWeek, slots: slots)
        }
    }

    func numberOfDays() -> Int {
        return sections.count
    }

    func numberOfSlots(in section: Int) -> Int {
        return sections[section].slots.count
    }

    func text(day: Int) -> String {
        return sections[day].dayOfWeek.text
    }

    func text(day: Int, slot: Int) -> String {
        return sections[day].slots[slot].timeRange.text
    }

    func isSelected(day: Int, slot: Int) -> Bool {
        let availability = sections[day].slots[slot]
        for selected in userSelected where selected.overlaps(availability) {
            return true
        }
        return false
    }

    mutating func setSelected(day: Int, slot: Int, isSelected: Bool) {
        let slot = sections[day].slots[slot]
        if isSelected {
            userSelected.append(slot)
        } else {
            userSelected.removeAll { $0.overlaps(slot) }
        }
    }
}

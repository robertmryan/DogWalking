//
//  AvailabilityViewModel.swift
//  DogWalking
//
//  Created by Robert Ryan on 5/5/19.
//  Copyright © 2019 Robert Ryan. All rights reserved.
//

import Foundation

protocol AvailabilityViewModelDelegate: class {
    func didSelect(at indexPaths: [IndexPath])
    func didDeselect(at indexPaths: [IndexPath])
}

class AvailabilityViewModel {
    struct Section {
        let dayOfWeek: DayOfWeek
        let slots: [Availability]
    }

    var delegate: AvailabilityViewModelDelegate?

    private let sections: [Section]
    private var userSelected: [Availability]
    private var dataStore = DataStoreService.shared

    init(userSelected: [Availability] = [], delegate: AvailabilityViewModelDelegate) {
        self.delegate = delegate
        self.userSelected = userSelected
        self.sections = DayOfWeek.allCases.map { dayOfWeek in
            let slots = TimeRange.allCases.map { timeRange in
                Availability(dayOfWeek: dayOfWeek, timeRange: timeRange)
            }
            return Section(dayOfWeek: dayOfWeek, slots: slots)
        }
        
        addObservers()
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

    func select(day: Int, slot: Int) {
        let availability = sections[day].slots[slot]

        dataStore.save(availability) { result in
            if case .failure(let error) = result {
                print(error)
            }
        }
    }

    func deselect(day: Int, slot: Int) {
        let availability = sections[day].slots[slot]

        let toDelete = userSelected.filter { $0.overlaps(availability) }
        for record in toDelete {
            dataStore.remove(record) { result in
                if case .failure(let error) = result {
                    print(error)
                }
            }
        }
    }
}

private extension AvailabilityViewModel {
    
    /// Add observers
    ///
    /// This will trigger the informing the view controller of records that are added or removed

    func addObservers() {
        dataStore.observeAddition { [weak self] result in
            switch result {
            case .failure (let error):
                print(error)

            case .success(let availability):
                if let paths = self?.indexPaths(for: availability) {
                    self?.userSelected.append(availability)
                    self?.delegate?.didSelect(at: paths)
                }
            }
        }

        dataStore.observeRemoval { [weak self] result in
            switch result {
            case .failure (let error):
                print(error)

            case .success(let availability):
                if let paths = self?.indexPaths(for: availability) {
                    self?.userSelected.removeAll { $0.id == availability.id }
                    self?.delegate?.didDeselect(at: paths)
                }
            }
        }
    }

    /// Identify the appropriate indexpaths for particular availability slot
    ///
    /// - Parameter selectedAvailability: The availability slot to find.
    /// - Returns: The array of `[IndexPath]` corresponding to the availability slot

    func indexPaths(for selectedAvailability: Availability) -> [IndexPath] {
        var indexPaths: [IndexPath] = []
        for (sectionNumber, section) in sections.enumerated() {
            for (row, availability) in section.slots.enumerated() where selectedAvailability.overlaps(availability) {
                indexPaths.append(IndexPath(row: row, section: sectionNumber))
            }
        }
        return indexPaths
    }
}

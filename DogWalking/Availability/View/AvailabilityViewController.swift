//
//  AvailabilityViewController.swift
//  DogWalking
//
//  Created by Robert Ryan on 5/5/19.
//  Copyright © 2019 Robert Ryan. All rights reserved.
//

import UIKit

class AvailabilityViewController: UIViewController {

    var viewModel = AvailabilityViewModel()

}

extension AvailabilityViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfDays()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfSlots(in: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AvailabilityCell", for: indexPath) as! AvailabilityCell
        cell.update(text: viewModel.text(day: indexPath.section, slot: indexPath.row),
                    isSelected: viewModel.isSelected(day: indexPath.section, slot: indexPath.row))
        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.text(day: section)
    }

}

extension AvailabilityViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.setSelected(day: indexPath.section, slot: indexPath.row, isSelected: true)
        if let cell = tableView.cellForRow(at: indexPath) as? AvailabilityCell {
            cell.updateButton()
        }
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        viewModel.setSelected(day: indexPath.section, slot: indexPath.row, isSelected: false)
        if let cell = tableView.cellForRow(at: indexPath) as? AvailabilityCell {
            cell.updateButton()
        }
    }
}

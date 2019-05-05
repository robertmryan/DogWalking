//
//  AvailabilityCell.swift
//  DogWalking
//
//  Created by Robert Ryan on 5/5/19.
//  Copyright © 2019 Robert Ryan. All rights reserved.
//

import UIKit

class AvailabilityCell: UITableViewCell {
    @IBOutlet weak var slotLabel: UILabel!
    @IBOutlet weak var selectedButton: UIButton!

    override var isSelected: Bool { didSet { selectedButton.isSelected = isSelected } }

    override func awakeFromNib() {
        super.awakeFromNib()

        selectedButton.setTitle("◎", for: .normal)
        selectedButton.setTitle("◉", for: .selected)
        selectedButton.adjustsImageWhenHighlighted = false
    }

    func update(text: String, isSelected: Bool) {
        self.isSelected = isSelected
        slotLabel.text = text
        selectedButton.isSelected = isSelected
    }
}

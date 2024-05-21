//
//  CustomTableViewCell.swift
//  gRPC Demo
//
//  Created by omrobbie on 21/05/24.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        nameLabel.text = ""
        priceLabel.text = ""
    }
}

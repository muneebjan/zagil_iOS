//
//  tripFeedCell.swift
//  Zagil
//
//  Created by Apple on 23/01/2020.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class tripFeedCell: UITableViewCell {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var fromLabel: UILabel!
    @IBOutlet weak var toLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var contactButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        self.contactButton.layer.cornerRadius = 5
        // Configure the view for the selected state
    }

    @IBAction func contactHandler(_ sender: Any){
        print("contact button pressed")
    }
    
}

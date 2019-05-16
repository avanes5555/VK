//
//  GroupCell.swift
//  VK
//
//  Created by Иван Пуриков on 12/05/2019.
//  Copyright © 2019 Иван Пуриков. All rights reserved.
//

import UIKit

class GroupCell: UITableViewCell {
    
    static let reuseId = "GroupCell"
    @IBOutlet weak var GroupLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

}

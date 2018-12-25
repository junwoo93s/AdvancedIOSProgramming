//
//  TableViewCell.swift
//  ParkScroll
//
//  Created by Junwoo Seo on 9/29/18.
//  Copyright © 2018 Junwoo Seo. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var ParkImageView: UIImageView!
    @IBOutlet weak var ParkCaptionLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

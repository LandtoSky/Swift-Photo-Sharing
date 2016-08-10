//
//  TblCell.swift
//  artmonious
//
//  Created by Victor on 12/10/1437 AH.
//  Copyright © 1437 AH Victor. All rights reserved.
//

import Foundation
import UIKit

class TblCell: UITableViewCell {
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var txtLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
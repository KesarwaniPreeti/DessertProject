//
//  DessertTableViewCell.swift
//  DessertApp
//
//  Created by Preeti Kesarwani on 12/22/23.
//

import UIKit

class DessertTableViewCell: UITableViewCell {
    
    
    @IBOutlet var dessertImage: UIImageView!
    
    @IBOutlet var dessertName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

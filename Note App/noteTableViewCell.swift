//
//  noteTableViewCell.swift
//  Note App
//
//  Created by Daniel Lavelle on 19/04/2017.
//  Copyright © 2017 Daniel Lavelle. All rights reserved.
//

import UIKit

class noteTableViewCell: UITableViewCell {

    //MARK: Properties
    
    @IBOutlet weak var noteTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

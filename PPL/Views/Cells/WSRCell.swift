//
//  WSRCell.swift
//  PPL
//
//  Created by Chris Boshoff on 2022/09/01.
//

import UIKit

class WSRCell: UITableViewCell {
 
    

    @IBOutlet weak var repsTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var setLabel: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
    
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

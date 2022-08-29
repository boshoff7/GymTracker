//
//  SessionsCell.swift
//  PPL
//
//  Created by Chris Boshoff on 2022/08/29.
//

import UIKit

class SessionsCell: UITableViewCell {

    
    // MARK: - IBOutlets
    @IBOutlet weak var dayLabel         : UILabel!
    @IBOutlet weak var sessionNameLabel : UILabel!
    
    
    // MARK: - Life Cycles
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

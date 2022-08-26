//
//  ExerciseCell.swift
//  PPL
//
//  Created by Chris Boshoff on 2022/08/26.
//

import UIKit

class ExerciseCell: UITableViewCell {

    @IBOutlet weak var nameLabel          : UILabel!
    @IBOutlet weak var setsLabel          : UILabel!
    @IBOutlet weak var repsLabel          : UILabel!
    @IBOutlet weak var restLabel          : UILabel!
    @IBOutlet weak var cellBackgroundImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}

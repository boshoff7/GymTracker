//
//  WSRCell.swift
//  PPL
//
//  Created by Chris Boshoff on 2022/09/01.
//

import UIKit

protocol WSRProtocol {
    func weight(weight: Int16)
}

class WSRCell: UITableViewCell {

    @IBOutlet weak var repsTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var setLabel: UILabel!

    var delegate: WSRProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
        delegate?.weight(weight: Int16(weightTextField.text!)!)
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//
//  LegoTableViewCell.swift
//  legoJI
//
//  Created by prk on 29/04/23.
//

import UIKit

class LegoTableViewCell: UITableViewCell {

    @IBOutlet var nameTxt: UITextField!
    
    @IBOutlet var priceTxt: UITextField!
    
    var updateHandler = {
        
    }
    
    @IBAction func updateBtn(_ sender: Any) {
        updateHandler()
    }
    
    
    @IBAction func deleteBtn(_ sender: Any) {
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

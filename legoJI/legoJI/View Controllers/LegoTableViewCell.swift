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
    
    @IBOutlet var descTxt: UITextField!
    
    var updateHandler = {
        
    }
    
    var deleteHandler = {
        
    }
    
    @IBAction func updateBtn(_ sender: Any) {
        updateHandler()
    }
    
    
    @IBAction func deleteBtn(_ sender: Any) {
        deleteHandler()
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

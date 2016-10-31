//
//  TableViewCell.swift
//  uProfileTask
//
//  Created by Ganesh on 8/30/16.
//  Copyright © 2016 Ganesh. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    
    @IBOutlet var detailType: UILabel!
    
    @IBOutlet var textField: UITextField!
    @IBOutlet var editButton: UIButton!
     let limitLength = 10
    
    
    
    @IBAction func buttonClicked(sender: UIButton) {
        textField.userInteractionEnabled = true
        textField.becomeFirstResponder()
        textField.tintColor = UIColor.redColor()

    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    
    
    
    
}




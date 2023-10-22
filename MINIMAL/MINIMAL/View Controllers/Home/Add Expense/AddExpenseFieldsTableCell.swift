//
//  addExpenseFieldsTableCell.swift
//  MINIMAL
//
//  Created by Shiva Raj on 10/13/23.
//

import UIKit

class AddExpenseFieldsTableCell: UITableViewCell {

    @IBOutlet weak var fieldTitle: UILabel!
    @IBOutlet weak var fieldValue: UILabel!
    @IBOutlet weak var fieldImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

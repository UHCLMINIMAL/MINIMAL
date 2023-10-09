//
//  ExpenseTableViewCell.swift
//  MINIMAL
//
//  Created by Shiva Raj on 10/7/23.
//

import UIKit

class ExpenseTableViewCell: UITableViewCell {
    
    @IBOutlet weak var expenseImgaeView: UIImageView!
    @IBOutlet weak var expenseTitle: UILabel!
    @IBOutlet weak var expenseSubTitle: UILabel!
    @IBOutlet weak var expenseAmount: UILabel!
    @IBOutlet weak var expenseDate: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

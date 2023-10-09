//
//  AddExpenseVC.swift
//  MINIMAL
//
//  Created by Shiva Raj on 10/1/23.
//

import UIKit

class AddExpensePageVC: UIViewController {

    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var expenseAmount: UITextField!
    @IBOutlet weak var paymentTypeControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setpaymentTypeControlUI()

        // Do any additional setup after loading the view.
    }
    
    private func setpaymentTypeControlUI() {
        
        // Customize the text attributes for the normal state (unselected)
        let normalTextAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16), // Change the font
            NSAttributedString.Key.foregroundColor: UIColor.black // Change the text color
        ]
        
        paymentTypeControl.setTitleTextAttributes(normalTextAttributes, for: .normal)

        // Customize the text attributes for the selected state
        let selectedTextAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16), // Change the font
            NSAttributedString.Key.foregroundColor: UIColor.white // Change the text color
        ]
        
        paymentTypeControl.setTitleTextAttributes(selectedTextAttributes, for: .selected)
    }
    

    @IBAction func closeButtonTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}

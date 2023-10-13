//
//  AddExpenseVC.swift
//  MINIMAL
//
//  Created by Shiva Raj on 10/1/23.
//

import UIKit

class AddExpensePageVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var expenseAmount: UITextField!
    @IBOutlet weak var optionsTableView: UITableView!
    @IBOutlet weak var transactionDate: UIDatePicker!
    @IBOutlet weak var paymentTypeControl: UISegmentedControl!
    var optionsList = ["Category", "Transaction Date", "Repeat"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setpaymentTypeControlUI()
        optionsTableView.delegate = self
        optionsTableView.dataSource = self
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return optionsList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let options = optionsList[indexPath.row]
        let optionCell = optionsTableView.dequeueReusableCell(withIdentifier: "addExpenseOptionsCell", for: indexPath)
        
        optionCell.textLabel?.text = options
        optionCell.imageView?.image = UIImage(named: options + ".png")
        
        return optionCell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if optionsList[indexPath.row] == "Transaction Date" {
            let transactionDatePickerView = CustomOverlayPopUpVC()
            transactionDatePickerView.appear(sender: self)
        }
        
        // Deselect the row to remove the highlight
        optionsTableView.deselectRow(at: indexPath, animated: true)
    }
    
}

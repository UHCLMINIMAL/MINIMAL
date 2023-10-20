//
//  AddExpenseVC.swift
//  MINIMAL
//
//  Created by Shiva Raj on 10/1/23.
//

import UIKit

class AddExpensePageVC: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var expenseAmount: UITextField!
    @IBOutlet weak var optionsTableView: UITableView!
    @IBOutlet weak var paymentTypeControl: UISegmentedControl!
    var optionsList:[String] = ["Category", "Transaction Date", "Repeat"]
    var optionsListValues: [String?] = ["","",""]
    let utils = Utils()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setpaymentTypeControlUI()
        optionsTableView.delegate = self
        optionsTableView.dataSource = self
        optionsTableView.register(UINib(nibName: "addExpenseFieldsTableCell", bundle: nil), forCellReuseIdentifier: "addExpenseOptionsCell")
        optionsListValues = ["Category", utils.formattedDate(Date()), "Never"]
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
        let optionCell = optionsTableView.dequeueReusableCell(withIdentifier: "addExpenseOptionsCell", for: indexPath) as! AddExpenseFieldsTableCell
        
        optionCell.fieldTitle.text = options
        optionCell.fieldImageView.image = UIImage(named: options + ".png")
        optionCell.fieldValue.text = optionsListValues[indexPath.row]
        
        return optionCell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if optionsList[indexPath.row] == "Transaction Date" {
            let transactionDatePickerView = CustomOverlayPopUpVC()
            
            // Set up the callback closure to capture the selected date
            transactionDatePickerView.dateSelectedCallback = { [weak self] selectedDate in
                // Handle the selected date in your view controller
                self?.optionsListValues[1] = self?.utils.formattedDate(selectedDate)
                self?.optionsTableView.reloadData()
            }
            
            transactionDatePickerView.appear(sender: self)
        } else if optionsList[indexPath.row] == "Repeat" {
            if let transactionRepeatPeriodVC = storyboard?.instantiateViewController(withIdentifier: "TransactionRepeatPeriodVC") as? TransactionRepeatPeriodVC {
                
                transactionRepeatPeriodVC.dateSelectedCallback = { [weak self] selectedCycle in
                    // Handle the selected date in your view controller
                    self?.optionsListValues[2] = selectedCycle
                    self?.optionsTableView.reloadData()
                    
                }
                
                self.present(transactionRepeatPeriodVC, animated: true, completion: nil)
            }
        }
        
        // Deselect the row to remove the highlight
        optionsTableView.deselectRow(at: indexPath, animated: true)
    }
    
//    func handleSelectedDate(_ date: Date) {
//
//        optionsListValues[1] = utils.formattedDate(date)
//
//        // Reload the table view
//        optionsTableView.reloadData()
//    }
}

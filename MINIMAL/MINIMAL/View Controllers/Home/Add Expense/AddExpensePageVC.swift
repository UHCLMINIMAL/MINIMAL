//
//  AddExpenseVC.swift
//  MINIMAL
//
//  Created by Shiva Raj on 10/1/23.
//

import UIKit

protocol ExpenseAddedDelegate {
    func didSavedExpense()
}

class AddExpensePageVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var expenseAmount: UITextField!
    @IBOutlet weak var optionsTableView: UITableView!
    @IBOutlet weak var paymentTypeControl: UISegmentedControl!
    var optionsList:[String] = ["Title", "Category", "Transaction Date", "Repeat"]
    var optionsListValues: [String?] = ["","","",""]
    let utils = Utils()
    var delegate: ExpenseAddedDelegate? 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setpaymentTypeControlUI()
        optionsTableView.delegate = self
        optionsTableView.dataSource = self
        optionsTableView.register(UINib(nibName: "addExpenseFieldsTableCell", bundle: nil), forCellReuseIdentifier: "addExpenseOptionsCell")
        optionsListValues = [nil,"Category", utils.formattedDate(Date(), format: "MMM dd, yyyy"), "Never"]
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
        
        switch optionsList[indexPath.row] {
        
        case "Transaction Date":
            let transactionDatePickerView = CustomOverlayPopUpVC()
            
            // Set up the callback closure to capture the selected date
            transactionDatePickerView.dateSelectedCallback = { [weak self] selectedDate in
                // Handle the selected date in your view controller
                self?.optionsListValues[2] = self?.utils.formattedDate(selectedDate, format: "MMM dd, yyyy")
                self?.optionsTableView.reloadData()
            }
            
            transactionDatePickerView.appear(sender: self)
            break
            
        case "Repeat":
            if let transactionRepeatPeriodVC = storyboard?.instantiateViewController(withIdentifier: "TransactionRepeatPeriodVC") as? TransactionRepeatPeriodVC {
                
                transactionRepeatPeriodVC.dateSelectedCallback = { [weak self] selectedCycle in
                    // Handle the selected date in your view controller
                    self?.optionsListValues[3] = selectedCycle
                    self?.optionsTableView.reloadData()
                    
                }
                
                self.present(transactionRepeatPeriodVC, animated: true, completion: nil)
            }
            break
            
        case "Title":
            let titleAlertController = UIAlertController(title: "Enter Title for your Expense", message: "Please enter a Value", preferredStyle: .alert)
            
            //adding a text field to the alert controller
            titleAlertController.addTextField { textField in
                textField.placeholder = "Your title here"
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            let saveAction = UIAlertAction(title: "Save", style: .default) { [weak titleAlertController, weak self] _ in
                if let text = titleAlertController?.textFields?.first?.text {
                    self?.optionsListValues[0] = text
                    self?.optionsTableView.reloadData()
                }
            }
            titleAlertController.addAction(cancelAction)
            titleAlertController.addAction(saveAction)
            
            present(titleAlertController,animated: true,completion: nil)
            break
            
        default:
            break
        }
        
        // Deselect the row to remove the highlight
        optionsTableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func addExpenseBtnTapped(_ sender: UIButton) {
        
        // Check if title, amount, and category fields are not empty
        guard let title = optionsListValues[0], !title.isEmpty,
              let category = optionsListValues[1], !category.isEmpty,
              let amountString = expenseAmount.text, !amountString.isEmpty,
              let paymentType = paymentTypeControl.titleForSegment(at: paymentTypeControl.selectedSegmentIndex)
        else {
            // Handle the case where one or more required fields are empty
            let missingFieldsAlert = UIAlertController(title: "Missing Fields", message: "Please fill in all the details", preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            missingFieldsAlert.addAction(cancelAction)
            
            present(missingFieldsAlert,animated: true,completion: nil)
            return
        }
        
        var expenseDateValue: Date = Date()
        
        if let unwrappedDateString = optionsListValues[2] {
            let dateFormat = "MMM dd, yyyy"
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = dateFormat
            
            if let date = dateFormatter.date(from: unwrappedDateString) {
                // Successfully converted the unwrapped date string to a Date
                expenseDateValue = date
            } else {
                print("Unable to convert the date string.")
            }
        } else {
            print("Date string is nil.")
        }
        
        ExpenseDataManadger.saveExpense(
            title: title,
            transactionType: paymentType,
            amount: Float(amountString) ?? 0,
            category: category,
            expenseDate: expenseDateValue) {
                // This code will be executed after the expense is saved
                DispatchQueue.main.async {
                   self.dismiss(animated: true)
                   self.delegate?.didSavedExpense()
               }
            }
    }
}

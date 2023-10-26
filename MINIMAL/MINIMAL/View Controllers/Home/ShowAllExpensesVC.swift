//
//  ShowAllExpenses.swift
//  MINIMAL
//
//  Created by Mohan Surya Kumar Karuturi on 10/24/23.
//

import UIKit

class ShowAllExpensesVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UISheetPresentationControllerDelegate {
    
    @IBOutlet weak var allExpensesTableView: UITableView!
    override var sheetPresentationController: UISheetPresentationController {
        presentationController as! UISheetPresentationController
    }
    var delegate: ExpenseAddedDelegate?
    var recentExpenses: [Expense] = []
    let utils = Utils()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        allExpensesTableView.dataSource = self
        allExpensesTableView.delegate = self
        
        allExpensesTableView.register(UINib(nibName: "ExpenseTableViewCell", bundle: nil), forCellReuseIdentifier: "expenseCell")
        
        // Apply rounded corners to the table view
        allExpensesTableView.layer.cornerRadius = 10
        allExpensesTableView.clipsToBounds = true
        
        sheetPresentationController.delegate = self
        sheetPresentationController.selectedDetentIdentifier = .medium
        sheetPresentationController.prefersGrabberVisible = true
        sheetPresentationController.detents = [
            .medium(),
            .large()
        ]
        
        // Calculate the total height required for all rows
        let totalHeight = CGFloat(recentExpenses.count) * 55 // Assuming a row height of 50
        
        // Set the table view's frame height
        allExpensesTableView.frame.size.height = totalHeight
        
        // Add padding at the top by adjusting the content inset
        let topPadding: CGFloat = 5 // Adjust this value as needed
        allExpensesTableView.contentInset = UIEdgeInsets(top: topPadding, left: 0, bottom: 0, right: 0)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        recentExpenses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let expense = recentExpenses[indexPath.row]
        let expenseCell = allExpensesTableView.dequeueReusableCell(withIdentifier: "expenseCell", for: indexPath) as! ExpenseTableViewCell
        
        expenseCell.expenseTitle.text = expense.title
        expenseCell.expenseSubTitle.text = expense.transactionType
        expenseCell.expenseImgaeView.image = UIImage(named: expense.category ?? "blank")
        expenseCell.expenseAmount.text = String(format: "$%.2f", Double(expense.amount))
        expenseCell.expenseDate.text = utils.formattedDate(expense.expenseDate ?? Date(), format: "MMM dd, yyyy")
        
        return expenseCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteRow = UIContextualAction(style: .destructive, title: "DELETE") { _, _, _ in
            
            ExpenseDataManadger.delete(expense: self.recentExpenses[indexPath.row]) {
                    // This code will be executed after the expense is saved
                    DispatchQueue.main.async {
                       self.dismiss(animated: true)
                       self.delegate?.didSavedExpense()
                   }
            }
           self.allExpensesTableView.deleteRows(at: [indexPath], with: .automatic)
            
        }
        
        let swipe = UISwipeActionsConfiguration(actions: [deleteRow])
        
        return swipe
    }

}

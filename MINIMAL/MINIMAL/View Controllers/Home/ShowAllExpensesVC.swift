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
    var sectionTitles: [Date] = []
    var groupedExpenses: [Date: [Expense]] = [:]
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
        
        // Add padding at the top by adjusting the content inset
//        let topPadding: CGFloat = 5 // Adjust this value as needed
//        allExpensesTableView.contentInset = UIEdgeInsets(top: topPadding, left: 0, bottom: 0, right: 0)
        
        
        for expense in recentExpenses {
            if let date = expense.expenseDate {
                if groupedExpenses[date] == nil {
                    groupedExpenses[date] = [expense]
                } else {
                    groupedExpenses[date]?.append(expense)
                }
            }
        }

        // Sort the dates (section headers) in chronological order
        let sortedDates = groupedExpenses.keys.sorted(by: { $0 < $1 })

        // Assign the sorted dates to your section titles
        sectionTitles = sortedDates
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let date = sectionTitles[section]
        return groupedExpenses[date]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd, yyyy" // Customize the date format as needed
        return dateFormatter.string(from: sectionTitles[section])
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let expenseCell = allExpensesTableView.dequeueReusableCell(withIdentifier: "expenseCell", for: indexPath) as! ExpenseTableViewCell
        let date = sectionTitles[indexPath.section]
        var transactiontype = "Cash"
        if let expensesForDate = groupedExpenses[date] {
            let expense = expensesForDate[indexPath.row]
            transactiontype = expense.transactionType ?? "Cash"
            
            expenseCell.expenseTitle.text = expense.title
            expenseCell.expenseSubTitle.text = transactiontype
            expenseCell.expenseImgaeView.image = UIImage(named: expense.category ?? "blank")
            expenseCell.expenseAmount.text = String(format: "$%.2f", Double(expense.amount))
            expenseCell.expenseDate.text = utils.formattedDate(expense.expenseDate ?? Date(), format: "MMM dd, yyyy")
        }
        
        expenseCell.backgroundColor = UIColor.systemBackground
        if transactiontype == "Card" {
            expenseCell.expenseSubTitle.textColor = UIColor.minimalTheme
        } else {
            expenseCell.expenseSubTitle.textColor = UIColor.systemGreen
        }
        return expenseCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        allExpensesTableView.deselectRow(at: indexPath, animated: true)
        
        let sheet = UIAlertController(title: "Action", message: nil, preferredStyle: .actionSheet)
        sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        sheet.addAction(UIAlertAction(title: "Edit", style: .default, handler: { _ in
            
        }))
        sheet.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: {_ in
            
        }))
        present(sheet, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }

}

//
//  ShowAllExpenses.swift
//  MINIMAL
//
//  Created by Mohan Surya Kumar Karuturi on 10/24/23.
//

import UIKit

class ShowAllExpensesVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var allExpensesTableView: UITableView!
    private var allExpenses = ExpenseDataManadger.fetchAllExpenses()
    let utils = Utils()

    override func viewDidLoad() {
        super.viewDidLoad()
        allExpensesTableView.delegate = self
        allExpensesTableView.dataSource = self
        allExpensesTableView.register(UINib(nibName: "ExpenseTableViewCell", bundle: nil), forCellReuseIdentifier: "expenseCell")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        allExpenses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let expense = allExpenses[indexPath.row]
        let expenseCell = allExpensesTableView.dequeueReusableCell(withIdentifier: "expenseCell", for: indexPath) as! ExpenseTableViewCell
        
        expenseCell.expenseTitle.text = expense.title
        expenseCell.expenseSubTitle.text = expense.transactionType
        expenseCell.expenseImgaeView.image = UIImage(named: expense.category ?? "blank")
        expenseCell.expenseAmount.text = String(format: "$%.2f", Double(expense.amount))
        expenseCell.expenseDate.text = utils.formattedDate(expense.expenseDate ?? Date(), format: "MMM dd, yyyy")
        
        return expenseCell
    }

}

//
//  HomeVC.swift
//  MINIMAL
//
//  Created by Shiva Raj on 10/1/23.
//

import UIKit

class HomePageVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var cardView1: UIView!
    @IBOutlet weak var cardView2: UIView!
    @IBOutlet weak var cardView3: UIView!
    @IBOutlet weak var currentMonthLabel: UILabel!
    @IBOutlet weak var recentExpensesTableView: UITableView!
    
    struct Expense {
        let expenseTitle: String
        let expenseType: String
        let expenseAmount: Float16
        let expenseDate: String
        let expenseImageName: String
    }
    
    let expenseDummyData: [Expense] = [
        Expense(expenseTitle: "Vacation", expenseType: "Cash", expenseAmount: 50, expenseDate: "Sep 30, 2023", expenseImageName: ""),
        Expense(expenseTitle: "Hotel", expenseType: "Credit", expenseAmount: 150, expenseDate: "Sep 10, 2023", expenseImageName: ""),
        Expense(expenseTitle: "Rent", expenseType: "Credit", expenseAmount: 1200, expenseDate: "Sep 03, 2023", expenseImageName: ""),
        Expense(expenseTitle: "Mobile", expenseType: "Credit", expenseAmount: 50, expenseDate: "Sep 30, 2023", expenseImageName: ""),
        Expense(expenseTitle: "Restaurent", expenseType: "Cash", expenseAmount: 76, expenseDate: "Sep 05, 2023", expenseImageName: ""),
        Expense(expenseTitle: "Groceries", expenseType: "Cash", expenseAmount: 82, expenseDate: "Sep 10, 2023", expenseImageName: ""),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Get the current Date
        let currentDate  = Date()
        
        // Create a date formatter to format the current date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM yyyy" // This will display the full month name and year
        
        // Format the current date and set it as the text of the label
        let formattedDate = dateFormatter.string(from: currentDate)
        currentMonthLabel.text = formattedDate
        
        cardView1.layer.cornerRadius = 10
        cardView2.layer.cornerRadius = 10
        cardView3.layer.cornerRadius = 10
        
        recentExpensesTableView.dataSource = self
        recentExpensesTableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let expense = expenseDummyData[indexPath.row]
        let expenseCell = recentExpensesTableView.dequeueReusableCell(withIdentifier: "expenseCell", for: indexPath) as! ExpenseViewCell
        
        expenseCell.expenseTitle.text = expense.expenseTitle
        expenseCell.expenseSubTitle.text = expense.expenseType
        expenseCell.expenseImgaeView.image = UIImage(named: expense.expenseImageName)
        expenseCell.expenseAmount.text = String(format: "$%.2f", Double(expense.expenseAmount))
        expenseCell.expenseDate.text = expense.expenseDate
        
        return expenseCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}

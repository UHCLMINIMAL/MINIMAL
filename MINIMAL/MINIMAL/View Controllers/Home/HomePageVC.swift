//
//  HomeVC.swift
//  MINIMAL
//
//  Created by Shiva Raj on 10/1/23.
//

import UIKit

class HomePageVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var monthlySummary: UIView!
    @IBOutlet weak var recentExpenses: UIView!
    @IBOutlet weak var upcomingExpenses: UIView!
    @IBOutlet weak var paymentTypeSummary: UIView!
    @IBOutlet weak var currentMonthLabel: UILabel!
    @IBOutlet weak var recentExpensesTableView: UITableView!
    
    /*struct Expense {
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
    ]*/
    
    private let addExpenseButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        button.backgroundColor = .systemBlue
        let image = UIImage(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration(pointSize: 32, weight: .medium))
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.setTitleColor(.white, for: .normal)
        
        // Corner Radius
        button.layer.shadowRadius = 10
        button.layer.shadowOpacity = 0.4
        button.layer.cornerRadius = 30
        return button
    }()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return min(0,3)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let allExpenses = ExpenseDataManager.fetchAllExpenses()
        let expense = allExpenses[indexPath.row]
        let expenseCell = recentExpensesTableView.dequeueReusableCell(withIdentifier: "expenseCell", for: indexPath) as! ExpenseTableViewCell
        
        expenseCell.expenseTitle.text = expense.title
        expenseCell.expenseSubTitle.text = expense.transactionType
        expenseCell.expenseImgaeView.image = UIImage(named: expense.category ?? "blank")
        expenseCell.expenseAmount.text = String(format: "$%.2f", Double(expense.amoount))
        expenseCell.expenseDate.text = String(format: "MMM dd, yyyy", expense.expenseDate! as CVarArg)
        
        return expenseCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    @objc private func didTapaddExpenseBtn() {
        let alert = UIAlertController(title: "Add an Expense", message: "Button Tapped", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
    
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
        
        monthlySummary.layer.cornerRadius = 10
        recentExpenses.layer.cornerRadius = 10
        upcomingExpenses.layer.cornerRadius = 10
        paymentTypeSummary.layer.cornerRadius = 10
        
        recentExpensesTableView.dataSource = self
        recentExpensesTableView.delegate = self
        
        recentExpensesTableView.register(UINib(nibName: "ExpenseTableViewCell", bundle: nil), forCellReuseIdentifier: "expenseCell")
        
        view.addSubview(addExpenseButton)
        addExpenseButton.addTarget(self, action: #selector(didTapaddExpenseBtn), for: .touchUpInside)

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addExpenseButton.frame = CGRect(x: view.frame.size.width - 80,
                                        y: view.frame.height - 150,
                                        width: 60,
                                        height: 60)
    }
    
}

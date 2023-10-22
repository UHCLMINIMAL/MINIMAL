//
//  HomeVC.swift
//  MINIMAL
//
//  Created by Shiva Raj on 10/1/23.
//

import UIKit

class HomePageVC: UIViewController, UITableViewDataSource, UITableViewDelegate, ExpenseAddedDelegate {
    
    @IBOutlet weak var monthlySummary: UIView!
    @IBOutlet weak var recentExpenses: UIView!
    @IBOutlet weak var upcomingExpenses: UIView!
    @IBOutlet weak var paymentTypeSummary: UIView!
    @IBOutlet weak var currentMonthLabel: UILabel!
    @IBOutlet weak var recentExpensesTableView: UITableView!
    private var allExpenses = ExpenseDataManadger.fetchAllExpenses()
    
    func didSavedExpense() {
        recentExpensesTableView.reloadData()
    }
    
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
        return min(3,allExpenses.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

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
    
    @objc private func addExpenseBtnTapped() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil) // Replace "Main" with your storyboard name

        if let addExpenseVC = storyboard.instantiateViewController(withIdentifier: "AddExpensePageVC") as? AddExpensePageVC {
            addExpenseVC.delegate = self
            self.present(addExpenseVC, animated: true, completion: nil)
        } else {
            // Handle the case where view controller instantiation fails
            print("Failed to instantiate AddExpensePageVC")
        }
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
        addExpenseButton.addTarget(self, action: #selector(addExpenseBtnTapped), for: .touchDown)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addExpenseButton.frame = CGRect(x: view.frame.size.width - 80,
                                        y: view.frame.height - 150,
                                        width: 60,
                                        height: 60)
    }
    
}

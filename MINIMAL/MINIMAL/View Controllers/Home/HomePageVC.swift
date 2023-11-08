//
//  HomeVC.swift
//  MINIMAL
//
//  Created by Shiva Raj on 10/1/23.
//

import UIKit
import DGCharts

class HomePageVC: UIViewController, UITableViewDataSource, UITableViewDelegate, ExpenseAddedDelegate {
    
    @IBOutlet weak var monthlySummary: UIView!
    @IBOutlet weak var recentExpenses: UIView!
    @IBOutlet weak var upcomingExpenses: UIView!
    @IBOutlet weak var paymentTypeSummary: UIView!
    @IBOutlet weak var currentMonthLabel: UILabel!
    @IBOutlet weak var recentExpensesTableView: UITableView!
    @IBOutlet weak var upComingExpensesTableView: UITableView!
    @IBOutlet weak var paymentTypeTableView: UITableView!
    
    private var allExpenses = ExpenseDataManadger.fetchAllExpenses()
    private var recentExpensesFiltered: [Expense] = []
    private var upComingExpensesFiltered: [Expense] = []
    private var transactionTypeTotals = ExpenseDataManadger.calculateTotalAmountAndCountByTransactionType()
    let currentDate = Date()
    let utils = Utils()
    
    func didSavedExpense() {
        allExpenses = ExpenseDataManadger.fetchAllExpenses()
        transactionTypeTotals = ExpenseDataManadger.calculateTotalAmountAndCountByTransactionType()
        recentExpensesTableView.reloadData()
        upComingExpensesTableView.reloadData()
        paymentTypeTableView.reloadData()
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
        if tableView == recentExpensesTableView {
            recentExpensesFiltered = allExpenses.filter { $0.expenseDate ?? Date() <= currentDate }
            return min(3,recentExpensesFiltered.count)
        }
        if tableView == upComingExpensesTableView {
            upComingExpensesFiltered = allExpenses.filter { $0.expenseDate ?? Date() >= currentDate }
            return min(3,upComingExpensesFiltered.count)
        }
        if tableView == paymentTypeTableView {
            return transactionTypeTotals.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var transactionType = "Card"

        switch tableView {
        case recentExpensesTableView:
            let expense = recentExpensesFiltered[indexPath.row]
            transactionType =  expense.transactionType ?? "Cash"
            let expenseCell = recentExpensesTableView.dequeueReusableCell(withIdentifier: "expenseCell", for: indexPath) as! ExpenseTableViewCell
            
            expenseCell.expenseTitle.text = expense.title
            expenseCell.expenseSubTitle.text = expense.transactionType
            expenseCell.expenseImgaeView.image = UIImage(named: expense.category ?? "blank")
            expenseCell.expenseAmount.text = String(format: "$%.2f", Double(expense.amount))
            expenseCell.expenseDate.text = utils.formattedDate(expense.expenseDate ?? Date(), format: "MMM dd, yyyy")
            
            expenseCell.backgroundColor = UIColor.systemGray5
            if transactionType == "Card" {
                expenseCell.expenseSubTitle.textColor = UIColor.minimalTheme
            } else {
                expenseCell.expenseSubTitle.textColor = UIColor.systemGreen
            }
            
            return expenseCell
            
        case upComingExpensesTableView:
            let expense = upComingExpensesFiltered[indexPath.row]
            transactionType =  expense.transactionType ?? "Cash"
            let expenseCell = upComingExpensesTableView.dequeueReusableCell(withIdentifier: "expenseCell", for: indexPath) as! ExpenseTableViewCell
            
            expenseCell.expenseTitle.text = expense.title
            expenseCell.expenseSubTitle.text = expense.transactionType
            expenseCell.expenseImgaeView.image = UIImage(named: expense.category ?? "blank")
            expenseCell.expenseAmount.text = String(format: "$%.2f", Double(expense.amount))
            expenseCell.expenseDate.text = utils.formattedDate(expense.expenseDate ?? Date(), format: "MMM dd, yyyy")
            
            expenseCell.backgroundColor = UIColor.systemGray5
            if transactionType == "Card" {
                expenseCell.expenseSubTitle.textColor = UIColor.minimalTheme
            } else {
                expenseCell.expenseSubTitle.textColor = UIColor.systemGreen
            }
            
            return expenseCell
            
        case paymentTypeTableView:
            
            // Assuming you have an array of transaction types
            let transactionTypes = Array(transactionTypeTotals.keys)
            let transactionType = transactionTypes[indexPath.row]
            let totalAmount = transactionTypeTotals[transactionType]?.totalAmount ?? 0.0
            let count = transactionTypeTotals[transactionType]?.count ?? 0
            
            
            let expenseCell = paymentTypeTableView.dequeueReusableCell(withIdentifier: "expenseCell", for: indexPath) as! ExpenseTableViewCell
            
            expenseCell.expenseTitle.text = transactionType
            expenseCell.expenseSubTitle.text = "\(count) Transactions"
            if transactionType == "Cash" {
                expenseCell.expenseImgaeView.image = UIImage(systemName: "dollarsign.circle")
            } else if transactionType == "Card" {
                expenseCell.expenseImgaeView.image = UIImage(systemName: "creditcard.circle")
            } else {
                expenseCell.expenseImgaeView.image = UIImage(systemName: "questionmark.circle")
            }
            expenseCell.expenseAmount.text = String(format: "$%.2f", totalAmount)
            expenseCell.expenseDate.text = utils.formattedDate(Date(), format: "MMMM, yyyy")
            
            expenseCell.backgroundColor = UIColor.systemGray5
            if transactionType == "Card" {
                expenseCell.expenseSubTitle.textColor = UIColor.minimalTheme
            } else {
                expenseCell.expenseSubTitle.textColor = UIColor.systemGreen
            }
            
            return expenseCell
            
        default:
            return UITableViewCell()
        }
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
    
    @IBAction func seeAllRecentExpensesTapped(_ sender: Any) {
        if let showAllExpensesVC = storyboard?.instantiateViewController(withIdentifier: "ShowAllExpensesVC") as? ShowAllExpensesVC {
            
            showAllExpensesVC.recentExpenses = recentExpensesFiltered
            self.present(showAllExpensesVC, animated: true, completion: nil)
        }
    }
    
    @IBAction func sellAllupComingExpensesTapped(_ sender: Any) {
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
        
        upComingExpensesTableView.dataSource = self
        upComingExpensesTableView.delegate = self
        
        paymentTypeTableView.dataSource = self
        paymentTypeTableView.delegate = self
        
        recentExpensesTableView.register(UINib(nibName: "ExpenseTableViewCell", bundle: nil), forCellReuseIdentifier: "expenseCell")
        upComingExpensesTableView.register(UINib(nibName: "ExpenseTableViewCell", bundle: nil), forCellReuseIdentifier: "expenseCell")
        paymentTypeTableView.register(UINib(nibName: "ExpenseTableViewCell", bundle: nil), forCellReuseIdentifier: "expenseCell")
        
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

//
//  BGTPlanVC.swift
//  MINIMAL
//
//  Created by Tahoor Ahmed Mohammed on 11/28/23.
//

import UIKit

class BGTPlanVC: UIViewController {

    var selectedMonth: Date?

    @IBOutlet weak var bgtSetupLabel: UILabel!
    @IBOutlet weak var bgtDistributeLabel: UIButton!
    
    @IBOutlet weak var bgtSetupView: UIView!
    @IBOutlet weak var bgtDistributeView: UIView!
    
    @IBOutlet weak var bgtValue: UITextField!
    @IBOutlet weak var saveBgtBtn: UIButton!
    @IBOutlet weak var editBgtBtn: UIButton!
    
    @IBOutlet weak var budgetPlanActivityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        saveBgtBtn.addTarget(self, action: #selector(saveBudget), for: .touchUpInside)
        editBgtBtn.addTarget(self, action: #selector(editBudgetAmount), for: .touchUpInside)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    func setupBudgetPlan(month: Date) {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month], from: month)
        let year = components.year
        let month = components.month
        let yearString = String(format: "%04d", year!)
        let monthString = String(format: "%02d", month!)
        
        let selectedMonth = Int("\(monthString)\(yearString.suffix(2))")
        
        if let budget: Budget = BudgetCRUD.getBudget(period: selectedMonth!) {
            setupPlanView(budgetAmount: budget.budgetAmount)
        } else {
            setupPlanView(budgetAmount: 10.0)
        }
        
    }
    
    func setupPlanView(budgetAmount: Float) {
            if budgetAmount == 0.0 {
                bgtSetupLabel?.isHidden = false
                bgtValue.isUserInteractionEnabled = true
                bgtValue.backgroundColor = .white
                saveBgtBtn.isEnabled = true
            } else {
//            bgtValue.text = String(budgetAmount)
//            bgtSetupLabel.isHidden = true
//            bgtValue.isUserInteractionEnabled = false
//            bgtValue.backgroundColor = .systemGray6
//            saveBgtBtn.isEnabled = false
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    @objc func saveBudget() {
        if let amount: Int = Int(bgtValue.text!) {
            saveBgtBtn.isEnabled = false // Hide the closeKeyboardButton
            bgtValue.resignFirstResponder() // Dismiss the keyboard
            bgtValue.isUserInteractionEnabled = false
            bgtValue.backgroundColor = .systemGray6
            bgtSetupLabel.isHidden = true
        } else {
            let alert = UIAlertController(title: "Empty Budget Amount", message: "The budget amount cannot be empty. Please enter a value.", preferredStyle: .alert)
    
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }

    @objc func editBudgetAmount() {
        // Show numpad keyboard
        print("edit clicked")
        bgtValue.keyboardType = .numberPad
        bgtValue.isUserInteractionEnabled = true
        bgtValue.becomeFirstResponder()
        saveBgtBtn.isEnabled = true
    }

}

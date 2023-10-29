//
//  BudgetPageVC.swift
//  MINIMAL
//
//  Created by Shiva Raj on 10/1/23.
//

import UIKit
import MonthYearWheelPicker
import XCTest

class BudgetPageVC: UIViewController {

    @IBOutlet weak var budgetViewContainer: UIView!
    @IBOutlet weak var budgetMonthPickerText: UIButton!
    
    var selectedMonth: Date = Date()
    var budgetViews: [UIView]!
    var monthYearWheelPicker: MonthYearWheelPicker!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        budgetViews = [UIView]()
        budgetViews.append(BudgetPlanVC().view)
        budgetViews.append(BudgetAnalysisVC().view)
        
        
        for view in budgetViews {
            budgetViewContainer.addSubview(view)
        }
        
        budgetViewContainer.bringSubviewToFront(budgetViews[0])
                
        //setting the Current Date for budget Month
        setBudgetMonth()
    }
    
        
    @IBAction func budgetSegmentControl(_ sender: UISegmentedControl) {
        self.budgetViewContainer.bringSubviewToFront(budgetViews[sender.selectedSegmentIndex])
    }
    
    @IBAction func budgetMonthPicker(_ sender: Any) {
        performSegue(withIdentifier: "budgetMonthPickerSegue", sender: self)
    }
    
    //small functions
    func setBudgetMonth() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM, yyyy"
        self.budgetMonthPickerText.setTitle(dateFormatter.string(from: self.selectedMonth) + " \u{25BC}.", for: .normal)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "budgetMonthPickerSegue" {
            if let monthPickerVC = segue.destination as? BudgetMonthPickerVC {
                monthPickerVC.selectedMonth = self.selectedMonth
            }
        }
    }
    
}

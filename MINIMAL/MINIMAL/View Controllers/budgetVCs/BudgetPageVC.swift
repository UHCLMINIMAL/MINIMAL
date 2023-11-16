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
    @IBOutlet weak var budgetMonthText: UILabel!
    
    var selectedMonth: Date = Date()
    var budgetViews: [UIView]!
    
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
    
   
    //small functions
    func setBudgetMonth() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM, yyyy"
        self.budgetMonthText.text = dateFormatter.string(from: self.selectedMonth)
    }
    
    @IBAction func budgetMonthPicker(_ sender: Any) {
        performSegue(withIdentifier: "budgetMonthPickerSegue", sender: sender.self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let popoverVC = segue.destination as? BudgetMonthPopoverVC {
            popoverVC.selectedMonth = self.selectedMonth
            popoverVC.didSelectMonth = { selectedDate in
                self.selectedMonth = selectedDate
                self.setBudgetMonth()
            }

        }
    }

}

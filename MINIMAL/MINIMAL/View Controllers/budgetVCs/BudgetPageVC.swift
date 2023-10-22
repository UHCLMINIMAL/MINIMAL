//
//  BudgetPageVC.swift
//  MINIMAL
//
//  Created by Shiva Raj on 10/1/23.
//

import UIKit
import MonthYearWheelPicker

class BudgetPageVC: UIViewController {

    @IBOutlet weak var budgetViewContainer: UIView!
    @IBOutlet weak var budgetMonthPickerText: UIButton!
    
    var budgetViews: [UIView]!
    var monthYearWheelPicker: MonthYearWheelPicker!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        budgetViews = [UIView]()
        budgetViews.append(budgetPlanVC().view)
        budgetViews.append(budgetAnalysisVC().view)
        
        
        for view in budgetViews {
            budgetViewContainer.addSubview(view)
        }
        
        budgetViewContainer.bringSubviewToFront(budgetViews[0])
        
        setBudgetMonthPicker()
        
        //setting the Current Date for budget Month
        setBudgetMonth(date: Date())
    }
    
    
    @IBAction func budgetSegmentControl(_ sender: UISegmentedControl) {
        self.budgetViewContainer.bringSubviewToFront(budgetViews[sender.selectedSegmentIndex])
    }
    
    @IBAction func budgetMonthPicker(_ sender: Any) {
        if monthYearWheelPicker.isHidden {
            monthYearWheelPicker.isHidden = false
        }
        else {
            monthYearWheelPicker.isHidden = true
        }
    }
    
    //small functions
    func setBudgetMonth(date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM, yyyy"
        self.budgetMonthPickerText.setTitle(dateFormatter.string(from: date) + " \u{25BC}", for: .normal)
    }
    
    func setBudgetMonthPicker() {
        //initializing a Month Picker to select the Budget Month
        monthYearWheelPicker = MonthYearWheelPicker()
        monthYearWheelPicker.center = view.center
        monthYearWheelPicker.minimumDate = Date(timeIntervalSinceReferenceDate: -60 * 60 * 24 * 365) // One year ago.
        view.addSubview(monthYearWheelPicker)
        monthYearWheelPicker.isHidden = true
        monthYearWheelPicker.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        
        //setting up action to store the selected month
        monthYearWheelPicker.addTarget(self, action: #selector(monthYearSelected(_:)), for: .valueChanged)
        
        //code to place the month picker
    }
    
    @objc func monthYearSelected(_ sender: MonthYearWheelPicker) {
        monthYearWheelPicker.isHidden = true
        setBudgetMonth(date: sender.date)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

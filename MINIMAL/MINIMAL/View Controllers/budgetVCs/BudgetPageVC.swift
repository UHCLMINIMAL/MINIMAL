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
    @IBOutlet weak var closeMonthPickerBtn: UIButton!
    @IBOutlet weak var monthPickerView: UIView!
    
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
        
        setBudgetMonthPicker()
        
        //setting the Current Date for budget Month
        setBudgetMonth(date: Date())
    }
    
    @IBAction func closeMonthPickerAction(_ sender: Any) {
        closeMonthPickerBtn.isHidden = true
        monthYearWheelPicker.isHidden = true
        monthPickerView.isHidden = true
    }
    
    @IBAction func budgetSegmentControl(_ sender: UISegmentedControl) {
        self.budgetViewContainer.bringSubviewToFront(budgetViews[sender.selectedSegmentIndex])
    }
    
    @IBAction func budgetMonthPicker(_ sender: Any) {
        if monthYearWheelPicker.isHidden {
            monthPickerView.isHidden = false
            monthYearWheelPicker.isHidden = false
            closeMonthPickerBtn.isHidden = false
        }
        else {
            monthPickerView.isHidden = true
            monthYearWheelPicker.isHidden = true
            closeMonthPickerBtn.isHidden = true
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
        monthYearWheelPicker.center.x = view.center.x
        monthYearWheelPicker.center.y = monthPickerView.center.y
        
//        let closeBtnConstraint = NSLayoutConstraint(item: closeMonthPickerBtn!, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailingMargin, multiplier: 1.0, constant: -20 )
//
//        closeMonthPickerBtn.addConstraint(closeBtnConstraint)
        monthYearWheelPicker.minimumDate = Date(timeIntervalSinceReferenceDate: -60 * 60 * 24 * 365) // One year ago.
        monthYearWheelPicker.isHidden = true
        monthPickerView.isHidden = true
        monthYearWheelPicker.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        view.addSubview(monthYearWheelPicker)
        
        //setting up action to store the selected month
        monthYearWheelPicker.addTarget(self, action: #selector(monthYearSelected(_:)), for: .valueChanged)

    }
    
    @objc func monthYearSelected(_ sender: MonthYearWheelPicker) {
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

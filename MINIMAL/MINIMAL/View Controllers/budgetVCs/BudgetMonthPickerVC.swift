//
//  BudgetMonthPickerVC.swift
//  MINIMAL
//
//  Created by Chintu Chowdary on 10/28/23.
//

import UIKit
import MonthYearWheelPicker

class BudgetMonthPickerVC: UIViewController {

    @IBOutlet weak var closeMonthPickerBtn: UIButton!

    var budgetViews: [UIView]!
    var monthYearWheelPicker: MonthYearWheelPicker!
    var selectedMonth: Date = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBudgetMonthPicker()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func closeMonthPickerAction(_ sender: Any) {
        if let budgetPageVC = presentingViewController as? BudgetPageVC {
            budgetPageVC.selectedMonth = self.selectedMonth
            budgetPageVC.setBudgetMonth()
        }
        dismiss(animated: true, completion: nil)
    }
    
    func setBudgetMonthPicker() {
        //initializing a Month Picker to select the Budget Month
        monthYearWheelPicker = MonthYearWheelPicker()
        monthYearWheelPicker.center = view.center
        closeMonthPickerBtn.frame = CGRect(x: view.center.x, y: monthYearWheelPicker.frame.maxY + 10, width: 100, height: 50)

        
        monthYearWheelPicker.minimumDate = Date(timeIntervalSinceReferenceDate: -60 * 60 * 24 * 365) // One year ago.
        monthYearWheelPicker.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        view.addSubview(monthYearWheelPicker)
        
        //setting up action to store the selected month
        monthYearWheelPicker.addTarget(self, action: #selector(monthYearSelected(_:)), for: .valueChanged)

    }
    
    @objc func monthYearSelected(_ sender: MonthYearWheelPicker) {
        self.selectedMonth = sender.date
    }
}

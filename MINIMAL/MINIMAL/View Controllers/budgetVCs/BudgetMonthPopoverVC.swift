//
//  BudgetMonthPopoverVC.swift
//  MINIMAL
//
//  Created by Chintu Chowdary on 11/15/23.
//

import UIKit
import MonthYearWheelPicker

class BudgetMonthPopoverVC: UIViewController {
    @IBOutlet weak var monthPickerView: UIView!
    var monthYearWheelPicker: MonthYearWheelPicker!
    var selectedMonth: Date?

    override func viewDidLoad() {
        super.viewDidLoad()
        setMonthPicker()
        setBudgetMonth()
    }
    
    func setMonthPicker() {
        monthYearWheelPicker = MonthYearWheelPicker()
        monthYearWheelPicker.center.x = view.center.x
        monthYearWheelPicker.center.y = view.center.y

        monthYearWheelPicker.minimumDate = Date(timeIntervalSinceReferenceDate: -60 * 60 * 24 * 365) // One year ago.
        monthYearWheelPicker.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        view.addSubview(monthYearWheelPicker)
    }
    
    func setBudgetMonth() {
        if let date = selectedMonth {
            self.monthYearWheelPicker.date =  date
        } else {
            self.monthYearWheelPicker.date = Date()
        }
    }

    var didSelectMonth: ((Date) -> Void)?

    @IBAction func closeBudgetMonthPopover(_ sender: Any) {
        didSelectMonth?(self.monthYearWheelPicker.date)
        dismiss(animated: true, completion: nil)
    }
}

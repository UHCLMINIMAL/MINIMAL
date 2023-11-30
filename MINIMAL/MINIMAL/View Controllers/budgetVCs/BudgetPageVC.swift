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
    @IBOutlet weak var budgetSegmentControl: UISegmentedControl!

    var activityIndicator: UIActivityIndicatorView!
    var currentViewController: UIViewController?

    lazy var bgtPlanVC: UIViewController? = {
        let bgtPlanVC = self.storyboard?.instantiateViewController(withIdentifier: "BGTPlanVC")
        return bgtPlanVC
    }()
    
    lazy var bgtAnalysisVC : UIViewController? = {
        let bgtAnalysisVC = self.storyboard?.instantiateViewController(withIdentifier: "BGTAnalysisVC")
        return bgtAnalysisVC
    }()
    
    var selectedMonth: Date = Date()
    override func viewDidLoad() {
        super.viewDidLoad()
        displayCurrentTab(0)
        setBudgetMonth()
        setActivityIndicator()
        showActivityIndicator(color: "white")
    }
    
    func setActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .black
        activityIndicator.backgroundColor = UIColor.white
        activityIndicator.hidesWhenStopped = true
        activityIndicator.center = view.center
        let bottomOfLabel = budgetMonthText.frame.origin.y + budgetMonthText.frame.size.height + 50
        let bottomOfSuperview = view.frame.size.height
        let height = bottomOfSuperview - bottomOfLabel
        activityIndicator.frame = CGRect(x: 0, y: bottomOfLabel, width: view.frame.size.width, height: height)
        view.addSubview(activityIndicator)
    }
    
    func showActivityIndicator(color: String = "white") {
        switch color {
        case "white": activityIndicator.backgroundColor = UIColor.white
        case "grey": activityIndicator.backgroundColor = UIColor.systemGray6
        default:
            activityIndicator.backgroundColor = UIColor.white
        }
        activityIndicator.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.hideActivityIndicator()
        }
    }

    func hideActivityIndicator() {
        activityIndicator.stopAnimating()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let currentViewController = currentViewController {
            currentViewController.viewWillDisappear(animated)
        }
    }
        
    @IBAction func budgetSegmentControl(_ sender: UISegmentedControl) {
        showActivityIndicator(color: "white")
        self.currentViewController!.view.removeFromSuperview()
        self.currentViewController!.removeFromParent()
        displayCurrentTab(sender.selectedSegmentIndex)
    }
    
    func displayCurrentTab(_ tabIndex: Int){
        if let vc = viewControllerForSelectedSegmentIndex(tabIndex) {
            
            self.addChild(vc)
            vc.didMove(toParent: self)
            
            vc.view.frame = self.budgetViewContainer.bounds
            self.budgetViewContainer.addSubview(vc.view)
            self.currentViewController = vc
        }
    }
    
    func viewControllerForSelectedSegmentIndex(_ index: Int) -> UIViewController? {
        var vc: UIViewController?
        switch index {
        case 0 :
            vc = bgtPlanVC
        case 1 :
            vc = bgtAnalysisVC
        default:
        return nil
        }
    
        return vc
    }
    
    //small functions
    func setBudgetMonth() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM, yyyy"
        self.budgetMonthText.text = dateFormatter.string(from: self.selectedMonth)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let budgetPlanVC = storyboard.instantiateViewController(withIdentifier: "BGTPlanVC") as? BGTPlanVC {
            budgetPlanVC.setupBudgetPlan(month: self.selectedMonth)
        }
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
                self.showActivityIndicator(color: "white")
            }

        }
    }

}

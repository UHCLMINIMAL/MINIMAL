//
//  transactionRepeatPeriodVC.swift
//  MINIMAL
//
//  Created by Shiva Raj on 10/14/23.
//

import UIKit

class TransactionRepeatPeriodVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UISheetPresentationControllerDelegate {
    
    @IBOutlet weak var transactionPeriodTableView: UITableView!
    var transactionRepeatPeriodList = ["Never", "Daily", "Weekly", "Montly", "Quarterly", "Semi-Annualy", "Yearly"]
    // Callback closure for date selection
    var dateSelectedCallback: ((String) -> Void)?
    override var sheetPresentationController: UISheetPresentationController {
        presentationController as! UISheetPresentationController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        transactionPeriodTableView.delegate = self
        transactionPeriodTableView.dataSource = self
        sheetPresentationController.delegate = self
        sheetPresentationController.selectedDetentIdentifier = .medium
        sheetPresentationController.prefersGrabberVisible = true
        sheetPresentationController.detents = [
            .medium(),
            .large()
        ]

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactionRepeatPeriodList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let transactionRepeatPeriodCell = transactionPeriodTableView.dequeueReusableCell(withIdentifier: "repeatPeriodCell", for: indexPath)
        
        transactionRepeatPeriodCell.textLabel?.text = transactionRepeatPeriodList[indexPath.row]
        
        return transactionRepeatPeriodCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedValue = transactionRepeatPeriodList[indexPath.row]
        // Call the callback closure with the selected date
        dateSelectedCallback?(selectedValue)
        transactionPeriodTableView.reloadData()
        self.dismiss(animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

}

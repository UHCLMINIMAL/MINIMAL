//
//  CustomOverlayPopUpVC.swift
//  MINIMAL
//
//  Created by Shiva Raj on 10/13/23.
//

import UIKit

class CustomOverlayPopUpVC: UIViewController {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var closeOverlayButton: UIButton!
    @IBOutlet weak var saveTransactionDate: UIButton!
    @IBOutlet weak var transactionDatePicker: UIDatePicker!
    
    init() {
        super.init(nibName:"CustomOverlayPopUpVC", bundle: nil)
        self.modalPresentationStyle = .overFullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        
    }
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        hide()
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        hide()
    }
    
    
    func configureView() {
        self.view.backgroundColor = .clear
        self.backView.backgroundColor = .black.withAlphaComponent(0.6)
        self.backView.alpha = 0
        self.contentView.alpha = 0
        self.contentView.layer.cornerRadius = 10
    }
    
    func appear(sender: UIViewController) {
        sender.present(self, animated: false) {
            self.show()
        }
    }
    
    private func show() {
        UIView.animate(withDuration: 0.3, delay: 0.0) {
            self.backView.alpha = 1
            self.contentView.alpha = 1
        }
    }
    
    func hide() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut) {
            self.backView.alpha = 0
            self.backView.alpha = 0
        } completion: { _ in
            self.dismiss(animated: false)
            self.removeFromParent()
        }
    }
}

//
//  NewHomeVC.swift
//  MINIMAL
//
//  Created by Shiva Raj on 11/5/23.
//

import UIKit
import SwiftUI

class NewHomeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let vc = UIHostingController(rootView: NewHomeSiftUIView())
        addChild(vc)
        view.addSubview(vc.view)
        vc.view.frame = view.bounds
        vc.didMove(toParent: self)
        
    }
    

}

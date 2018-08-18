//
//  ViewController.swift
//  AlertBox
//
//  Created by Ankit on 05/08/18.
//  Copyright © 2018 Ankit. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func btnSingleButtonAlertDidClicked(_ sender: Any) {
        let alertView =  AlertBoxView.create().config(title: "Title", message: "This is test message with one button", isSingleButton: true)
        alertView.addAction(AlertAction(title:"OK", type: .normal, handler: {
            print("Code after OK button clicked")
        }))
        
        alertView.show(into: self.view )
    }
    
    @IBAction func btnTwoButtonsAlertDidClicked(_ sender: Any) {
        let alertView =  AlertBoxView.create().config(title: "Title", message: "This is test message with two buttons", isSingleButton: false)
        alertView.addAction(AlertAction(title:"Cancel", type: .cancel, handler: {
            print("Code after cancel button clicked")
        }))
        alertView.addAction(AlertAction(title:"OK", type: .normal, handler: {
            print("Code after OK button clicked")
        }))
        
        alertView.show(into: self.view )
    }
}


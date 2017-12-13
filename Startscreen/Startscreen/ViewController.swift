//
//  ViewController.swift
//  Startscreen
//
//  Created by Mike Beanies on 23/11/2017.
//  Copyright © 2017 Mike Beanies. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var bankButton: UIButton!
    
    @IBOutlet weak var containerView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
         containerView.isUserInteractionEnabled = false
        bankButton.backgroundColor = UIColor.blue
        bankButton.layer.cornerRadius = 19
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

}


//
//  ViewController.swift
//  ResourceGen
//
//  Created by Jrwong on 07/18/2019.
//  Copyright (c) 2019 Jrwong. All rights reserved.
//

import UIKit
import ResourceGen

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        print(RM.FontSize.primary.system())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


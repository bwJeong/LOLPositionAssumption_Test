//
//  ViewController.swift
//  PositionAssumptionTest
//
//  Created by Byungwook Jeong on 2021/08/01.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let manager = CrawlingManager()
        
        manager.championInfo()
    }


}


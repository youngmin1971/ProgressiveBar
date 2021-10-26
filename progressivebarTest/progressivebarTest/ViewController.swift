//
//  ViewController.swift
//  progressivebarTest
//
//  Created by Youngmin Park on 9/29/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var progressbar: SProgressView!
    @IBOutlet var animationOnOff: UISwitch!
    @IBOutlet var rate: UITextField!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func setData() {
        let rate1 = CGFloat(Double(rate.text ?? "0.0") ?? 0.0) / 100.0

        progressbar.setProgress(rate1, animated: animationOnOff.isOn)
    }
}


// This is the test code.. it will be merged?



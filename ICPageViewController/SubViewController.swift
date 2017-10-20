//
//  DemoViewController.swift
//  ICPageViewController
//
//  Created by 陈颜俊 on 2017/10/19.
//  Copyright © 2017年 ChenYanjun. All rights reserved.
//

import UIKit

class SubViewController: UIViewController {
    
    @IBOutlet weak var labelView: UILabel!
    
    var label: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.labelView.text = label
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  ViewController.swift
//  ICPageViewController
//
//  Created by 陈颜俊 on 2017/10/19.
//  Copyright © 2017年 ChenYanjun. All rights reserved.
//

import UIKit

class DemoViewController: UIViewController, ICPageViewControllerDelegate {
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var itemView: UIView!
    @IBOutlet weak var currentLabel: UILabel!
    
    let pageViewController = ICPageViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        pageViewController.pageViewDelegate = self
        self.addChildViewController(pageViewController)
        itemView.addSubview(pageViewController.view)
        pageViewController.didMove(toParentViewController: self)
    }
    
    override func viewDidLayoutSubviews() {
        pageViewController.view.frame = itemView.bounds
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfItems(in pageViewController: ICPageViewController) -> Int {
        return 10
    }
    
    func pageViewController(_ pageViewController: ICPageViewController, viewControllerForItemAt index: Int) -> UIViewController {
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "demoViewController") as? SubViewController
        viewController?.label = "sub viewcontroller \(index)"
        switch index {
        case 0:
            viewController?.view.backgroundColor = .blue
            
        case 1:
            viewController?.view.backgroundColor = .red
            
        case 2:
            viewController?.view.backgroundColor = .gray
            
        default:
            viewController?.view.backgroundColor = .white
        }
        return viewController!
    }
    
    func pageViewController(_ pageViewController: ICPageViewController, willShow viewController: UIViewController, at index: Int) {
        let demoViewController = viewController as! SubViewController
        currentLabel.text = demoViewController.label + "will"
    }
    
    func pageViewController(_ pageViewController: ICPageViewController, didShow viewController: UIViewController, at index: Int) {
        let demoViewController = viewController as! SubViewController
        currentLabel.text = demoViewController.label + "did"
    }
}

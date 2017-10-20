//
//  ICPageViewController.swift
//  ICPageViewController
//
//  Created by 陈颜俊 on 2017/10/19.
//  Copyright © 2017年 ChenYanjun. All rights reserved.
//

import UIKit

@objc protocol ICPageViewControllerDelegate {
    func numberOfItems(in pageViewController: ICPageViewController) -> Int
    func pageViewController(_ pageViewController: ICPageViewController, viewControllerForItemAt index: Int) -> UIViewController
    @objc optional func pageViewController(_ pageViewController: ICPageViewController, willShow viewController: UIViewController, at index: Int) -> Void
    @objc optional func pageViewController(_ pageViewController: ICPageViewController, didShow viewController: UIViewController, at index: Int) -> Void
}

class ICPageViewController: UIViewController {
    
    var containerView: UICollectionView!
    weak var pageViewDelegate: ICPageViewControllerDelegate?
    var viewControllersCache: [Int: UIViewController] = [:]
    
    convenience init(delegate: ICPageViewControllerDelegate) {
        self.init()
        self.pageViewDelegate = delegate
    }
    
    deinit {
        viewControllersCache.removeAll()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = self.view.bounds.size
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0
        containerView = UICollectionView(frame: self.view.bounds, collectionViewLayout: flowLayout)
        containerView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "subViewController")
        containerView.isPagingEnabled = true
        containerView.showsHorizontalScrollIndicator = false
        
        self.view = containerView
        
        containerView.dataSource = self
        containerView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ICPageViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pageViewDelegate?.numberOfItems(in: self) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "subViewController", for: indexPath)
        
        var viewController = viewControllersCache[indexPath.row]
        if viewController == nil {
            viewController = pageViewDelegate?.pageViewController(self, viewControllerForItemAt: indexPath.row)
            viewControllersCache[indexPath.row] = viewController
        }
        
        viewController!.view.frame = cell.contentView.bounds
        self.addChildViewController(viewController!)
        cell.contentView.addSubview(viewController!.view)
        viewController!.didMove(toParentViewController: self)
        
        return cell
    }
}

extension ICPageViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let viewController = viewControllersCache[indexPath.row] else {
            return
        }
        pageViewDelegate?.pageViewController?(self, willShow: viewController, at: indexPath.row)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard scrollView == containerView else {
            return
        }
        
        guard let currentIndexPath = containerView.indexPathsForVisibleItems.first else {
            return
        }
        
        guard let viewController = viewControllersCache[currentIndexPath.row] else {
            return
        }
        
        pageViewDelegate?.pageViewController?(self, didShow: viewController, at: currentIndexPath.row)
    }
}

extension ICPageViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.view.bounds.size
    }
}

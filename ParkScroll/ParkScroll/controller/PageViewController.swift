//
//  PageViewController.swift
//  ParkScroll
//
//  Created by Junwoo Seo on 10/8/18.
//  Copyright © 2018 Junwoo Seo. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {

    
    
    let controlPosition = CGRect(x: 0, y: UIScreen.main.bounds.height - (UIScreen.main.bounds.height / 4), width: UIScreen.main.bounds.width, height: 30)
    var pageControl = UIPageControl()
    var splitStoryboard = UIStoryboard(name: "SplitView", bundle: nil)
    lazy var viewControllerArray: [UIViewController] = {
        return [ splitStoryboard.instantiateViewController(withIdentifier: "first"),
                 splitStoryboard.instantiateViewController(withIdentifier: "second"),
                 splitStoryboard.instantiateViewController(withIdentifier: "third")
               ]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.dataSource = self
        self.delegate = self
        if let firstViewController = viewControllerArray.first {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
        pageControl = UIPageControl(frame: controlPosition)
        pageControl.numberOfPages = viewControllerArray.count
        pageControl.currentPage = 0
        self.view.addSubview(pageControl)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let pageIndex = viewControllerArray.index(of: viewController)
        let prevIndex = pageIndex! - 1
        if prevIndex < 0 {
            return nil
        }
        return viewControllerArray[prevIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let pageIndex = viewControllerArray.index(of: viewController)
        let nextIndex = pageIndex! + 1
        if viewControllerArray.count <= nextIndex {
            return nil
        }
        return viewControllerArray[nextIndex]
    }

    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        pageControl.currentPage = viewControllerArray.index(of: pageViewController.viewControllers![0])!
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

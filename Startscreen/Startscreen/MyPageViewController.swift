//
//  MyPageViewController.swift
//  Startscreen
//
//  Created by Mike Beanies on 27/11/2017.
//  Copyright © 2017 Mike Beanies. All rights reserved.
//

import UIKit

class MyPageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    var pageControl = UIPageControl()
    var timer: Timer!
    var updateCounter: Int!
    
    
    lazy var orderedViewControllers: [UIViewController] = {
        return [self.newVc(viewController: "page1"),
                self.newVc(viewController: "page2"),
                self.newVc(viewController: "page3")]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self
        
        updateCounter = 0
        
        // This sets up the first view that will show up on our page control
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
        
        startTimer()
        
        configurePageControl()
        
        // Do any additional setup after loading the view.
    }
    
    @objc func updateTimer() {
        if(updateCounter > 1) {
            updateCounter = 0
            pageControl.currentPage = updateCounter
            setViewControllers([orderedViewControllers[updateCounter]],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        } else {
            updateCounter = updateCounter + 1
            pageControl.currentPage = updateCounter
            setViewControllers([orderedViewControllers[updateCounter]],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
    }
    
    func configurePageControl() {
        // Create a page control
        pageControl = UIPageControl(frame: CGRect(x: 0,y: 360,width: UIScreen.main.bounds.width,height: 50))
        self.pageControl.isUserInteractionEnabled = false
        self.pageControl.numberOfPages = orderedViewControllers.count
        self.pageControl.currentPage = 0
        self.pageControl.tintColor = UIColor.black
        self.pageControl.pageIndicatorTintColor = UIColor.lightGray
        self.pageControl.currentPageIndicatorTintColor = UIColor.black
        self.view.addSubview(pageControl)
    }
    
    func newVc(viewController: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: viewController)
    }
    
    // let the user switch between the pages
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let pageContentViewController = pageViewController.viewControllers![0]
        self.pageControl.currentPage = orderedViewControllers.index(of: pageContentViewController)!
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        // User is on the first view controller and swiped left to loop to
        // the last view controller.
        guard previousIndex >= 0 else {
            return orderedViewControllers.last
            // Uncommment the line below, remove the line above if you don't want the page control to loop.
            // return nil
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        
        // User is on the last view controller and swiped right to loop to
        // the first view controller.
        guard orderedViewControllersCount != nextIndex else {
            return orderedViewControllers.first
            // Uncommment the line below, remove the line above if you don't want the page control to loop.
            // return nil
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        //zoek uit hoe ik dit moet berekenen!!!!!!!!
//        if (nextIndex == 1) { updateCounter = 0 } else { updateCounter = 1 }
//        restartTimer()
        
        return orderedViewControllers[nextIndex]
    }
    
    // Timer functions
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 6.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    func stopTimer() {
        timer.invalidate()
    }
    
    func restartTimer() {
        stopTimer()
        startTimer()
    }
    
    // old code
    /* var pages = [UIViewController]()
    var View = ViewController()
    var currentIndex: Int?
    var pendingIndex: Int?
    var pageControl = UIPageControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.dataSource = self
        setupPageControl()
                
        let page1: UIViewController! = storyboard?.instantiateViewController(withIdentifier: "page1")
        let page2: UIViewController! = storyboard?.instantiateViewController(withIdentifier: "page2")
        
        pages.append(page1)
        pages.append(page2)
        
        setViewControllers([pages[0]], direction: .forward, animated: false, completion: nil)
        
        
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pages.count
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let currentIndex:Int = pages.index(of: viewController) ?? 0
        if (currentIndex <= 0) {
            return nil
        }
        //View.changePage(value: currentIndex-1)
        return pages[currentIndex-1]
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let currentIndex:Int = pages.index(of: viewController) ?? 0
        if (currentIndex >= pages.count-1) {
            return nil
        }
        //View.changePage(value: currentIndex+1)
        return pages[currentIndex+1]
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    private func setupPageControl() {
//        let appearance = UIPageControl.appearance()
//        appearance.pageIndicatorTintColor = UIColor.gray
//        appearance.currentPageIndicatorTintColor = UIColor.darkGray
//        appearance.backgroundColor = UIColor.white
        
        pageControl = UIPageControl(frame: CGRect(x: 0,y: UIScreen.main.bounds.maxY - 50,width: UIScreen.main.bounds.width,height: 50))
        self.pageControl.numberOfPages = pages.count
        self.pageControl.currentPage = 0
        self.pageControl.tintColor = UIColor.black
        self.pageControl.pageIndicatorTintColor = UIColor.white
        self.pageControl.currentPageIndicatorTintColor = UIColor.black
        self.view.addSubview(pageControl)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let pageContentViewController = pageViewController.viewControllers![0]
        self.pageControl.currentPage = pages.index(of: pageContentViewController)!
    } */
    // old code - end

}

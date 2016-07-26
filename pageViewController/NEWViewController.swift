//
//  NEWViewController.swift
//  pageViewController
//
//  Created by Grandre on 16/6/25.
//  Copyright © 2016年 革码者. All rights reserved.
//

import UIKit

class ViewController1: UIViewController,UIPageViewControllerDataSource,UIPageViewControllerDelegate {
    var pageController:UIPageViewController!
    var viewControllers = NSMutableArray()
    var pageIndicator:UIPageControl!
    var timer:NSTimer!
    var flag:Bool = false
    override func viewDidLoad() {
    super.viewDidLoad()
        self.view.backgroundColor = UIColor.brownColor()
       
        self.pageController = UIPageViewController(transitionStyle: .Scroll, navigationOrientation:.Horizontal, options: [UIPageViewControllerOptionSpineLocationKey:NSNumber(float: 10)])
        self.pageController.delegate = self
        self.pageController.dataSource = self
        
//如果采用pageViewcontroller自带的pagecontroller的话，可以这样去配置，但目前没有找到自定义pagecontroller位置的配置。
//如果想自定义pagecontroller的位置，可以采用新建一个pageController。
//        let pageControl = UIPageControl.appearance()
//        pageControl.pageIndicatorTintColor = UIColor ( red: 0.774, green: 1.0, blue: 0.9541, alpha: 1.0 )
//        pageControl.currentPageIndicatorTintColor = UIColor ( red: 0.511, green: 0.3973, blue: 0.7333, alpha: 1.0 )
//        pageControl.backgroundColor = UIColor ( red: 0.9777, green: 1.0, blue: 0.4295, alpha: 1.0 )
//        pageControl.frame = CGRectMake(100, 400, 300, 30)
        for index in 0...9 {
        
            let pViewController = PageViewController(text: "第\(index)页",index: index)
   
            viewControllers.addObject(pViewController)
     
        }
        //展示之前进行初始化第一个Controller, 单个显示放一个,两个显示则放两个,和样式有关
        self.pageController.setViewControllers([viewControllers.objectAtIndex(0) as! UIViewController], direction: .Forward, animated: false) { (b:Bool) -> Void in
            
        }
        
        self.pageIndicator = UIPageControl(frame: CGRectMake(50, self.view.frame.height-30, 300, 30))
        self.pageIndicator.pageIndicatorTintColor = UIColor ( red: 1.0, green: 0.4159, blue: 0.4646, alpha: 1.0 )
        self.pageIndicator.currentPageIndicatorTintColor = UIColor ( red: 0.511, green: 0.3973, blue: 0.7333, alpha: 1.0 )
        self.pageIndicator.backgroundColor = UIColor.clearColor()
        self.pageIndicator.currentPage = 0
        self.pageIndicator.numberOfPages = self.viewControllers.count
        self.pageIndicator.addTarget(self, action: #selector(self.pageIndicatorValueChange), forControlEvents: .ValueChanged)
     
        self.addChildViewController(pageController)

        self.view.addSubview(pageController.view)
        self.view.addSubview(self.pageIndicator)
       
        self.timerSet()
//        self.timer.fire() //立即触发，也是代码触发
    }
    func timerSet(){
        self.timer = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: #selector(self.timerAction), userInfo: nil, repeats: true)
    }
    func timerAction() -> Void {
        print("----timer ----")
        if self.pageIndicator.currentPage == self.viewControllers.count - 1{
            self.pageIndicator.currentPage = 0
        }else{
            self.pageIndicator.currentPage += 1
        }

        self.pageIndicatorValueChange()
    }
    
 
    func pageIndicatorValueChange() -> Void {
        let n = self.pageIndicator.currentPage
        let n原来的index = (self.pageController.viewControllers?.first as! PageViewController).index
        let direction:UIPageViewControllerNavigationDirection!
        if n < n原来的index{
            direction = UIPageViewControllerNavigationDirection.Reverse
        }else{
            direction = UIPageViewControllerNavigationDirection.Forward
        }
       
        self.pageController.setViewControllers([self.viewControllers[n] as! PageViewController], direction: direction, animated: true, completion: nil)
        
        self.timer.invalidate()
        self.timerSet()
        
    }
    //------------Delegate--------------
  
    func pageViewController(pageViewController: UIPageViewController, willTransitionToViewControllers pendingViewControllers: [UIViewController]){
        
    }
  
    func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool){
        if finished{
            print("----滑动结束,但不一定翻页")
            self.pageIndicator.currentPage = (pageViewController.viewControllers?.first as! PageViewController).index
            
            self.timer.invalidate()
            self.timerSet()
            
//如果不用self.timer.invalidate()去删除原来的定时器，而用暂停，启动的方法，有一个问题是，当重新启动定时器时会立马执行一次seclector。 
//            self.flag = !self.flag
//            if self.flag{
//                print("--1--")
//                self.timer.fireDate = NSDate.distantFuture()//暂停定时器
//            }else{
//                print("--2--")
////                self.timer.fireDate = NSDate.distantPast()//启动定时器，会立马执行以下selector
//                self.timer.fireDate = NSDate()//也是启动定时器，会立马执行以下selector
//            }
            
        }
    }
 
    func pageViewController(pageViewController: UIPageViewController, spineLocationForInterfaceOrientation orientation: UIInterfaceOrientation) -> UIPageViewControllerSpineLocation {
       
        return .Min
       
    }
 
//    func pageViewControllerSupportedInterfaceOrientations(pageViewController: UIPageViewController) -> Int {
//      
//        return 2
//       
//    }

    func pageViewControllerPreferredInterfaceOrientationForPresentation(pageViewController: UIPageViewController) -> UIInterfaceOrientation {
     
        return .Portrait
       
    }
    
    
  
    //-------------DataSource-----------------
// //////特别特别注意！！！
//    第一次滑动时，不管是向左还是向右划，刚开始滑动时下面两个方法都是同时执行，先确定好前后的控制器，然后如果滑动距离足以翻页，还会执行一次对应方向的方法，所以一定要注意！
//    在第二次滑动时，只会执行对应方向的方法
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {

        var n = (viewController as! PageViewController).index
        print("-----1---\(n)")
        if n - 1 < 0 {
            return nil
        }else{
            n -= 1
        }
        
        return viewControllers[n] as? PageViewController
        
    }
 
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {

        var n = (viewController as! PageViewController).index
        print("-----2---\(n)")
        if n + 1 > 9 {
            return nil
        }else{
            n += 1
        }
        
        return viewControllers[n] as? PageViewController
     
    }

//    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
//        
//        return self.viewControllers.count
//        
//    }
////这个是返回页面指示器当前的页码
//    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
//
//        return (pageViewController.viewControllers![0] as! PageViewController).index
//        
//    }
// 
}
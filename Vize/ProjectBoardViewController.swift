//
//  ProjectBoardViewController.swift
//  Vize
//
//  Created by Nicki on 1/2/16.
//  Copyright © 2016 shortkey. All rights reserved.
//

import UIKit

class ProjectBoardViewController: UIViewController, UIPageViewControllerDataSource {
     private var pageViewController: UIPageViewController?
    
    var projectTaskList: [String] = []
    var prepTasks: [String]?
    var progressTasks: [String]?
    var tasksToComplete: [String]?
    var doneTasks: [String]?
    var projectLabelList: [String] = ["Project Preparation", "Tasks in Progress", "Tasks To Complete", "Done"]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        createPageViewController()
        setupPageControl()
    }
    
    private func createPageViewController() {
        
        let pageController = self.storyboard!.instantiateViewControllerWithIdentifier("PageController") as! UIPageViewController
        pageController.dataSource = self
        if prepTasks != nil && prepTasks?.count > 0{
            projectTaskList = prepTasks!
        }
        
        if projectLabelList.count > 0 {
            let firstController = viewControllerAtIndex(0)
            let startingViewControllers: [UIViewController] = [firstController]
            pageController.setViewControllers(startingViewControllers, direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
        }
        pageController.view!.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 50)
        
        pageViewController = pageController
        addChildViewController(pageViewController!)
        self.view.addSubview(pageViewController!.view)
        pageViewController!.didMoveToParentViewController(self)
    }
    
    private func setupPageControl() {
        let appearance = UIPageControl.appearance()
        appearance.pageIndicatorTintColor = UIColor.grayColor()
        appearance.currentPageIndicatorTintColor = UIColor.blackColor()
        appearance.backgroundColor = UIColor.clearColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
    func viewControllerAtIndex(index: Int) -> ContentViewController{
        let vc: ContentViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ContentViewController") as! ContentViewController
        vc.labelText = self.projectLabelList[index] as String
        
        switch vc.labelText{
            case "Project Preparation": projectTaskList = prepTasks!
            case "Tasks in Progress" : projectTaskList = progressTasks!
            case "Tasks To Complete": projectTaskList = tasksToComplete!
            case "Done": projectTaskList = doneTasks!
            default: projectTaskList = []
            
        }
        
        vc.selectedList = projectTaskList
        
        vc.pageIndex = index
        
        return vc
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        let vc = viewController as! ContentViewController
        var index = vc.pageIndex as Int
        if((index == 0) || index == NSNotFound)
        {
            return nil
        }
        
        index--
        
        return viewControllerAtIndex(index)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        let vc = viewController as! ContentViewController
        var index = vc.pageIndex as Int
        if(index == NSNotFound)
        {
            return nil
        }
        
        index++
        
        if index == projectLabelList.count
        {
            return nil
        }
        return viewControllerAtIndex(index)
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return self.projectLabelList.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
}

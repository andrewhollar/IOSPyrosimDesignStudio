//
//  ToolBarManager.swift
//  SceneKitTry1
//
//  Created by William Sutton on 3/29/19.
//  Copyright © 2019 ahollar. All rights reserved.
//

import Foundation
import UIKit
import SceneKit

class ToolBarManager {

    var nameToToolBar = [String:UIView]()
    func getNameToToolBar() -> [String:UIView]{
        return nameToToolBar
    }
    var currentToolBar: UIView?
    var viewController: StudioViewController
    var robot: Robot
    let buttonSize = 75
    
    init(controller: StudioViewController){
        self.robot = controller.getRobot()
        self.viewController = controller
    }
    
    func addToolBar(name: String, toolbar: UIView){
        nameToToolBar[name] = toolbar
    }
    
    func setCurrent(toolbar: UIView){
        if(currentToolBar != nil){
            currentToolBar!.removeFromSuperview()
        }
        if(currentToolBar != toolbar){
            currentToolBar = toolbar
            //toolbar.addButtonsToView()
            viewController.view.addSubview(toolbar)
            addMargin(view: toolbar)
            //toolbar.addM
            //toolbar.translatesAutoresizingMaskIntoConstraints = false
//            toolbar.bottomAnchor.constraint(equalTo: viewController.view.bottomAnchor, constant: -120).isActive = true
//            toolbar.centerXAnchor.constraint(equalTo: viewController.view.centerXAnchor, constant: -150).isActive = true
//            toolbar.heightAnchor.constraint(equalToConstant: 75).isActive = true
            
            
        }else{
            currentToolBar = nil;
        }
    }
    
    func setCurrent(name: String){
        if(nameToToolBar[name] != nil){
            setCurrent(toolbar: nameToToolBar[name]!)
        }
    }
    
    func current() -> UIView?{
        return currentToolBar
    }
    
    func addMargin(view: UIView) {
        view.backgroundColor = UIColor.yellow
        
        view.bottomAnchor.constraint(equalTo: viewController.view.bottomAnchor, constant: -400).isActive = true
        view.centerXAnchor.constraint(equalTo: viewController.view.centerXAnchor, constant: -150).isActive = true
        view.heightAnchor.constraint(equalToConstant: CGFloat(buttonSize)).isActive = true
    }
    
}

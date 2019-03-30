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
    var currentToolBar: UIView?
    var viewController: StudioViewController
    
    init(controller: StudioViewController){
        self.viewController = controller
    }
    
    func addToolBar(name: String, toolbar: UIView){
        nameToToolBar[name] = toolbar
    }
    
    func setCurrent(toolbar: UIView){
        if(currentToolBar != nil){
            currentToolBar!.removeFromSuperview()
        }
        currentToolBar = toolbar
        viewController.view.addSubview(toolbar)
    }
    
    func setCurrent(name: String){
        if(nameToToolBar[name] != nil){
            setCurrent(toolbar: nameToToolBar[name]!)
        }
    }
    
    func current() -> UIView{
        return currentToolBar!
    }
    
}
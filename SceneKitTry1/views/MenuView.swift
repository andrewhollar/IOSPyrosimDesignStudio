//
//  MenuView.swift
//  SceneKitTry1
//
//  Created by Jean-Baptiste Bolh on 4/30/19.
//  Copyright © 2019 ahollar. All rights reserved.
//


//This class is responsible for our menu which carries the export feature

import Foundation
import UIKit
import SceneKit

class MenuView: UIView{
    
    var viewController: StudioViewController
    
    var menuToggleButton: UIButton
    var exportButton: UIButton
    
    var toolbar: CGRect
    
    var menuToggled: Bool
    
    let buttonHeight = 25
    let buttonWidth = 100
    
    init(controller: StudioViewController){
        self.viewController = controller
        self.menuToggled = false
        
        //Menu Container
        self.toolbar = CGRect(x: 300, y:0, width: buttonWidth, height: 2*buttonHeight)
        
        //Initializing Buttons
        self.menuToggleButton = UIButton(frame: CGRect(x: 0, y: 0, width: buttonWidth, height: buttonHeight))
        self.exportButton = UIButton(frame: CGRect(x: 0, y: buttonHeight, width: buttonWidth, height: buttonHeight))
        
        //Initialize and add constraints
        super.init(frame: self.toolbar)
        backgroundColor = UIColor.init(red:0.5, green:0, blue:0, alpha: 0)
        controller.view.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        controller.view.addSubview(self)
        
        //Menu Button Parameters
        self.menuToggleButton.addTarget(self, action: #selector(toggleMenu), for: .primaryActionTriggered)
        self.menuToggleButton.setImage(UIImage(named: "menuToggleButton"), for: UIControl.State.normal)
        addSubview(self.menuToggleButton)
        
        //Export Button Parameters
        self.exportButton.addTarget(self, action: #selector(export), for: .primaryActionTriggered)
        self.exportButton.setImage(UIImage(named: "exportButton"), for: UIControl.State.normal)
        addSubview(self.exportButton)
        self.exportButton.isHidden = true
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //////////// Button Action Functions ////////////
    @objc
    func toggleMenu() {
        //Toggle Menu
        if(self.menuToggled == false){
            print("Menu Toggled")
            self.menuToggled = true
            self.exportButton.isHidden = false
        }
        else{
            self.menuToggled = false
            self.exportButton.isHidden = true
        }
    }
    
    @objc
    func export() {
        print("Export")
    }
    
}


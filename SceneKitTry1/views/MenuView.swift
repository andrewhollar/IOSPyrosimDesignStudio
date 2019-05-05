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
    var robot: Robot
    
    var menuToggleButton: UIButton
    var exportButton: UIButton
    
    var toolbar: CGRect
    
    var menuToggled: Bool
    
    let buttonHeight = 25
    let buttonWidth = 100
    
    init(controller: StudioViewController){
        self.viewController = controller
        self.menuToggled = false
        self.robot = controller.getRobot()
        
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
        
        let shapes = self.robot.getShapeNodes()
        let joints = self.robot.getJointNodes()
        
        var s = ""
        
        var i = 0
        for shape in shapes {
            if shape.geometry is SCNBox {
                var length = ((shape.geometry as! SCNBox).length).description
                var width = ((shape.geometry as! SCNBox).width).description
                var height = ((shape.geometry as! SCNBox).height).description
                
                s += "self.O\(i) = sim.send_box(x=\(shape.position.x), y=\(shape.position.z), z=\(shape.position.y), length=\(length), width=\(width), height=\(height), r=1, g=0, b=0)\n"
            }
            else if shape.geometry is SCNCylinder {
                var length = ((shape.geometry as! SCNCylinder).height).description
                var radius = ((shape.geometry as! SCNCylinder).radius).description
                
                s += "self.O\(i) = sim.send_cylinder(x=\(shape.position.x), y=\(shape.position.z), z=\(shape.position.y) length=\(length), radius=\(radius), r=1, g=0, b=0)\n"
            }
            else if shape.geometry is SCNSphere {
                var radius = ((shape.geometry as! SCNSphere).radius).description
                
                s += "self.O\(i) = sim.send_sphere(x=\(shape.position.x), y=\(shape.position.z), z=\(shape.position.y), radius=\(radius), r=1, g=0, b=0)\n"
            }
            i += 1
            print(s)
        }
        
        //NEED A WAY TO CONNECT JOINTS TO 2 OBJECTS
        i = 0
        for joint in joints {
            print("self.J\(i) = sim.send_hinge_joint( first_body_id = self.O0, second_body_id = self.O1, x=0, y=c.L/2, z=c.L+c.R, n1 = -1, n2 = 0, n3 = 0, lo = -3.14159/2 , hi=3.14159/2 )\n")
            i += 1
        }
        
        
    }
    
}


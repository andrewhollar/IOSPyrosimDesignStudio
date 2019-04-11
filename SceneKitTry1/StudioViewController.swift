//
//  GameViewController.swift
//  SceneKitTry1
//
//  Created by andrew hollar on 2/8/19.
//  Copyright © 2019 ahollar. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit

class StudioViewController: UIViewController {
    
    var shapeManager: ShapeManager?
    func getShapeManager() -> ShapeManager{
        return shapeManager!
    }
    
    var toolBarManager: ToolBarManager?
    func getToolBarManager() -> ToolBarManager{
        return toolBarManager!
    }
    
    var hierarchyView: HierarchyView?
    func getHierarchyView() -> HierarchyView{
        return hierarchyView!
    }
    
    var toggleToolBarView: ToggleToolBarView?
    func getToggleToolBarView() -> ToggleToolBarView{
        return toggleToolBarView!
    }
    
    var robot = Robot()
    func getRobot() -> Robot{
        return robot
    }
    
    var xDrag: SCNNode?
    func getXDrag() -> SCNNode?{
        return xDrag
    }
    var yDrag: SCNNode?
    func getYDrag() -> SCNNode?{
        return yDrag
    }
    var zDrag: SCNNode?
    func getZDrag() -> SCNNode?{
        return zDrag
    }
    
    var utilityNodes = [SCNNode]()
    var dragNodes = [SCNNode]()
    
    var currentShape: SCNNode?
    func getCurrentShape() -> SCNNode?{
        return currentShape
    }
    
    var shapesTransparent = false;
    func areShapesTransparent() -> Bool{
        return shapesTransparent
    }
    func setShapesTransparent(b:Bool){
        shapesTransparent = b
    }
    func setCurrentShape(node: SCNNode){
        xDrag!.geometry?.firstMaterial?.diffuse.contents = UIColor(red: 150.0 / 255.0, green: 30.0 / 255.0, blue: 30.0 / 255.0, alpha: 1)
        yDrag!.geometry?.firstMaterial?.diffuse.contents = UIColor(red: 30.0 / 255.0, green: 150.0 / 255.0, blue: 30.0 / 255.0, alpha: 1)
        zDrag!.geometry?.firstMaterial?.diffuse.contents = UIColor(red: 30.0 / 255.0, green: 30.0 / 255.0, blue: 150.0 / 255.0, alpha: 1)
        
        xDrag?.position.x = node.position.x + 2
        xDrag?.position.y = node.position.y
        xDrag?.position.z = node.position.z
        
        
        yDrag?.position.x = node.position.x
        yDrag?.position.y = node.position.y + 2
        yDrag?.position.z = node.position.z
        
        zDrag?.position.x = node.position.x
        zDrag?.position.y = node.position.y
        zDrag?.position.z = node.position.z + 2
        
        if(node.isKind(of: Joint.self)){
            setShapesTransparent(b: true)
        }else{
            setShapesTransparent(b: false)
        }
        
        currentShape = node
        updateShapeColors()
        hierarchyView!.update()
        
    }
    
    func setColor(node: SCNNode){
        let currentShape = getCurrentShape()
        if(areShapesTransparent()){
            if(currentShape != nil && currentShape! == node){
                node.geometry?.firstMaterial?.diffuse.contents = UIColor.init(red:0.9,green:0.6,blue:0.3,alpha:1)
            }else if(node.isKind(of: Joint.self)){
                node.geometry?.firstMaterial?.diffuse.contents = UIColor.init(red:0.9,green:0,blue:0,alpha:1)
            }else{
                node.geometry?.firstMaterial?.diffuse.contents = UIColor.init(red:0.9,green:0.9,blue:0.9,alpha:0.7)
            }
        }else{
            if(currentShape != nil && currentShape! == node){
                node.geometry?.firstMaterial?.diffuse.contents = UIColor.init(red:0.9,green:0.6,blue:0.3,alpha:1)
            }else if(node.isKind(of: Joint.self)){
                node.geometry?.firstMaterial?.diffuse.contents = UIColor.init(red:0.9,green:0,blue:0,alpha:1)
            }else{
                node.geometry?.firstMaterial?.diffuse.contents = UIColor.init(red:0.9,green:0.9,blue:0.9,alpha:1)
            }
        }
    }

    func updateShapeColors(){
        for node in robot.getShapeNodes(){
            setColor(node: node)
        }
        for joint in robot.getJointNodes(){
            setColor(node: joint)
        }
    }
    
    // Geometry
    var originNode: SCNNode = SCNNode()
    var axesNode: SCNNode = SCNNode()
    //var geometryNode: SCNNode = SCNNode()
    
    // Gestures
    var currentAngle: Float = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // create a new scene
        let scene = SCNScene()

        //create classes
        shapeManager = ShapeManager(controller: self)
        toolBarManager = ToolBarManager(controller: self)
        toolBarManager!.addToolBar(name: "shapeSelector", toolbar: ShapeSelectorToolBar(controller: self))
        toolBarManager!.addToolBar(name: "movement", toolbar: MovementToolBar(controller: self))
        toolBarManager!.addToolBar(name: "rotation", toolbar: RotationToolBar(controller: self))
        toolBarManager!.addToolBar(name: "joint", toolbar: JointToolBar(controller: self))

        toggleToolBarView = ToggleToolBarView(controller: self)
        hierarchyView = HierarchyView(controller: self)
        view.addSubview(toggleToolBarView!)
        view.addSubview(hierarchyView!)
        
        // create camera
        var cameraNode: SCNNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3Make(25, 0, 25)
        //cameraNode.rotation = SCNVector4(x: 0, y: 0, z: 0, w: Float(Double.pi / 2))
        cameraNode.eulerAngles  = SCNVector3Make(0, GLKMathDegreesToRadians(45), 0)
        //let lookAt = SCNLookAtConstraint(target: originNode)
        //cameraNode.constraints = [lookAt]
        
        scene.rootNode.addChildNode(cameraNode)
        
        // create and add an ambient light to the scene
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light!.type = .ambient
        ambientLightNode.light!.color = UIColor.darkGray
        scene.rootNode.addChildNode(ambientLightNode)
        
        let omniLightNode = SCNNode()
        omniLightNode.light = SCNLight()
        omniLightNode.light!.type = SCNLight.LightType.omni
        omniLightNode.light!.color = UIColor(white: 0.75, alpha: 1.0)
        omniLightNode.position = SCNVector3Make(0, 50, 50)
        scene.rootNode.addChildNode(omniLightNode)
        
        let xGeom = SCNBox(width: 0.1, height: 10, length: 0.1, chamferRadius: 0.1)
        xGeom.firstMaterial?.diffuse.contents  = UIColor(red: 150.0 / 255.0, green: 30.0 / 255.0, blue: 30.0 / 255.0, alpha: 1)
        let xNode = SCNNode(geometry: xGeom)
        xNode.position = SCNVector3(5,0,0)
        xNode.rotation = SCNVector4(x: 0, y: 0, z: 1, w: Float(Double.pi / 2))
        
        axesNode.addChildNode(xNode)
        utilityNodes.append(xNode)
        
        let yGeom = SCNBox(width: 0.1, height: 10, length: 0.1, chamferRadius: 0.1)
        yGeom.firstMaterial?.diffuse.contents  = UIColor(red: 30.0 / 255.0, green: 150.0 / 255.0, blue: 30.0 / 255.0, alpha: 1)
        let yNode = SCNNode(geometry: yGeom)
        yNode.position = SCNVector3(0,5,0)
        
        axesNode.addChildNode(yNode)
        utilityNodes.append(yNode)
        
        let zGeom = SCNBox(width: 0.1, height: 10, length: 0.1, chamferRadius: 0.1)
        zGeom.firstMaterial?.diffuse.contents  = UIColor(red: 30.0 / 255.0, green: 30.0 / 255.0, blue: 150.0 / 255.0, alpha: 1)
        let zNode = SCNNode(geometry: zGeom)
        zNode.position = SCNVector3(0,0,5)
        zNode.rotation = SCNVector4(x: 1, y: 0, z: 0, w: Float(Double.pi / 2))
        
        axesNode.addChildNode(zNode)
        utilityNodes.append(zNode)
        
        scene.rootNode.addChildNode(axesNode)
        
        //scene.rootNode.addChildNode(geometryNode)
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))

        // retrieve the SCNView
        let scnView = self.view as! SCNView
        scnView.allowsCameraControl = true
        
        // set the scene to the view
        scnView.scene = scene
        
        // show statistics such as fps and timing information
        scnView.showsStatistics = false
        
        // configure the view
        scnView.backgroundColor = UIColor.black
        
        // add a tap gesture recognizer
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        scnView.addGestureRecognizer(tapGesture)
        scnView.addGestureRecognizer(panGesture)
        
        
        let segmentedControl = UISegmentedControl(items: ["Default", "Top", "Left"])
        //backgroundColor = UIColor.white.withAlphaComponent(0)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.addTarget(self, action: #selector(StudioViewController.cameraChanged(_:)), for: .valueChanged)
        scnView.addSubview(segmentedControl)
        
        let topConstraint = segmentedControl.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 5)
        let margins = view.layoutMarginsGuide
        let leadingConstraint = segmentedControl.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 150)
        let trailingConstraint = segmentedControl.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        topConstraint.isActive = true
        leadingConstraint.isActive = true
        trailingConstraint.isActive = true
        
        
        xDrag = getShapeManager().spawnCircle()
        xDrag!.geometry?.firstMaterial?.diffuse.contents = UIColor.init(red:0,green:0,blue:0,alpha:0)
        xDrag!.scale.x = 0.35
        xDrag!.scale.y = 0.35
        xDrag!.scale.z = 0.35
        utilityNodes.append(xDrag!)
        dragNodes.append(xDrag!)
        
        yDrag = getShapeManager().spawnCircle()
        yDrag!.geometry?.firstMaterial?.diffuse.contents = UIColor.init(red:0,green:0,blue:0,alpha:0)
        yDrag!.scale.x = 0.35
        yDrag!.scale.y = 0.35
        yDrag!.scale.z = 0.35
        utilityNodes.append(yDrag!)
        dragNodes.append(yDrag!)
        
        zDrag = getShapeManager().spawnCircle()
        zDrag!.geometry?.firstMaterial?.diffuse.contents = UIColor.init(red:0,green:0,blue:0,alpha:0)
        zDrag!.scale.x = 0.35
        zDrag!.scale.y = 0.35
        zDrag!.scale.z = 0.35
        utilityNodes.append(zDrag!)
        dragNodes.append(zDrag!)
        
        log(message: "success")
        
        
    }
    
    func log(message:String){
        print(message)
    }
    
    
    
    var movedObject:SCNNode?
    @objc func handlePan(_ recognizer: UIPanGestureRecognizer) {
        let scnView = self.view as! SCNView
        if recognizer.state == .began {
            let tapPoint: CGPoint = recognizer.location(in: scnView)
            let result = scnView.hitTest(tapPoint, options: nil)
            if result.count == 0 {
                return
            }
            let p = recognizer.location(in: scnView)
            let hitResults = scnView.hitTest(p, options: [:])
            if hitResults.count > 0{
                let result = hitResults[0]
                let node = result.node
                if dragNodes.contains(node) && currentShape != nil{
                    movedObject = currentShape!
                }
                movedObject = currentShape!
            }
        } else if recognizer.state == .changed {
            
            if (movedObject != nil) {
                
                //Normalized-depth coordinate matching the plane I want
                let projectedOrigin = scnView.projectPoint((movedObject?.position)!)
                
                //Location of the finger in the view on a 2D plane
                let location2D = recognizer.location(in: scnView)
                
                //Location of the finger in a 3D vector
                let location3D = SCNVector3Make(Float(location2D.x), Float(location2D.y), projectedOrigin.z)
                
                //Unprojects a point from the 2D pixel coordinate system of the renderer to the 3D world coordinate system of the scene
                let realLocation3D = scnView.unprojectPoint(location3D)
                
                if movedObject?.position != nil {
                    //Only updating Y axis position
                    let pos = SCNVector3Make((movedObject?.position.x)!, realLocation3D.y, (movedObject?.position.z)!)
                    movedObject?.position = pos
                    xDrag!.position = SCNVector3(pos.x + 2,pos.y,pos.z)
                    yDrag!.position = SCNVector3(pos.x,pos.y + 2,pos.z)
                    zDrag!.position = SCNVector3(pos.x,pos.y,pos.z + 2)
                }
                
            }
        } else if recognizer.state == .ended {
            movedObject = nil
        }
    }
    
    @objc
    func handleTap(_ gestureRecognize: UIGestureRecognizer) {
        // retrieve the SCNView
        let scnView = self.view as! SCNView
        
        // check what nodes are tapped
        let p = gestureRecognize.location(in: scnView)
        let hitResults = scnView.hitTest(p, options: [:])
        // check that we clicked on at least one object
        if hitResults.count > 0{
            // retrieved the first clicked object
            let result = hitResults[0]
            
            if(!utilityNodes.contains(result.node)){
                setCurrentShape(node: result.node)
            }
        }
    }
    
    @objc func cameraChanged(_ segControl: UISegmentedControl) {
        let scnView = self.view as! SCNView

        switch segControl.selectedSegmentIndex {
        case 0:
            print("default camera selected")
            scnView.pointOfView?.position = SCNVector3Make(25,0, 25)
            scnView.pointOfView?.eulerAngles = SCNVector3Make(0, GLKMathDegreesToRadians(45), 0)

        case 1:
            print("top camera selected")
            scnView.pointOfView?.position = SCNVector3Make(0, 25, 0)
            scnView.pointOfView?.eulerAngles = SCNVector3Make(GLKMathDegreesToRadians(-90), 0, 0)
        case 2:
            print("Right camera selected")
            scnView.pointOfView?.position = SCNVector3Make(0, 0, 25)
            scnView.pointOfView?.eulerAngles = SCNVector3Make(0,GLKMathDegreesToRadians(0), 0)
        default:
            break
        }
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

}

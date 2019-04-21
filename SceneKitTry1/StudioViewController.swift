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
    
    var xResize: SCNNode?
    func getXResize() -> SCNNode?{
        return xResize
    }
    var yResize: SCNNode?
    func getYResize() -> SCNNode?{
        return yResize
    }
    var zResize: SCNNode?
    func getZResize() -> SCNNode?{
        return zResize
    }
    
    var utilityNodes = [SCNNode]()
    var dragNodes = [SCNNode]()
    var resizeNodes = [SCNNode]()
    
    var nonSnapXScale: Float = 1.0
    var nonSnapYScale: Float = 1.0
    var nonSnapZScale: Float = 1.0
    
    var nonSnapXPos: Float = 0.0
    var nonSnapYPos: Float = 0.0
    var nonSnapZPos: Float = 0.0
    
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
        
        xResize!.geometry?.firstMaterial?.diffuse.contents = UIColor(red: 200.0 / 255.0, green: 30.0 / 255.0, blue: 30.0 / 255.0, alpha: 1)
        yResize!.geometry?.firstMaterial?.diffuse.contents = UIColor(red: 30.0 / 255.0, green: 200.0 / 255.0, blue: 30.0 / 255.0, alpha: 1)
        zResize!.geometry?.firstMaterial?.diffuse.contents = UIColor(red: 30.0 / 255.0, green: 30.0 / 255.0, blue: 200.0 / 255.0, alpha: 1)
        
        if node.geometry is SCNSphere || node.geometry is SCNBox {
            xDrag?.position.x = node.position.x + node.scale.x + 1
            xDrag?.position.y = node.position.y
            xDrag?.position.z = node.position.z
            
            yDrag?.position.x = node.position.x
            yDrag?.position.y = node.position.y + node.scale.y + 1
            yDrag?.position.z = node.position.z
            
            zDrag?.position.x = node.position.x
            zDrag?.position.y = node.position.y
            zDrag?.position.z = node.position.z + node.scale.z + 1
            
            xResize?.position.x = node.position.x + node.scale.x + 3
            xResize?.position.y = node.position.y
            xResize?.position.z = node.position.z
            
            yResize?.position.x = node.position.x
            yResize?.position.y = node.position.y + node.scale.y + 3
            yResize?.position.z = node.position.z
            
            zResize?.position.x = node.position.x
            zResize?.position.y = node.position.y
            zResize?.position.z = node.position.z + node.scale.z + 3
        }
        else if node.geometry is SCNCylinder {
            let cyl = node.geometry as! SCNCylinder
            
            let tempY: CGFloat = CGFloat(Float(cyl.height) * node.scale.y)

            xDrag?.position.x = node.position.x + node.scale.x + 1
            xDrag?.position.y = node.position.y
            xDrag?.position.z = node.position.z
            
            yDrag?.position.x = node.position.x
            yDrag?.position.y = node.position.y + Float((tempY / 2) + 1.0)
            yDrag?.position.z = node.position.z
            
            zDrag?.position.x = node.position.x
            zDrag?.position.y = node.position.y
            zDrag?.position.z = node.position.z + node.scale.z + 1
            
            xResize?.position.x = node.position.x + node.scale.x + 3
            xResize?.position.y = node.position.y
            xResize?.position.z = node.position.z
            
            yResize?.position.x = node.position.x
            yResize?.position.y = node.position.y + Float((tempY / 2) + 3.0)
            yResize?.position.z = node.position.z
            
            zResize?.position.x = node.position.x
            zResize?.position.y = node.position.y
            zResize?.position.z = node.position.z + node.scale.z + 3
        }
        
        
        
        if(node.isKind(of: Joint.self)){
            setShapesTransparent(b: true)
        }else{
            setShapesTransparent(b: false)
        }
        
        currentShape = node
        updateShapeColors()
        hierarchyView!.update()
        
        self.nonSnapXScale = (currentShape?.scale.x)!
        self.nonSnapYScale = (currentShape?.scale.y)!
        self.nonSnapZScale = (currentShape?.scale.z)!
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
        
        xResize = getShapeManager().spawnCircle()
        xResize!.geometry?.firstMaterial?.diffuse.contents = UIColor.init(red:0,green:0,blue:0,alpha:0)
        xResize!.scale.x = 0.5
        xResize!.scale.y = 0.5
        xResize!.scale.z = 0.5
        utilityNodes.append(xResize!)
        resizeNodes.append(xResize!)
        
        yResize = getShapeManager().spawnCircle()
        yResize!.geometry?.firstMaterial?.diffuse.contents = UIColor.init(red:0,green:0,blue:0,alpha:0)
        yResize!.scale.x = 0.5
        yResize!.scale.y = 0.5
        yResize!.scale.z = 0.5
        utilityNodes.append(yResize!)
        resizeNodes.append(yResize!)
        
        zResize = getShapeManager().spawnCircle()
        zResize!.geometry?.firstMaterial?.diffuse.contents = UIColor.init(red:0,green:0,blue:0,alpha:0)
        zResize!.scale.x = 0.5
        zResize!.scale.y = 0.5
        zResize!.scale.z = 0.5
        utilityNodes.append(zResize!)
        resizeNodes.append(zResize!)
        
        log(message: "success")
        
        
    }
    
    func log(message:String){
        print(message)
    }
    
    
    let resizeConstant: Float = 0.05
    let snapToVal: Double = 1.0
    
    
    var movedObject:SCNNode?
    var resizedObject:SCNNode?
    var direction = ""
    var startTouch: CGPoint?
    
    
    var prevXScale: Float = 1.0
    var prevYScale: Float = 1.0
    var prevZScale: Float = 1.0
//    var prevXPos: Float = 0.0
//    var prevYPos: Float = 0.0
//    var prevZPos: Float = 0.0
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let scnView = self.view as! SCNView
        print("new touch")
        if let touch = touches.first {
//            let tapPoint: CGPoint = touch.location(in: scnView)
//            let result = scnView.hitTest(tapPoint, options: nil)
//            if result.count == 0 {
//                return
//            }
            let p = touch.location(in: scnView)
            let hitResults = scnView.hitTest(p, options: [:])
            if hitResults.count > 0{
                let result = hitResults[0]
                let node = result.node
                if dragNodes.contains(node) && currentShape != nil{
                    scnView.allowsCameraControl = false
                    if(node == xDrag!){
                        direction = "x"
                        xDrag!.geometry?.firstMaterial?.diffuse.contents = UIColor(red: 190.0 / 255.0, green: 70.0 / 255.0, blue: 70.0 / 255.0, alpha: 1)
                    }else if(node == yDrag!){
                        direction = "y"
                        yDrag!.geometry?.firstMaterial?.diffuse.contents = UIColor(red: 70.0 / 255.0, green: 190.0 / 255.0, blue: 70.0 / 255.0, alpha: 1)
                        
                    }else if(node == zDrag!){
                        direction = "z"
                        zDrag!.geometry?.firstMaterial?.diffuse.contents = UIColor(red: 70.0 / 255.0, green: 70.0 / 255.0, blue: 190.0 / 255.0, alpha: 1)
                    }
//                    xResize?.removeFromParentNode()
//                    yResize?.removeFromParentNode()
//                    zResize?.removeFromParentNode()
//                    xResize?.isHidden = true
//                    yResize?.isHidden = true
//                    zResize?.isHidden = true
                    movedObject = currentShape!
                    //continousUpdate()
                }
                else if (resizeNodes.contains(node) && currentShape != nil){
                    scnView.allowsCameraControl = false
                    if(node == xResize!){
                        direction = "x"
                        xResize!.geometry?.firstMaterial?.diffuse.contents = UIColor(red: 220.0 / 255.0, green: 70.0 / 255.0, blue: 70.0 / 255.0, alpha: 1)
                    }else if(node == yResize!){
                        direction = "y"
                        yResize!.geometry?.firstMaterial?.diffuse.contents = UIColor(red: 70.0 / 255.0, green: 220.0 / 255.0, blue: 70.0 / 255.0, alpha: 1)
                        
                    }else if(node == zResize!){
                        direction = "z"
                        zResize!.geometry?.firstMaterial?.diffuse.contents = UIColor(red: 70.0 / 255.0, green: 70.0 / 255.0, blue: 220.0 / 255.0, alpha: 1)
                    }
                    startTouch = touch.location(in: scnView)
                    resizedObject = currentShape!
                    //continousUpdate()
                }
                
            }
        }
    }
    
//    func continousUpdate(){
//        //
////        let scnView = self.view as! SCNView
////        while movedObject != nil{
////
////        }
//    }
//
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let scnView = self.view as! SCNView
        
        //CGPoint newLocation = self.view.previous//aTouch locationInView:self.view
        //CGPoint prevLocation = [aTouch previousLocationInView:self.view];
        for touch in touches {
            if (movedObject != nil) {
                //Normalized-depth coordinate matching the plane I want
                let projectedOrigin = scnView.projectPoint((movedObject?.position)!)
                
                //Location of the finger in the view on a 2D plane
                let location2D = touch.location(in: scnView)
                
                //Location of the finger in a 3D vector
                let location3D = SCNVector3Make(Float(location2D.x), Float(location2D.y), projectedOrigin.z)
                
                //Unprojects a point from the 2D pixel coordinate system of the renderer to the 3D world coordinate system of the scene
                let realLocation3D = scnView.unprojectPoint(location3D)
                
                if movedObject?.position != nil {
                    //Only updating Y axis position
                    var pos: SCNVector3?
                    if(direction == "x"){
                        /*let newXScale = Float(Double((resizedObject?.scale.x)! + resizeConstant))
                        let deltaXScale = newXScale - (resizedObject?.scale.x)!
                        print(deltaXScale)
                        self.nonSnapXScale += deltaXScale
                        print(self.nonSnapXScale)
                        let snapXScale = Double(self.nonSnapXScale).floor(nearest: 1)
                        print(snapXScale)*/
//                        let newXPos = Float(Double((movedObject?.position.x)! + resizeConstant))
//                        let deltaXPos = newXPos - (movedObject?.position.x)!
//                        print(deltaXPos)
//                        self.nonSnapXPos += deltaXPos
//                        print(self.nonSnapXPos)
//                        let snapXPos = Double(self.nonSnapXPos).floor(nearest: 1)
//                        print(snapXPos)
//
//                        pos = SCNVector3(x: Float(snapXPos), y: (movedObject?.position.y)! , z: (movedObject?.position.z)!)
//                        if (self.prevXPos != Float(snapXPos)) {
//                            xResize!.position = SCNVector3(x: (xResize?.position.x)! + 1, y: (xResize?.position.y)!, z: (xResize?.position.z)!)
//                            xDrag!.position = SCNVector3(x: (xDrag?.position.x)! + 1, y: (xDrag?.position.y)!, z: (xDrag?.position.z)!)
//                        }
//
                        pos = SCNVector3Make(realLocation3D.x,(movedObject?.position.y)!, (movedObject?.position.z)!)
                        
                        //self.prevXPos = Float(snapXPos)
                    }else if(direction == "y"){
                        pos = SCNVector3Make((movedObject?.position.x)!, realLocation3D.y, (movedObject?.position.z)!)
                    }else if(direction  == "z"){
                        pos = SCNVector3Make((movedObject?.position.x)!, (movedObject?.position.y)!, realLocation3D.z)
                    }
                    if(pos != nil){
                        movedObject?.position = pos!

                        if movedObject!.geometry is SCNSphere || movedObject!.geometry is SCNBox {
                            xDrag!.position = SCNVector3(pos!.x + (movedObject?.scale.x)! + 1, pos!.y, pos!.z)
                            yDrag!.position = SCNVector3(pos!.x,pos!.y + (movedObject?.scale.y)! + 1,pos!.z)
                            zDrag!.position = SCNVector3(pos!.x,pos!.y,pos!.z + (movedObject?.scale.z)! + 1)
                            xResize!.position = SCNVector3(pos!.x + (movedObject?.scale.x)! + 3, pos!.y, pos!.z)
                            yResize!.position = SCNVector3(pos!.x,pos!.y + (movedObject?.scale.y)! + 3,pos!.z)
                            zResize!.position = SCNVector3(pos!.x,pos!.y,pos!.z + (movedObject?.scale.z)! + 3)

                        }
                        else if movedObject!.geometry is SCNCylinder {
                            let cyl = movedObject!.geometry as! SCNCylinder
                            
                            let tempY: CGFloat = CGFloat(Float(cyl.height) * (movedObject?.scale.y)!)
                            
                            xDrag!.position = SCNVector3(pos!.x + (movedObject?.scale.x)! + 1, pos!.y, pos!.z)
                            yDrag!.position = SCNVector3(pos!.x,pos!.y + Float((tempY / 2) + 1.0) ,pos!.z)
                            zDrag!.position = SCNVector3(pos!.x,pos!.y,pos!.z + (movedObject?.scale.z)! + 1)
                            xResize!.position = SCNVector3(pos!.x + (movedObject?.scale.x)! + 3, pos!.y, pos!.z)
                            yResize!.position = SCNVector3(pos!.x,pos!.y + Float((tempY / 2) + 3.0),pos!.z)
                            zResize!.position = SCNVector3(pos!.x,pos!.y,pos!.z + (movedObject?.scale.z)! + 3)
                        }
                    }
                }
            }
            else if (resizedObject != nil) {
                //Normalized-depth coordinate matching the plane I want
                let projectedOrigin = scnView.projectPoint((resizedObject?.position)!)
                
                //Location of the finger in the view on a 2D plane
                let location2D = touch.location(in: scnView)
                
                //Location of the finger in a 3D vector
                let location3D = SCNVector3Make(Float(location2D.x), Float(location2D.y), projectedOrigin.z)
                
                //Unprojects a point from the 2D pixel coordinate system of the renderer to the 3D world coordinate system of the scene
                let realLocation3D = scnView.unprojectPoint(location3D)
                
                if resizedObject?.position != nil {
                    //Only updating Y axis position
                    ////boxNode.scale = SCNVector3(x: 0.5, y: 0.5, z: 0.5)
                    var scale: SCNVector3?
                    if(direction == "x"){
                        if (startTouch!.x < location2D.x) {
                            print("Up")
                            let newXScale = Float(Double((resizedObject?.scale.x)! + resizeConstant))
                            let deltaXScale = newXScale - (resizedObject?.scale.x)!
                            print(deltaXScale)
                            self.nonSnapXScale += deltaXScale
                            print(self.nonSnapXScale)
                            let snapXScale = Double(self.nonSnapXScale).floor(nearest: 1)
                            print(snapXScale)
                            
                            scale = SCNVector3(x: Float(snapXScale), y: (resizedObject?.scale.y)! , z: (resizedObject?.scale.z)!)
                            
                            if (self.prevXScale != Float(snapXScale)) {
                                if (resizedObject?.geometry is SCNSphere) {
                                    xResize!.position = SCNVector3(x: (xResize?.position.x)! + 1, y: (xResize?.position.y)!, z: (xResize?.position.z)!)
                                    xDrag!.position = SCNVector3(x: (xDrag?.position.x)! + 1, y: (xDrag?.position.y)!, z: (xDrag?.position.z)!)
                                }
                                else if (resizedObject?.geometry is SCNCylinder) {
                                    xResize!.position = SCNVector3(x: (xResize?.position.x)! + 1, y: (xResize?.position.y)!, z: (xResize?.position.z)!)
                                    xDrag!.position = SCNVector3(x: (xDrag?.position.x)! + 1, y: (xDrag?.position.y)!, z: (xDrag?.position.z)!)
                                }
                                else if (resizedObject?.geometry is SCNBox) {
                                    xResize!.position = SCNVector3(x: (xResize?.position.x)! + 0.5, y: (xResize?.position.y)!, z: (xResize?.position.z)!)
                                    xDrag!.position = SCNVector3(x: (xDrag?.position.x)! + 0.5, y: (xDrag?.position.y)!, z: (xDrag?.position.z)!)
                                }
                            }
                            self.prevXScale = Float(snapXScale)
                        }
                        else if (startTouch!.x > location2D.x) {
                            if ((resizedObject?.scale.x)! > 1) {
                                print("Down")
                                let newXScale = Float(Double((resizedObject?.scale.x)! - resizeConstant))
                                let deltaXScale = (resizedObject?.scale.x)! - newXScale
                                print(deltaXScale)
                                self.nonSnapXScale -= deltaXScale
                                print(self.nonSnapXScale)
                                let snapXScale = Double(self.nonSnapXScale).floor(nearest: 1)
                                print(snapXScale)
                                scale = SCNVector3(x: Float(snapXScale), y: (resizedObject?.scale.y)! , z: (resizedObject?.scale.z)!)

                                if (self.prevXScale != Float(snapXScale)) {
                                    if (resizedObject?.geometry is SCNSphere) {
                                        xResize!.position = SCNVector3(x: (xResize?.position.x)! - 1, y: (xResize?.position.y)!, z: (xResize?.position.z)!)
                                        xDrag!.position = SCNVector3(x: (xDrag?.position.x)! - 1, y: (xDrag?.position.y)!, z: (xDrag?.position.z)!)
                                    }
                                    else if (resizedObject?.geometry is SCNCylinder) {
                                        xResize!.position = SCNVector3(x: (xResize?.position.x)! - 1, y: (xResize?.position.y)!, z: (xResize?.position.z)!)
                                        xDrag!.position = SCNVector3(x: (xDrag?.position.x)! - 1, y: (xDrag?.position.y)!, z: (xDrag?.position.z)!)
                                    }
                                    else if (resizedObject?.geometry is SCNBox) {
                                        xResize!.position = SCNVector3(x: (xResize?.position.x)! - 0.5, y: (xResize?.position.y)!, z: (xResize?.position.z)!)
                                        xDrag!.position = SCNVector3(x: (xDrag?.position.x)! - 0.5, y: (xDrag?.position.y)!, z: (xDrag?.position.z)!)
                                    }
                                }
                                self.prevXScale = Float(snapXScale)
                            }
                        }
                    }else if(direction == "y"){
                        if (startTouch!.y > location2D.y) {
                            print("Up")
                            let newYScale = Float(Double((resizedObject?.scale.y)! + resizeConstant))
                            let deltaYScale = newYScale - (resizedObject?.scale.y)!
                            print(deltaYScale)
                            self.nonSnapYScale += deltaYScale
                            print(self.nonSnapYScale)
                            let snapYScale = Double(self.nonSnapYScale).floor(nearest: 1)
                            print(snapYScale)
                            
                            scale = SCNVector3(x: (resizedObject?.scale.x)! , y: Float(snapYScale), z: (resizedObject?.scale.z)!)
                            if (self.prevYScale != Float(snapYScale)) {
                                if (resizedObject?.geometry is SCNSphere) {
                                    yResize!.position = SCNVector3(x: (yResize?.position.x)!, y: (yResize?.position.y)! + 1, z: (yResize?.position.z)!)
                                    yDrag!.position = SCNVector3(x: (yDrag?.position.x)!, y: (yDrag?.position.y)! + 1, z: (yDrag?.position.z)!)
                                }
                                else if (resizedObject?.geometry is SCNCylinder) {
                                    yResize!.position = SCNVector3(x: (yResize?.position.x)!, y: (yResize?.position.y)! + 2, z: (yResize?.position.z)!)
                                    yDrag!.position = SCNVector3(x: (yDrag?.position.x)!, y: (yDrag?.position.y)! + 2, z: (yDrag?.position.z)!)
                                }
                                else if (resizedObject?.geometry is SCNBox) {
                                    yResize!.position = SCNVector3(x: (yResize?.position.x)!, y: (yResize?.position.y)! + 0.5, z: (yResize?.position.z)!)
                                    yDrag!.position = SCNVector3(x: (yDrag?.position.x)!, y: (yDrag?.position.y)! + 0.5, z: (yDrag?.position.z)!)
                                }
                                
                            }
                            self.prevYScale = Float(snapYScale)
                        }
                        else if (startTouch!.y < location2D.y) {
                            if ((resizedObject?.scale.y)! > 1) {
                                print("Down")
                                let newYScale = Float(Double((resizedObject?.scale.y)! - resizeConstant))
                                let deltaYScale = (resizedObject?.scale.y)! - newYScale
                                print(deltaYScale)
                                self.nonSnapYScale -= deltaYScale
                                print(self.nonSnapYScale)
                                let snapYScale = Double(self.nonSnapYScale).floor(nearest: 1)
                                print(snapYScale)

                                scale = SCNVector3(x: (resizedObject?.scale.x)! , y: Float(snapYScale), z: (resizedObject?.scale.z)!)
                                if (self.prevYScale != Float(snapYScale)) {
                                    if (resizedObject?.geometry is SCNSphere) {
                                        yResize!.position = SCNVector3(x: (yResize?.position.x)!, y: (yResize?.position.y)! - 1, z: (yResize?.position.z)!)
                                        yDrag!.position = SCNVector3(x: (yDrag?.position.x)!, y: (yDrag?.position.y)! - 1, z: (yDrag?.position.z)!)
                                    }
                                    else if (resizedObject?.geometry is SCNCylinder) {
                                        yResize!.position = SCNVector3(x: (yResize?.position.x)!, y: (yResize?.position.y)! - 2, z: (yResize?.position.z)!)
                                        yDrag!.position = SCNVector3(x: (yDrag?.position.x)!, y: (yDrag?.position.y)! - 2, z: (yDrag?.position.z)!)
                                    }
                                    else if (resizedObject?.geometry is SCNBox) {
                                        yResize!.position = SCNVector3(x: (yResize?.position.x)!, y: (yResize?.position.y)! - 0.5, z: (yResize?.position.z)!)
                                        yDrag!.position = SCNVector3(x: (yDrag?.position.x)!, y: (yDrag?.position.y)! - 0.5, z: (yDrag?.position.z)!)
                                    }
                                }
                                self.prevYScale = Float(snapYScale)
                            }
                        }
                        startTouch = touch.location(in: scnView)
                    }else if(direction  == "z"){
                        if (startTouch!.x > location2D.x) {
                            print("Out")
                            let newZScale = Float(Double((resizedObject?.scale.z)! + resizeConstant))
                            let deltaZScale = newZScale - (resizedObject?.scale.z)!
                            print(deltaZScale)
                            self.nonSnapZScale += deltaZScale
                            print(self.nonSnapZScale)
                            let snapZScale = Double(self.nonSnapZScale).floor(nearest: 1)
                            print(snapZScale)
                            
                            scale = SCNVector3(x: (resizedObject?.scale.x)!, y: (resizedObject?.scale.y)! , z: Float(snapZScale))
                            
                            if (self.prevZScale != Float(snapZScale)) {
                                if (resizedObject?.geometry is SCNSphere) {
                                    zResize!.position = SCNVector3(x: (zResize?.position.x)!, y: (zResize?.position.y)!, z: (zResize?.position.z)! + 1)
                                    zDrag!.position = SCNVector3(x: (zDrag?.position.x)!, y: (zDrag?.position.y)!, z: (zDrag?.position.z)! + 1)
                                }
                                else if (resizedObject?.geometry is SCNCylinder) {
                                    zResize!.position = SCNVector3(x: (zResize?.position.x)!, y: (zResize?.position.y)!, z: (zResize?.position.z)! + 1)
                                    zDrag!.position = SCNVector3(x: (zDrag?.position.x)!, y: (zDrag?.position.y)!, z: (zDrag?.position.z)! + 1)
                                }
                                else if (resizedObject?.geometry is SCNBox) {
                                    zResize!.position = SCNVector3(x: (zResize?.position.x)!, y: (zResize?.position.y)!, z: (zResize?.position.z)! + 0.5)
                                    zDrag!.position = SCNVector3(x: (zDrag?.position.x)!, y: (zDrag?.position.y)!, z: (zDrag?.position.z)! + 0.5)
                                }
                            }
                            self.prevZScale = Float(snapZScale)
                        }
                        else if (startTouch!.x < location2D.x) {
                            if ((resizedObject?.scale.z)! > 1) {
                                print("In")
                                let newZScale = Float(Double((resizedObject?.scale.z)! - resizeConstant))
                                let deltaZScale = (resizedObject?.scale.z)! - newZScale
                                print(deltaZScale)
                                self.nonSnapZScale -= deltaZScale
                                print(self.nonSnapZScale)
                                let snapZScale = Double(self.nonSnapZScale).floor(nearest: 1)
                                print(snapZScale)
                                scale = SCNVector3(x: (resizedObject?.scale.x)!, y: (resizedObject?.scale.y)! , z: Float(snapZScale))
                                
                                if (self.prevZScale != Float(snapZScale)) {
                                    if (resizedObject?.geometry is SCNSphere) {
                                        zResize!.position = SCNVector3(x: (zResize?.position.x)!, y: (zResize?.position.y)!, z: (zResize?.position.z)! - 1)
                                        zDrag!.position = SCNVector3(x: (zDrag?.position.x)!, y: (zDrag?.position.y)!, z: (zDrag?.position.z)! - 1)
                                    }
                                    else if (resizedObject?.geometry is SCNCylinder) {
                                        zResize!.position = SCNVector3(x: (zResize?.position.x)!, y: (zResize?.position.y)!, z: (zResize?.position.z)! - 1)
                                        zDrag!.position = SCNVector3(x: (zDrag?.position.x)!, y: (zDrag?.position.y)!, z: (zDrag?.position.z)! - 1)
                                    }
                                    else if (resizedObject?.geometry is SCNBox) {
                                        zResize!.position = SCNVector3(x: (zResize?.position.x)!, y: (zResize?.position.y)!, z: (zResize?.position.z)! - 0.5)
                                        zDrag!.position = SCNVector3(x: (zDrag?.position.x)!, y: (zDrag?.position.y)!, z: (zDrag?.position.z)! - 0.5)
                                    }
                                }
                                self.prevZScale = Float(snapZScale)
                            }
                        }
                    }
                    if (scale != nil) {
                        resizedObject?.scale = scale!
                    }
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let scnView = self.view as! SCNView
        movedObject = nil
        xDrag!.geometry?.firstMaterial?.diffuse.contents = UIColor(red: 150.0 / 255.0, green: 30.0 / 255.0, blue: 30.0 / 255.0, alpha: 1)
        yDrag!.geometry?.firstMaterial?.diffuse.contents = UIColor(red: 30.0 / 255.0, green: 150.0 / 255.0, blue: 30.0 / 255.0, alpha: 1)
        zDrag!.geometry?.firstMaterial?.diffuse.contents = UIColor(red: 30.0 / 255.0, green: 30.0 / 255.0, blue: 150.0 / 255.0, alpha: 1)
        
        xResize!.geometry?.firstMaterial?.diffuse.contents = UIColor(red: 200.0 / 255.0, green: 30.0 / 255.0, blue: 30.0 / 255.0, alpha: 1)
        yResize!.geometry?.firstMaterial?.diffuse.contents = UIColor(red: 30.0 / 255.0, green: 200.0 / 255.0, blue: 30.0 / 255.0, alpha: 1)
        zResize!.geometry?.firstMaterial?.diffuse.contents = UIColor(red: 30.0 / 255.0, green: 30.0 / 255.0, blue: 200.0 / 255.0, alpha: 1)
        direction = ""
        
//        scnView.scene?.rootNode.addChildNode(xResize!)
//        scnView.scene?.rootNode.addChildNode(yResize!)
//        scnView.scene?.rootNode.addChildNode(zResize!)

//        xResize?.isHidden = false
//        yResize?.isHidden = false
//        zResize?.isHidden = false
        
        scnView.allowsCameraControl = true
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        let scnView = self.view as! SCNView
        movedObject = nil
        xDrag!.geometry?.firstMaterial?.diffuse.contents = UIColor(red: 150.0 / 255.0, green: 30.0 / 255.0, blue: 30.0 / 255.0, alpha: 1)
        yDrag!.geometry?.firstMaterial?.diffuse.contents = UIColor(red: 30.0 / 255.0, green: 150.0 / 255.0, blue: 30.0 / 255.0, alpha: 1)
        zDrag!.geometry?.firstMaterial?.diffuse.contents = UIColor(red: 30.0 / 255.0, green: 30.0 / 255.0, blue: 150.0 / 255.0, alpha: 1)
        
        xResize!.geometry?.firstMaterial?.diffuse.contents = UIColor(red: 200.0 / 255.0, green: 30.0 / 255.0, blue: 30.0 / 255.0, alpha: 1)
        yResize!.geometry?.firstMaterial?.diffuse.contents = UIColor(red: 30.0 / 255.0, green: 200.0 / 255.0, blue: 30.0 / 255.0, alpha: 1)
        zResize!.geometry?.firstMaterial?.diffuse.contents = UIColor(red: 30.0 / 255.0, green: 30.0 / 255.0, blue: 200.0 / 255.0, alpha: 1)
        
//        scnView.scene?.rootNode.addChildNode(xResize!)
//        scnView.scene?.rootNode.addChildNode(yResize!)
//        scnView.scene?.rootNode.addChildNode(zResize!)
//        xResize?.isHidden = false
//        yResize?.isHidden = false
//        zResize?.isHidden = false
        
        direction = ""
        scnView.allowsCameraControl = true
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

extension Double {
    func round(nearest: Double) -> Double {
        let n = 1/nearest
        let numberToRound = self * n
        return numberToRound.rounded() / n
    }
    
    func floor(nearest: Double) -> Double {
        let intDiv = Double(Int(self / nearest))
        return intDiv * nearest
    }
}


# SceneBean
This is a little layer I built above SceneKit to make some of the most used functions easier to implement quickly and neatly and increase readibility. This is especially useful for Prototyping in Playgrounds. Built it for my wwdc18 playground but its such a neat idea I'm gonna work hard on expanding it. Still a work in progress but expect updates! Feel free to provide feedback or a pull request!

***Here's an example of how SceneBean makes life easier, take the two following functions:***

**Without SceneBean**
```swift
func ApplyForceToRocket() {
        guard let rocketshipNode = scene.rootNode.childNode(withName: "rocketship", recursively: false) ,
              let physicsBody = rocketshipNode.physicsBody
              else { print("Force Failed"), return }
        let direction = SCNVector3(0, 3, 0)
        physicsBody.applyForce(direction, asImpulse: true)
}
```
    
**With SceneBean**
```swift
func ApplyForceToRocket() {
SceneBean.SBApplyForce( ontoChildNodeWithName: "rocketship", 
                                      inScene: scene, 
                                  inDirection: SCNVector3(0, 3, 0), 
                                    asImpulse: true)
}
```
***See how much neater that is! And stuff like guard is always used so you shouldn't crash even if you screw up your syntax.***
    
## Installation
Drag SceneBean.swift into your Project.
*CocoaPods* and *Carthage* coming soon.

## Usage
Here's an example of how to use Scenebean!
```SceneBean.SB<FunctionOfChoice>```

## Authors

* **Dalton Prescott** - *Main Developer* - [website](http://daltonprescott.com)

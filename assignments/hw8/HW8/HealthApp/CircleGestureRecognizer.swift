//
//  CircleGestureRecognizer.swift
//  HealthApp
//
//  Created by Connor Easton on 3/16/21.
//

import UIKit
import UIKit.UIGestureRecognizerSubclass

class CircleGestureRecognizer: UIGestureRecognizer {
    
    var minRadius: Float = 50
    var maxRadius: Float = 150
    var points: [CGPoint] = []
    var center: CGPoint!
    var firstPoint: CGPoint!
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        print("circle: touchesBegan")
        let touch = touches.first
        if let point = touch?.location(in: self.view) {
            firstPoint = point
            points.append(point)
            let D = distance(point, center)
            if(minRadius <= D && D <= maxRadius) {
                state = .began
            } else {
                state = .failed
            }
            
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        print("circle: touchesMoved")
        let touch = touches.first
        if let point = touch?.location(in: self.view) {
            points.append(point)
            let D = distance(point, center)
            if(minRadius <= D && D <= maxRadius) {
                state = .changed
            } else {
                state = .failed
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        print("circle: touchesEnded")
        let touch = touches.first
        if let point = touch?.location(in: self.view) {
            points.append(point)
            let D = distance(point, center)
            if (point != firstPoint) && (minRadius <= D && D <= maxRadius) {
                if isCircle(){
                    state = .ended
                } else {
                    state = .failed
                }
            } else {
                state = .failed
            }
        }
    }
    
    func isCircle() -> Bool {
        var quadrants = [false, false, false, false]
        
        for point in points{
            if(point.x > center.x && point.y > center.y){
                quadrants[0] = true
            }
            else if(point.x < center.x && point.y > center.y){
                quadrants[1] = true
            }
            else if(point.x < center.x && point.y < center.y){
                quadrants[2] = true
            }
            else if(point.x > center.x && point.y < center.y){
                quadrants[3] = true
            }
        }
        return quadrants[0] && quadrants[1] && quadrants[2] && quadrants[3]
    }
    
    
    func distance(_ p1: CGPoint, _ p2: CGPoint) -> Float {
        let xdist = abs(p1.x - p2.x)
        let ydist = abs(p1.y - p2.y)
        let dist = sqrt((xdist * xdist) + (ydist * ydist))
        return Float(dist)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent) {
        print("circle: touchesCancelled")
        state = .cancelled
    }
    
    override func reset() {
        print("circle: reset")
    }
}

//
//  CircleMarker.swift
//  SecondRecap
//
//  Created by Greed on 5/15/24.
//

import UIKit
import DGCharts

class CircleMarker: MarkerImage {
    
    @objc var color: UIColor
    @objc var radius: CGFloat = 4
    @objc var backRadius: CGFloat = 5
    
    @objc public init(color: UIColor) {
        self.color = color
        super.init()
    }
    
    override func draw(context: CGContext, point: CGPoint) {
        let backRect = CGRect(x: point.x - backRadius, y: point.y - backRadius, width: backRadius * 2, height: backRadius * 2)
        let circleRect = CGRect(x: point.x - radius, y: point.y - radius, width: radius * 2, height: radius * 2)
        context.setFillColor(UIColor.customWhite.cgColor)
        context.fillEllipse(in: backRect)
        context.setFillColor(color.cgColor)
        context.fillEllipse(in: circleRect)
        context.restoreGState()
    }
}

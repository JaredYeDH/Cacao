//
//  UISwitchStyleKit.swift
//  Cacao
//
//  Created by Alsey Coleman Miller on 6/16/17.
//  Copyright © 2017 PureSwift. All rights reserved.
//
//  Generated by PaintCode
//  http://www.paintcodeapp.com
//

import struct Foundation.CGFloat
import struct Foundation.CGPoint
import struct Foundation.CGSize
import struct Foundation.CGRect
import Silica

class UISwitchStyleKit {

    //// Cache

    private struct Cache {
        static let defaultOnColor: UIColor = UIColor(red: 0.267, green: 0.859, blue: 0.369, alpha: 1.000)
        static let defaultThumbColor: UIColor = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000)
        static let defaultStrokeColor: UIColor = UIColor(red: 0.687, green: 0.677, blue: 0.675, alpha: 1.000)
    }

    //// Colors

    class var defaultOnColor: UIColor { return Cache.defaultOnColor }
    class var defaultThumbColor: UIColor { return Cache.defaultThumbColor }
    class var defaultStrokeColor: UIColor { return Cache.defaultStrokeColor }

    //// Drawing Methods

    class func drawSwitchThumb(frame: CGRect = CGRect(x: 0, y: 0, width: 29, height: 29), thumbColor: UIColor = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000)) {
        //// Color Declarations
        let thumbStrokeColor = UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 0.100)

        //// thumb Drawing
        let thumbPath = UIBezierPath(roundedRect: CGRect(x: frame.minX + 0.5, y: frame.minY + 0.5, width: frame.width - 1, height: frame.height - 1), cornerRadius: 14)
        thumbColor.setFill()
        thumbPath.fill()


        //// thumbShadowStroke Drawing
        let thumbShadowStrokePath = UIBezierPath(roundedRect: CGRect(x: frame.minX + 0.5, y: frame.minY + 0.5, width: frame.width - 1, height: frame.height - 1), cornerRadius: 14)
        thumbStrokeColor.setStroke()
        thumbShadowStrokePath.lineWidth = 1
        thumbShadowStrokePath.stroke()
    }

    class func drawSwitchView(frame targetFrame: CGRect = CGRect(x: 0, y: 0, width: 51, height: 31), resizing: ResizingBehavior = .aspectFit, thumbColor: UIColor = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000), fillColor: UIColor = UIColor(red: 0.687, green: 0.677, blue: 0.675, alpha: 1.000), switchOn: CGFloat = 0, tapped: CGFloat = 0, showFilled: CGFloat = 0) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()!
        
        //// Resize to Target Frame
        context.saveGState()
        let resizedFrame: CGRect = resizing.apply(rect: CGRect(x: 0, y: 0, width: 51, height: 31), target: targetFrame)
        context.translateBy(x: resizedFrame.minX, y: resizedFrame.minY)
        context.scaleBy(x: resizedFrame.width / 51, y: resizedFrame.height / 31)



        //// Variable Declarations
        let thumbWidth: CGFloat = 29 * (tapped * 0.2 + 1)
        let thumbPositionX: CGFloat = 1 + (49 - thumbWidth) * switchOn

        //// backgroundView Drawing
        let backgroundViewRect = CGRect(x: 0, y: 0, width: 51, height: 31)
        context.saveGState()
        context.clip(to: backgroundViewRect)
        context.translateBy(x: backgroundViewRect.minX, y: backgroundViewRect.minY)

        UISwitchStyleKit.drawSwitchBackgroundView(frame: CGRect(origin: .zero, size: backgroundViewRect.size), resizing: .stretch, fillColor: fillColor, showFilled: showFilled)
        context.restoreGState()


        //// thumb Drawing
        let thumbRect = CGRect(x: thumbPositionX, y: 1, width: thumbWidth, height: 29)
        context.saveGState()
        context.clip(to: thumbRect)
        context.translateBy(x: thumbRect.minX, y: thumbRect.minY)

        UISwitchStyleKit.drawSwitchThumb(frame: CGRect(x: 0, y: 0, width: thumbRect.width, height: thumbRect.height), thumbColor: thumbColor)
        context.restoreGState()
        
        context.restoreGState()

    }

    class func drawSwitchBackgroundView(frame targetFrame: CGRect = CGRect(x: 0, y: 0, width: 51, height: 31), resizing: ResizingBehavior = .aspectFit, fillColor: UIColor = UIColor(red: 0.687, green: 0.677, blue: 0.675, alpha: 1.000), showFilled: CGFloat = 0) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()!
        
        //// Resize to Target Frame
        context.saveGState()
        let resizedFrame: CGRect = resizing.apply(rect: CGRect(x: 0, y: 0, width: 51, height: 31), target: targetFrame)
        context.translateBy(x: resizedFrame.minX, y: resizedFrame.minY)
        context.scaleBy(x: resizedFrame.width / 51, y: resizedFrame.height / 31)


        //// switchFill Drawing
        context.saveGState()
        context.setAlpha(showFilled)

        let switchFillPath = UIBezierPath(roundedRect: CGRect(x: 0.9, y: 0.8, width: 49.3, height: 29.3), cornerRadius: 14.65)
        fillColor.setFill()
        switchFillPath.fill()

        context.restoreGState()


        //// switchStroke Drawing
        let switchStrokePath = UIBezierPath(roundedRect: CGRect(x: 0.9, y: 0.8, width: 49.3, height: 29.3), cornerRadius: 14.65)
        fillColor.setStroke()
        switchStrokePath.lineWidth = 1.5
        switchStrokePath.stroke()
        
        context.restoreGState()

    }
    
    public enum ResizingBehavior: Int {
        case aspectFit /// The content is proportionally resized to fit into the target rectangle.
        case aspectFill /// The content is proportionally resized to completely fill the target rectangle.
        case stretch /// The content is stretched to match the entire target rectangle.
        case center /// The content is centered in the target rectangle, but it is NOT resized.

        public func apply(rect: CGRect, target: CGRect) -> CGRect {
            if rect == target || target == CGRect.zero {
                return rect
            }

            var scales = CGSize.zero
            scales.width = abs(target.width / rect.width)
            scales.height = abs(target.height / rect.height)

            switch self {
                case .aspectFit:
                    scales.width = min(scales.width, scales.height)
                    scales.height = scales.width
                case .aspectFill:
                    scales.width = max(scales.width, scales.height)
                    scales.height = scales.width
                case .stretch:
                    break
                case .center:
                    scales.width = 1
                    scales.height = 1
            }

            var result = rect.standardized
            result.size.width *= scales.width
            result.size.height *= scales.height
            result.origin.x = target.minX + (target.width - result.width) / 2
            result.origin.y = target.minY + (target.height - result.height) / 2
            return result
        }
    }
}

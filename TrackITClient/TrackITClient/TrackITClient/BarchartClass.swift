//
// File         : BarshartClass.swift
// Module       : TrackITClient
//
// Team Name    : Group 9
// Created By   : Jack Wright
// Created On   : 2018-07-01
//
// Edited By    : Jeremy Schwartz
// Edited On    : 2018-07-03
//  - Updated Header
//

import Foundation
import UIKit

struct BarEntry {
    let color: UIColor
    
    /// Ranged from 0.0 to 1.0
    let height: Float
    
    /// To be shown on top of the bar
    let textValue: String
    
    /// To be shown at the bottom of the bar
    let title: String
}
import UIKit

class BasicBarChart: UIView {
    
    /// the width of each bar
    let barWidth: CGFloat = 40.0
    
    /// space between each bar
    let space: CGFloat = 30.0
    
    /// space at the bottom of the bar to show the title
    private let bottomSpace: CGFloat = 40.0
    
    /// space at the top of each bar to show the value
    private let topSpace: CGFloat = 40.0
    
    /// contain all layers of the chart
    private let mainLayer: CALayer = CALayer()
    
    /// contain mainLayer to support scrolling
    private var scrollView: UIView = UIView()
    
    var dataEntries: [BarEntry]? = nil {
        didSet {
            
            if let dataEntries = dataEntries {
                
                mainLayer.frame = CGRect(x: -20, y: 0, width: (barWidth*5)+(space*4), height: 400)
                
                drawHorizontalLines()
                
                for i in 0..<dataEntries.count {
                    showEntry(index: i, entry: dataEntries[i])
                }
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView() {
        scrollView.layer.addSublayer(mainLayer)
        self.addSubview(scrollView)
    }
    
    override func layoutSubviews() {
        scrollView.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
    }
    
    private func showEntry(index: Int, entry: BarEntry) {
        /// Starting x postion of the bar
        let xPos: CGFloat = space + CGFloat(index) * (barWidth + space)
        
        /// Starting y postion of the bar
        let yPos: CGFloat = translateHeightValueToYPosition(value: entry.height)
        
        drawBar(xPos: xPos, yPos: yPos, color: entry.color)
        
        /// Draw text above the bar
        drawTextValue(xPos: xPos - space/2, yPos: yPos - 30, textValue: entry.textValue, color: entry.color)
        
        /// Draw text below the bar
        drawTitle(xPos: xPos - space/2, yPos: mainLayer.frame.height - bottomSpace + 10, title: entry.title, color: entry.color)
    }
    
    private func drawBar(xPos: CGFloat, yPos: CGFloat, color: UIColor) {
        let barLayer = CALayer()
        barLayer.frame = CGRect(x: xPos, y: yPos, width: barWidth, height: mainLayer.frame.height - bottomSpace - yPos)
        barLayer.backgroundColor = color.cgColor
        mainLayer.addSublayer(barLayer)
    }
    
    private func drawHorizontalLines() {
        self.layer.sublayers?.forEach({
            if $0 is CAShapeLayer {
                $0.removeFromSuperlayer()
            }
        })
        let horizontalLineInfos = [["value": Float(0.0), "dashed": false], ["value": Float(0.5), "dashed": true], ["value": Float(1.0), "dashed": false]]
        for lineInfo in horizontalLineInfos {
            let xPos = CGFloat(0.0)
            let yPos = translateHeightValueToYPosition(value: (lineInfo["value"] as! Float))
            let path = UIBezierPath()
            path.move(to: CGPoint(x: xPos, y: yPos))
            path.addLine(to: CGPoint(x: scrollView.frame.size.width, y: yPos))
            let lineLayer = CAShapeLayer()
            lineLayer.path = path.cgPath
            lineLayer.lineWidth = 0.5
            if lineInfo["dashed"] as! Bool {
                lineLayer.lineDashPattern = [4, 4]
            }
            lineLayer.strokeColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1).cgColor
            self.layer.insertSublayer(lineLayer, at: 0)
        }
    }
    
    private func drawTextValue(xPos: CGFloat, yPos: CGFloat, textValue: String, color: UIColor) {
        let textLayer = CATextLayer()
        textLayer.frame = CGRect(x: xPos, y: yPos, width: barWidth+space, height: 22)
        textLayer.foregroundColor = color.cgColor
        textLayer.backgroundColor = UIColor.clear.cgColor
        textLayer.alignmentMode = kCAAlignmentCenter
        textLayer.contentsScale = UIScreen.main.scale
        textLayer.font = CTFontCreateWithName(UIFont.systemFont(ofSize: 0).fontName as CFString, 0, nil)
        textLayer.fontSize = 14
        textLayer.string = textValue
        mainLayer.addSublayer(textLayer)
    }
    
    private func drawTitle(xPos: CGFloat, yPos: CGFloat, title: String, color: UIColor) {
        let textLayer = CATextLayer()
        textLayer.frame = CGRect(x: xPos, y: yPos, width: barWidth + space, height: 22)
        textLayer.foregroundColor = color.cgColor
        textLayer.backgroundColor = UIColor.clear.cgColor
        textLayer.alignmentMode = kCAAlignmentCenter
        textLayer.contentsScale = UIScreen.main.scale
        textLayer.font = CTFontCreateWithName(UIFont.systemFont(ofSize: 0).fontName as CFString, 0, nil)
        textLayer.fontSize = 14
        textLayer.string = title
        mainLayer.addSublayer(textLayer)
    }
    
    private func translateHeightValueToYPosition(value: Float) -> CGFloat {
        let height: CGFloat = CGFloat(value) * (mainLayer.frame.height - bottomSpace - topSpace)
        return mainLayer.frame.height - bottomSpace - height
    }
}

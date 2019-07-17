//
//  ChartFactory.swift
//  Lotto
//
//  Created by Exey Panteleev on 17/03/16.
//  Copyright © 2016 Mozgazm. All rights reserved.
//

import Foundation
import PNChartSwift

class ChartFactory {
    
    static func addSumBarChart(xPos:CGFloat, yPos:CGFloat, ssd:SumsStatsData, color:UIColor, ctrl:SumsViewController)->PNBarChart {
        let barChart = PNBarChart(frame: CGRectMake(xPos, yPos, Conf.SUMS_WIDTH, ctrl.view.frame.height/2.3))
        barChart.strokeColor = color
        barChart.backgroundColor = UIColor.clearColor()
        // remove for default animation (all bars animate at once)
        barChart.animationType = .Default
        
        barChart.labelFont = UIFont.systemFontOfSize(8.0)
        barChart.labelMarginTop = 3.0
        barChart.xLabels = ssd.dataPoints.map{"\($0)"}
        barChart.yValues = ssd.valuesWithoutImpossible
        barChart.strokeChart()
        
        barChart.delegate = ctrl as PNChartDelegate
        
        ctrl.scrollView.addSubview(barChart)
        
        return barChart
    }
    
    /*static func addSumLineChart(xPos:CGFloat, yPos:CGFloat, ssd:SumsStatsData, color:UIColor, ctrl:UIViewController) {
        var lineChart:PNLineChart = PNLineChart(frame: CGRectMake(xPos, yPos, ctrl.view.frame.width, ctrl.view.frame.height*0.8))
        
        ssd.valuesWithoutImpossible
        
        lineChart.yLabelFormat = "%1d"
        lineChart.showLabel = true
        lineChart.backgroundColor = UIColor.clearColor()
        lineChart.xLabels = ssd.dataPoints.map{"\($0)"}
        lineChart.showCoordinateAxis = true
        lineChart.delegate = ctrl as! PNChartDelegate
        
        // Line Chart Nr.1
        let data01Array = ssd.valuesWithoutImpossible
        var data01:PNLineChartData = PNLineChartData()
        data01.color = color
        data01.itemCount = data01Array.count
        data01.inflexionPointStyle = PNLineChartData.PNLineChartPointStyle.PNLineChartPointStyleCycle
        data01.getData = ({(index: Int) -> PNLineChartDataItem in
            var yValue:CGFloat = CGFloat(data01Array[index])
            var item = PNLineChartDataItem(y: yValue)
            return item
        })
        
        lineChart.chartData = [data01]
        lineChart.strokeChart()
        
        ctrl.view.addSubview(lineChart)
    }*/
    
    static func addFrequencyBarChart(xPos:CGFloat, yPos:CGFloat, vfsd:ValueFrequencyStatsData, color:UIColor?, ctrl:UIViewController)->PNBarChart {
        let barChart = PNBarChart(frame: CGRectMake(xPos, yPos, ctrl.view.frame.width, ctrl.view.frame.height/2.3))
        
        if color == nil {
            barChart.strokeColor = UIColor.blackColor()
            var arr = [UIColor]()
            for i in 1...36 { arr.append(StyleManager.getHotColorByNumber(i)) }
            barChart.strokeColors = arr
        } else {
            barChart.strokeColor = color!
        }
        
        
        barChart.backgroundColor = UIColor.clearColor()
        // remove for default animation (all bars animate at once)
        barChart.animationType = .Default
        
        barChart.labelMarginTop = 3.0
        barChart.xLabels = vfsd.dataPoints.map{"\($0)"}
        barChart.yValues = vfsd.valuesWithoutZero
        
        print("BARS \(barChart.bars)")
        /*for i in 0..<36 {
            //for b in barChart.bars {
            var bar = barChart.bars[i] as! PNBar
            let c = StyleManager.getHotColorByDistance(Double(vfsd.values[i]), maxDistance: Conf.HOT_DISTANCE)
            bar.chartLine.fillColor = c.CGColor
            bar.barColor = c
            print("\(i) - \(c) - \(bar)")
        }*/
        
        barChart.strokeChart()
        barChart.delegate = ctrl as! PNChartDelegate
        
        
        ctrl.view.addSubview(barChart)
        
        return barChart
    }
    
}
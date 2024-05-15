//
//  customChartView.swift
//  SecondRecap
//
//  Created by Greed on 5/15/24.
//

import UIKit
import DGCharts

class CustomChartView: BaseView {
    
    let chart = LineChartView()
    
    override func configureHierarchy() {
        addSubview(chart)
    }
    
    override func configureLayout() {
        chart.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
    }
    
    func configureChart(_ item: CoinMarket) {
        var entries: [ChartDataEntry] = []
        var xValue: Double = 0
        for y in item.sparkline.price {
            xValue += 1
            entries.append(ChartDataEntry(x: xValue, y: y))
        }
        
        let dataSet = LineChartDataSet(entries: entries)
        //chart의 곡선
        dataSet.mode = LineChartDataSet.Mode.cubicBezier
        dataSet.mode = LineChartDataSet.Mode.horizontalBezier
        dataSet.cubicIntensity = 1.0
        //chart의 그라디언트 컬러 설정
        dataSet.gradientPositions = [0, 40, 100]
        dataSet.fillAlpha = 1
        dataSet.drawFilledEnabled = true
        let gradientColor = [UIColor.customWhite.cgColor, UIColor.primary.cgColor]
        let gradient = CGGradient(colorsSpace: nil, colors: gradientColor as CFArray, locations: nil)!
        dataSet.fill = LinearGradientFill(gradient: gradient, angle: 90)
        //chart의 원 설정
        dataSet.drawCirclesEnabled = false
        dataSet.drawCircleHoleEnabled = false
        //chart의 line 설정
        dataSet.setColor(.primary)
        dataSet.lineWidth = 2
        //chart의 각 점의 값 표시 끄기
        dataSet.drawValuesEnabled = false
        dataSet.highlightEnabled = true
        //highlight 가로 세로선 색
        dataSet.highlightColor = .clear
        
        //dataSet 집어 넣기
        let data = LineChartData(dataSet: dataSet)
        chart.data = data
        chart.dragEnabled = true
        //zoom 허용 x
        chart.pinchZoomEnabled = false
        chart.doubleTapToZoomEnabled = false
        //chart line 제거
        chart.xAxis.drawGridLinesEnabled = false // 세로 줄 없애기
        chart.leftAxis.drawGridLinesEnabled = false // 가로 줄 없애기
        chart.rightAxis.drawGridLinesEnabled = false
        chart.xAxis.drawAxisLineEnabled = false // x축 제거
        chart.leftAxis.drawAxisLineEnabled = false // y축 제거
        chart.rightAxis.drawAxisLineEnabled = false
        chart.xAxis.drawLabelsEnabled = false // x축 데이터 레이블 값 제거
        chart.leftAxis.drawLabelsEnabled = false // y축 데이터 레이블 값 제거
        chart.rightAxis.drawLabelsEnabled = false
        //chart 범례 제거
        chart.legend.enabled = false
        //drag시 해당하는 좌표 하이라이트 기능
        chart.highlightPerTapEnabled = false
        chart.highlightPerDragEnabled = false
        chart.drawMarkers = false
        chart.gridBackgroundColor = .clear
    }
    
}



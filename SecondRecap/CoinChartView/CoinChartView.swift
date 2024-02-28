//
//  CoinChartView.swift
//  SecondRecap
//
//  Created by Greed on 2/27/24.
//

import UIKit
import SnapKit
import DGCharts

final class CoinChartView: BaseView {
    
    let icon = UIImageView()
    let coinName = UILabel()
    let price = UILabel()
    let changePercentage = UILabel()
    let dateText = UILabel()
    private let todayHighLabel = UILabel()
    let todayHighPrice = UILabel()
    private let allTimeHighLabel = UILabel()
    let allTimeHighPrice = UILabel()
    private let todayLowLabel = UILabel()
    let todayLowPrice = UILabel()
    private let allTimeLowLabel = UILabel()
    let allTimeLowPrice = UILabel()
    let chart = LineChartView()
    let updateLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureHierarchy() {
        addSubviews([icon, coinName, price, changePercentage, dateText, todayHighLabel, todayHighPrice, allTimeHighLabel, allTimeHighPrice, todayLowLabel, todayLowPrice, allTimeLowLabel, allTimeLowPrice, chart, updateLabel])
    }
    
    override func configureLayout() {
        icon.snp.makeConstraints { make in
            make.leading.equalTo(safeAreaLayoutGuide).offset(8)
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.size.equalTo(40)
        }
        
        coinName.snp.makeConstraints { make in
            make.top.equalTo(icon.snp.top)
            make.leading.equalTo(icon.snp.trailing).offset(4)
        }
        
        price.snp.makeConstraints { make in
            make.top.equalTo(icon.snp.bottom).offset(20)
            make.leading.equalTo(icon)
        }
        
        changePercentage.snp.makeConstraints { make in
            make.leading.equalTo(icon)
            make.top.equalTo(price.snp.bottom).offset(4)
        }
        
        dateText.snp.makeConstraints { make in
            make.leading.equalTo(changePercentage.snp.trailing).offset(8)
            make.top.equalTo(changePercentage)
        }
        
        todayHighLabel.snp.makeConstraints { make in
            make.leading.equalTo(icon).offset(4)
            make.top.equalTo(changePercentage.snp.bottom).offset(20)
        }
        
        todayHighPrice.snp.makeConstraints { make in
            make.leading.equalTo(icon).offset(4)
            make.top.equalTo(todayHighLabel.snp.bottom).offset(8)
        }
        
        todayLowLabel.snp.makeConstraints { make in
            make.leading.equalTo(safeAreaLayoutGuide.snp.centerX).offset(4)
            make.top.equalTo(todayHighLabel)
        }
        
        todayLowPrice.snp.makeConstraints { make in
            make.leading.equalTo(safeAreaLayoutGuide.snp.centerX)
            make.top.equalTo(todayHighPrice)
        }
        
        allTimeHighLabel.snp.makeConstraints { make in
            make.leading.equalTo(todayHighLabel)
            make.top.equalTo(todayHighPrice.snp.bottom).offset(16)
        }
        
        allTimeHighPrice.snp.makeConstraints { make in
            make.leading.equalTo(todayHighPrice)
            make.top.equalTo(allTimeHighLabel.snp.bottom).offset(8)
        }
        
        allTimeLowLabel.snp.makeConstraints { make in
            make.leading.equalTo(todayLowLabel.snp.leading)
            make.top.equalTo(allTimeHighLabel)
        }
        
        allTimeLowPrice.snp.makeConstraints { make in
            make.leading.equalTo(todayLowPrice.snp.leading)
            make.top.equalTo(allTimeHighPrice)
        }
        
        
        chart.snp.makeConstraints { make in
            make.top.equalTo(allTimeLowPrice.snp.bottom).offset(4)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(-10)
            make.bottom.equalTo(safeAreaLayoutGuide).inset(40)
        }
    
        updateLabel.snp.makeConstraints { make in
            make.trailing.equalTo(safeAreaLayoutGuide).inset(4)
            make.top.equalTo(chart.snp.bottom).offset(4)
        }
    }
    
    override func configureView() {
        configureChart()
        icon.image = UIImage(systemName: "person")
        coinName.text = "Solana"
        coinName.font = .boldSystemFont(ofSize: 32)
        price.text = "₩88,888,888"
        price.font = .boldSystemFont(ofSize: 32)
        changePercentage.text = "+3.22%"
        guard let text = changePercentage.text?.first else { return }
        changePercentage.textColor = text == "+" ? .redForHigh : .blueForLow
        changePercentage.font = .systemFont(ofSize: 18)
        dateText.font = .systemFont(ofSize: 18)
        dateText.text = "Today"
        dateText.textColor = .customGray
        todayHighLabel.text = "고가"
        todayHighLabel.textColor = .redForHigh
        todayHighLabel.font = .boldSystemFont(ofSize: 20)
        todayHighPrice.text = "₩69,234,423"
        todayHighPrice.textColor = .customLightBlack
        todayHighPrice.font = .systemFont(ofSize: 20)
        todayLowLabel.font = .boldSystemFont(ofSize: 20)
        todayLowLabel.text = "저가"
        todayLowLabel.textColor = .blueForLow
        todayLowPrice.text = "₩56,234,645"
        todayLowPrice.textColor = .customLightBlack
        todayLowPrice.font = .systemFont(ofSize: 20)
        allTimeHighLabel.text = "신고점"
        allTimeHighLabel.textColor = .redForHigh
        allTimeHighLabel.font = .boldSystemFont(ofSize: 20)
        allTimeHighPrice.text = "₩2,869,234,423"
        allTimeHighPrice.textColor = .customLightBlack
        allTimeHighPrice.font = .systemFont(ofSize: 20)
        allTimeLowLabel.text = "신저점"
        allTimeLowLabel.textColor = .blueForLow
        allTimeLowLabel.font = .boldSystemFont(ofSize: 20)
        allTimeLowPrice.text = "₩34,423"
        allTimeLowPrice.textColor = .customLightBlack
        allTimeLowPrice.font = .systemFont(ofSize: 20)
        updateLabel.text = "2/21 11:53:50 업데이트"
        updateLabel.textColor = .customGray
        updateLabel.font = .boldSystemFont(ofSize: 14)
    }
    
    private func configureChart() {
        let entries = [
            ChartDataEntry(x: 1, y: 4),
            ChartDataEntry(x: 2, y: 10),
            ChartDataEntry(x: 3, y: 7),
            ChartDataEntry(x: 4, y: 5),
            ChartDataEntry(x: 5, y: 6),
            ChartDataEntry(x: 6, y: 3),
            ChartDataEntry(x: 7, y: 8),
            ChartDataEntry(x: 8, y: 12),
        ]
        let dataSet = LineChartDataSet(entries: entries)
        //chart의 곡선
        dataSet.mode = LineChartDataSet.Mode.cubicBezier
        dataSet.mode = LineChartDataSet.Mode.horizontalBezier
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
        chart.highlightPerTapEnabled = true
        chart.highlightPerDragEnabled = true
        chart.drawMarkers = true
        let circleMarker = CircleMarker(color: .primary)
        circleMarker.chartView = chart
        chart.marker = circleMarker
        //chart 실행시 에니메이션
        chart.animate(xAxisDuration: 1, easingOption: .easeInCubic)
        //TODO: chart highlight line 제거 하기
    }
    
}

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

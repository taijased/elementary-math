//
//  SettingRangeSeekSliderDelegate.swift
//  ElementaryMath
//
//  Created by Maxim Spiridonov on 23/03/2019.
//  Copyright © 2019 Maxim Spiridonov. All rights reserved.
//

import CoreGraphics

public protocol SettingRangeSeekSliderDelegate: class {

    func rangeSeekSlider(_ slider: SettingRangeSeekSlider, didChange minValue: CGFloat, maxValue: CGFloat)
    func didStartTouches(in slider: SettingRangeSeekSlider)
    func didEndTouches(in slider: SettingRangeSeekSlider)
    func rangeSeekSlider(_ slider: SettingRangeSeekSlider, stringForMinValue minValue: CGFloat) -> String?
    func rangeSeekSlider(_ slider: SettingRangeSeekSlider, stringForMaxValue: CGFloat) -> String?
}



public extension SettingRangeSeekSliderDelegate {
    
    func rangeSeekSlider(_ slider: SettingRangeSeekSlider, didChange minValue: CGFloat, maxValue: CGFloat) {}
    func didStartTouches(in slider: SettingRangeSeekSlider) {}
    func didEndTouches(in slider: SettingRangeSeekSlider) {}
    func rangeSeekSlider(_ slider: SettingRangeSeekSlider, stringForMinValue minValue: CGFloat) -> String? { return nil }
    func rangeSeekSlider(_ slider: SettingRangeSeekSlider, stringForMaxValue maxValue: CGFloat) -> String? { return nil }
}


//
//  ViewController.swift
//  DayNightDemoSwift
//
//  Created by lvpengwei on 2019/4/10.
//  Copyright © 2019 lvpengwei. All rights reserved.
//

import UIKit
import LVThemeKit

class ViewController: UIViewController {
    @IBOutlet weak var changeBtn: UIButton!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var slider: UISlider!
    override func viewDidLoad() {
        super.viewDidLoad()
        label.viewTK.theme.backgroundColor = LVThemeColor.background
        label.labelTK.theme.textColor = LVThemeColor.font
        slider.sliderTK.theme.minimumTrackTintColor = LVThemeColor.backgroundLight
        slider.sliderTK.theme.maximumTrackTintColor = LVThemeColor.highlight
        changeBtn.buttonTK.theme.setTitle(LVThemeString.dayNightString, for: .normal)
        changeBtn.buttonTK.theme.setImage(LVThemeImage.dayNightImage, for: .normal)
        imageView.imageTK.theme.image = LVThemeImage.dayNightImage
    }
    @IBAction func changeAction(_ sender: Any) {
        DayNightManager.change()
    }
}

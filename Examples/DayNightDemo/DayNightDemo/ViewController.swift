//
//  ViewController.swift
//  DayNightDemo
//
//  Created by lvpengwei on 2019/4/9.
//  Copyright © 2019 lvpengwei. All rights reserved.
//

import UIKit
import LVThemeKit

class ViewController: UIViewController {
    @IBOutlet weak var openNewBtn: UIButton!
    @IBOutlet weak var switchBtn: UIButton!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var testView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var slider: UISlider!
    override func viewDidLoad() {
        super.viewDidLoad()
        switchBtn.viewTK.theme.tintColor = LVThemeColor.highlight
        switchBtn.buttonTK.theme.setImage(LVThemeImage.dayNightImage, for: .normal)
        switchBtn.buttonTK.theme.setTitle(LVThemeString.dayNightString, for: .normal)
        label.labelTK.theme.textColor = LVThemeColor.font
        label.viewTK.theme.backgroundColor = LVThemeColor.background
        testView.layer.borderWidth = 1
        testView.layer.layerTK.theme.borderColor = LVThemeColor.highlight
        imageView.imageTK.theme.image = LVThemeImage.dayNightImage
        slider.sliderTK.theme.minimumTrackTintColor = LVThemeColor.background
        slider.sliderTK.theme.maximumTrackTintColor = LVThemeColor.highlight
    }
    @IBAction func switchAction(_ sender: Any) {
        DayNightManager.change()
    }
    @IBAction func openAction(_ sender: Any) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = [sb .instantiateViewController(withIdentifier: "ViewController")].first else { return }
        navigationController?.pushViewController(vc, animated: true)
    }
}

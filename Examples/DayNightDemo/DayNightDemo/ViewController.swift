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
    override func viewDidLoad() {
        super.viewDidLoad()
        switchBtn.buttonTK.theme.setTitle(LVThemeString.dayNightString, for: .normal)
        label.labelTK.theme.textColor = LVThemeColor.font
        label.viewTK.theme.backgroundColor = LVThemeColor.background
        testView.layer.borderWidth = 1
        testView.layer.layerTK.theme.borderColor = LVThemeColor.highlight
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

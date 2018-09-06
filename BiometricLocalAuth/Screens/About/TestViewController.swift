//
//  TestViewController.swift
//  BiometricLocalAuth
//
//  Created by Eugene Lezov on 06.09.2018.
//  Copyright © 2018 Eugene Lezov. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {
    
    var button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.height.equalTo(300)
            make.width.equalTo(300)
        }
        
        button.rx.tap
            .subscribe { [weak self] (event) in
               self?.dismiss(animated: true, completion: nil)
            }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  ViewController.swift
//  LaunchAnotherApp
//
//  Created by 최영준 on 2018. 6. 9..
//  Copyright © 2018년 최영준. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func launchAnotherApp(_ sender: UIButton) {
        // 실행할 애플리케이션의 URLScheme
        let launchURL = URL(string: "instagram:")!
        // 다운로드할 애플리케이션의 URL
        let downloadURL = URL(string: "https://itunes.apple.com/kr/app/instagram/id389801252?mt=8")!
        
        let application = UIApplication.shared
        
        // 실행하려는 애플리케이션이 현재 기기에 존재할 경우
        if application.canOpenURL(launchURL) {
            let alert = UIAlertController(title: nil, message: "다른 앱을 실행하시겠습니까?", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "확인", style: .cancel) { (_) in
                application.open(launchURL, options: [:], completionHandler: nil)
            }
            alert.addAction(okAction)
            present(alert, animated: false)
        // 현재 기기에 존재하지 않을 경우
        } else {
            let alert = UIAlertController(title: nil, message: "앱스토어로 이동하시겠습니까?", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "확인", style: .cancel) { (_) in
                application.open(downloadURL, options: [:], completionHandler: nil)
            }
            alert.addAction(okAction)
            present(alert, animated: false)
        }
    }
}


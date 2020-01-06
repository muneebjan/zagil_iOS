//
//  PublishViewController.swift
//  CYLTabbarController-Swift
//  v1.16.0 Created by 微博@iOS程序犭袁 ( http://weibo.com/luohanchenyilong/ ) on 10/20/15.
//  Copyright © 2018 https://github.com/ChenYilong . All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController {

//    var confirmButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.backgroundColor = .blue
//        button.setTitle("Click Me", for: .normal)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.setTitleColor(UIColor.white, for: .normal)
////        button.layer.cornerRadius = 50/2
//        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
//        button.addTarget(self, action: #selector(handleConfirmButton), for:.touchUpInside)
//        return button
//    }()
    
//    @objc func handleConfirmButton(){
//        print("button Pressed")
//
//        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let newViewController = storyBoard.instantiateViewController(withIdentifier: "myViewController") as! myViewController
//        self.cyl_push(newViewController, animated: true)
//
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.red
//        setupView()
        
        // Do any additional setup after loading the view.
    }

//    func setupView() {
//        view.addSubview(confirmButton)
//        
//        confirmButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
//        confirmButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        confirmButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
//        confirmButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
//    }
    
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

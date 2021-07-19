//
//  ViewController.swift
//  hello
//
//  Created by 소프트웨어컴퓨터 on 2021/05/02.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var lblHello: UILabel!
    @IBOutlet var txtName: UITextField?
    @IBAction func btnSend(_ sender: Any) {
        lblHello.text="Hello, "+(txtName?.text)!
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let l = UILabel()
        l.frame = CGRect(x: 10, y: 100, width: 100, height: 50)
        l.text = "Hello"
        l.textColor = UIColor.red
        l.backgroundColor = .blue
        view.addSubview(l)
    }


}


//
//  DetailViewController.swift
//  MovieKES
//
//  Created by 소프트웨어컴퓨터 on 2021/06/08.
//

import UIKit
import WebKit    //웹뷰 사용위해  import 시켜야함

class DetailViewController: UIViewController {

    //@IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var webView: WKWebView!
    
    var movieName = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        //nameLabel.text = movieName
        navigationItem.title = movieName        //네비게이션에 넘긴 movieName표시
        self.navigationController?.navigationBar.tintColor = .red   //네비게이션 글자 색 빨강
    
        let urlKorString = "https://search.naver.com/search.naver?where=nexearch&sm=top_hty&fbm=0&ie=utf8&query="+movieName
        guard let urlString = urlKorString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }   //한글로도 검색이 가능하게끔 하는 인스턴스
        guard let url = URL(string: urlString) else { return }
        //옵셔널 형이기에 제일 간편하고 보기쉬운 guard let 으로 옵셔널바인딩
        let request = URLRequest(url: url)
        webView.load(request)
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

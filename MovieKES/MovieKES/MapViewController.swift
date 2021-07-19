//
//  MapViewController.swift
//  MovieKES
//
//  Created by 소프트웨어컴퓨터 on 2021/06/08.
//

import UIKit
import WebKit

class MapViewController: UIViewController {
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let urlKorString = "https://map.naver.com/v5/search/영화관"
        let urlString = urlKorString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!    //한글 사용을 위해 사용
        guard let url = URL(string: urlString) else { return }  //guard문으로 옵셔널 바인딩
        let request = URLRequest(url: url)
        webView.load(request)       //웹뷰 로드
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

//
//  DrawViewController.swift
//  MovieKES
//
//  Created by 소프트웨어컴퓨터 on 2021/06/09.
//

import UIKit

class DrawViewController: UIViewController {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblTimer: UILabel!
    
    var lastPoint: CGPoint!     //바로 전에 터치하거나 이동한 위치
    var lineSize:CGFloat = 5.0       //선의 두께
    var lineColor = UIColor.red.cgColor     //선의 색상
    //=======그림그리는 변수
    let timeSelector: Selector = #selector(DrawViewController.updateTime)  //타이머가 구동되면 실행함
    let interval = 1.0      //타이머의 간격. 1초
    var count = 0           //타이머가 간격대로 실행되는지 확인하는 변수
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        Timer.scheduledTimer(timeInterval: interval, target: self, selector: timeSelector, userInfo: nil, repeats: true)
        //타이머 설정. (간격, 동작될 view, 타이머가 구동될 때 실행할 함수, 사용자정보, 반복여부)
    }
    
    @objc func updateTime(){
        lblTimer.text = String(count)       //문자열로 변환한 count값을 text속성에 저장
        count = count + 1                   //1 증가
    }
    
    @IBAction func clearingView(_ sender: UIButton) {
        imgView.image = nil
        count = 0           //타이머 0초로 초기화
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first! as UITouch       //현재 발생한 터치 이벤트 가지고 옴
        lastPoint = touch.location(in: imgView)     //터치된 위치를 lastPoint라는 변수에 저장
    }
    
    //사용자가 터치한 손가락을 움직이면 스케치도 따라서 움직이기
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 그림을 그리기 위한 콘텍스트 생성
               UIGraphicsBeginImageContext(imgView.frame.size)
               // 선 색상을 설정
               UIGraphicsGetCurrentContext()?.setStrokeColor(lineColor)
               // 선 끝 모양을 라운드로 설정
               UIGraphicsGetCurrentContext()?.setLineCap(CGLineCap.round)
               // 선 두께를 설정
               UIGraphicsGetCurrentContext()?.setLineWidth(lineSize)
               
               // 현재 발생한 터치 이벤트를 가지고 옴
               let touch = touches.first! as UITouch
               // 터치된 좌표를 currPoint로 가지고 옴
               let currPoint = touch.location(in: imgView)
               
               // 현재 imgView에 있는 전체 이미지를 imgView의 크기로 그림
               imgView.image?.draw(in: CGRect(x: 0, y: 0, width: imgView.frame.size.width, height: imgView.frame.size.height))
               
               // lastPoint 위치로 시작 위치를 이동
               UIGraphicsGetCurrentContext()?.move(to: CGPoint(x: lastPoint.x, y: lastPoint.y))
               // lastPoint에서 currPoint까지 선을 추가
               UIGraphicsGetCurrentContext()?.addLine(to: CGPoint(x: currPoint.x, y: currPoint.y))
               // 추가한 선을 콘텍스트에 그림
               UIGraphicsGetCurrentContext()?.strokePath()
               
               // 현재 콘텍스트에 그려진 이미지를 가지고 와서 이미지 뷰에 할당
               imgView.image = UIGraphicsGetImageFromCurrentImageContext()
               // 그림 그리기를 끝냄
               UIGraphicsEndImageContext()
               
               // 현재 터치된 위치를 lastPoint라는 변수에 할당
               lastPoint = currPoint 
    }
    
    //사용자가 화면에서 손가락을 떼었을 때 스케치 끝
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIGraphicsBeginImageContext(imgView.frame.size)
        UIGraphicsGetCurrentContext()?.setStrokeColor(lineColor)
        UIGraphicsGetCurrentContext()?.setLineCap(CGLineCap.round)      //라인 끝 모양 둥글게
        UIGraphicsGetCurrentContext()?.setLineWidth(lineSize)
        
        let touch = touches.first! as UITouch       //현재 발생한 터치 이벤트 가져오기
        let currPoint = touch.location(in: imgView)
        imgView.image?.draw(in: CGRect(x: 0, y: 0, width: imgView.frame.size.width, height: imgView.frame.size.height))
        UIGraphicsGetCurrentContext()?.move(to: CGPoint(x: lastPoint.x, y: lastPoint.y))        //이전에 이동된 위치인 lastPoint로 시작 위치를 이동.
        UIGraphicsGetCurrentContext()?.addLine(to: CGPoint(x: currPoint.x, y: currPoint.y))
        UIGraphicsGetCurrentContext()?.strokePath()
        
        imgView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
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

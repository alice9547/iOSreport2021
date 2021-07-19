//
//  ViewController.swift
//  MovieKES
//
import UIKit
////////////////////////////////////////////////////////////////////////////////////
struct MovieData : Codable {
    let boxOfficeResult : BoxOfficeResult
}
struct BoxOfficeResult : Codable{
    let dailyBoxOfficeList : [DailyBoxOfficeList]
}
struct DailyBoxOfficeList : Codable {       //사용할 API에서의 필드구조명
    let movieNm : String        //영화이름
    let audiAcc : String        //누적 관객수
    let openDt : String         //개봉일
    let rank : String           //순위
}
/////////////////////////////쉽게 파싱하기 위한 movieData 구조체
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var table: UITableView!      //스토리보드의 테이블뷰를 아웃렛으로 연결
    var movieData : MovieData?
    var movieURL  = "https://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=be9f290cad8d7aa365446464c751d596&targetDt="   //날짜
    //https로 해야 잘됨
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        table.delegate = self           //테이블뷰 위임
        table.dataSource = self         //테이블뷰 데이터소스 사용
        
        movieURL += makeYesterdayString()       //만들어둔 어제 날짜 구하는 함수 호출
        getData()                       //데이터 받기
    }
    func makeYesterdayString() -> String{
        let y = Calendar.current.date(byAdding: .day, value: -1, to: Date())!   //현재 날짜 구하고 그 전날로 수정
        let dateF = DateFormatter()
        dateF.dateFormat = "yyyyMMdd"       //날짜 형식
        let day = dateF.string(from: y)
        return day                          //어제 날짜 반환
    }
    func getData(){
        if let url = URL(string: movieURL){     //url 옵셔널 바인딩
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { [self] (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                if let JSONdata = data{             //옵셔널 바인딩
                    //print(JSONdata, response!)
                    //let dataString = String(data: JSONdata, encoding: .utf8)
                    //print(dataString!)
                    let decoder = JSONDecoder()
                    do{
                        let decodedData = try decoder.decode(MovieData.self, from: JSONdata)
                        //print(decodedData.boxOfficeResult.dailyBoxOfficeList[0].movieMm)
                        //print(decodedData.boxOfficeResult.dailyBoxOfficeList[0].audiCnt)
                        self.movieData = decodedData
                        DispatchQueue.main.async {
                            self.table.reloadData()
                        }
                    }catch{
                        print(error)
                    }
                }
            }
            task.resume()           //일시중단 됐을 경우 다시 시작하는 메서드
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10           //행 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! MyTableViewCell
        //as로 다운캐스팅
        cell.movieName.text = movieData?.boxOfficeResult.dailyBoxOfficeList[indexPath.row].movieNm
        //아웃렛 잡아놓은 레이블에 영화제목 넣기
        
        if let audi = movieData?.boxOfficeResult.dailyBoxOfficeList[indexPath.row].audiAcc { //관객수 옵셔널바인딩
            let numF = NumberFormatter()
            numF.numberStyle = .decimal     //천단위로 , 생성
            let aCount = Int(audi)!     //정수형으로 변환
            let result = numF.string(for: aCount)!+"명"
            cell.audiAcc.text = "누적:\(result)"
        }
        if let date = movieData?.boxOfficeResult.dailyBoxOfficeList[indexPath.row].openDt{  //개봉일 옵셔널 바인딩
            cell.openDt.text = "개봉일 : \(String(describing: date))"  //문자열형으로 개봉일:날짜 형식으로
        }
        cell.rank.text = movieData?.boxOfficeResult.dailyBoxOfficeList[indexPath.row].rank
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let dest = segue.destination as? DetailViewController else {
            return
        }  //바로 끝나기때문에 guard let 으로 옵셔널 언래핑이 좋음
        let myIndexPath = table.indexPathForSelectedRow!    //관계 언래핑
        let row = myIndexPath.row           //row 값을 받아서 해당하는 영화제목을 넘김
        dest.movieName = (movieData?.boxOfficeResult.dailyBoxOfficeList[row].movieNm)!
    }//오버라이드 붙는 이유_이 함수는 UIViewController의 메소드이지만 현재 ViewController에서 사용하기에
    //값 넘기는 메소드 prepare
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1        //반복 섹션개수
    }
    
    //func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //    print(indexPath.description)
   // }   //해당 행열 선택했을시 행열 표시
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            return "박스오피스(영화진흥위원회제공:"+makeYesterdayString()+")"
    }   //위에 헤더에 표시
}

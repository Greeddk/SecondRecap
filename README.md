

# 프로젝트 소개

# 스크린샷
![TodayCoin](https://github.com/Greeddk/TodayCoin/assets/116425551/732ce1dc-6efc-4164-9476-c9b3a25e21a7)

# ‎‎오늘의 코인 - 코인 정보를 실시간으로 확인할 수 있는 앱

## 개발 기간과 v1.0 버전 기능
### 개발 기간
- 2024.02.27 ~ 2024.03.04 (7일)
<br>

### Configuration
- 최소버전 15.0 / 라이트 모드 / 세로 모드 / iOS전용
<br>

### v1.0 기능
1. 코인 / NFT 정보 확인 기능
 - 실시간 인기있는 15개의 코인 리스트
 - 실시간 있기있는 7개의 NFT 리스트
 - 클릭 시 디테일한 코인 정보 제공 
 <br>
 
2. 코인 검색 기능
 - 검색한 알파벳이 포함된 코인 검색 기능
 <br>
 
3. 코인 즐겨찾기 기능
 - 즐겨찾기 한 코인의 정보를 메인페이지나 즐겨찾기 탭에서 확인 가능
 - 차트 제공
 <br>
 

### 기술 스택
 - UIKit / MVVM / Custom Observable
 - SnapKit / CodeBaseUI
 - Realm / Repository Pattern
 - Alamofire / Kingfisher
 - Toast / DGCharts
<br>
<br>

# 구현 고려 사항

### 1. 잦은 시세 변동을 고려

- 잦은 시세 변동을 고려하여 Timer로 일정시간 마다 API 통신을 통한 정보 갱신

### 2. BaseView, BaseViewController 사용

- 코드 재사용성과 일관성을 높이기 위해 BaseView, BaseViewController를 사용하여 공통된 기능과 레이아웃을 관리

### 3. 코인 시세 변동의 시각화

- 코인 시세 변동을 효과적으로 시각화하기 위해 차트 라이브러리를 활용하여 데이터를 시각적으로 표현

### 4. EndPoint 관리

- 다양한 API 엔드포인트를 효율적으로 관리하기 위해, 열거형과 연산 프로퍼티를 활용한 네트워크 요청 구조를 설계

### 5. DB

- 레포지토리 패턴을 사용하여 데이터 소스와 비즈니스 로직을 분리
- 코드의 재사용성을 높이고 유지보수성을 향상

<br>

# 기술적 회고

## 1. 네트워크 Error Handling

 네트워크 통신의 Error에 대한 부분이 print로만 출력하는 방식으로 처리되고 있다. 이로 인해 유저 입장에서 통신이 되지 않더라도 어떤 문제가 앱에서 발생했는지 알 수가 없고 사용자 경험 측면에서도 네트워크 오류에 대한 적절한 피드백이 없으면 사용자 혼란을 야기할 수 있다.
 이를 개선하기 위한 방법으로는 첫째로 네트워크 요청 실패 시 사용자에게 명확한 오류 메시지가 제공되게 하는 것이고 필요하다면 재시도 기능을 구현하는 것이다. 또 하나의 방법은 Result 타입을 활용해 네트워크 요청의 성공과 실패를 명확히 구분하여 유연하게 에러를 처리하는 방법이다. 
 
<details>
<summary>코드 보기</summary>
  
```swift
final class APIManager {
    
    static let shared = APIManager()
    
    func callRequest<T:Decodable>(type: T.Type, api: CoinAPI, completionHandler: @escaping (T) -> Void) {
        
        let url = URLRequest(url: api.endPoint)
        AF.request(url)
            .responseDecodable(of: T.self) { success in
            switch success.result {
            case .success(let success):
                completionHandler(success)
            case .failure(let failure):
                print(failure)
                print(success.response?.statusCode)
            }
        }
    }
    
}
```
개선한 코드
```swift

enum NetworkError: Error {
    case invalidResponse
    case noData
    case decodingError
    case serverError(statusCode: Int)
    case unknownError
}

final class APIManager {
    
    static let shared = APIManager()
    
    func callRequest<T: Decodable>(type: T.Type, api: CoinAPI, completionHandler: @escaping (Result<T, NetworkError>) -> Void) {
        
        let url = URLRequest(url: api.endPoint)
        AF.request(url).responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let data):
                completionHandler(.success(data))
            case .failure:
                if let statusCode = response.response?.statusCode {
                    if (400...499).contains(statusCode) {
                        completionHandler(.failure(.serverError(statusCode: statusCode)))
                    } else if (500...599).contains(statusCode) {
                        completionHandler(.failure(.serverError(statusCode: statusCode)))
                    } else {
                        completionHandler(.failure(.unknownError))
                    }
                } else {
                    completionHandler(.failure(.unknownError))
                }
            }
        }
    }
    
    func handleError(_ error: NetworkError) -> String {
        
        var errorMessage = ""
        
        switch error {
        case .invalidResponse:
            errorMessage = "Invalid response from server."
        case .noData:
            errorMessage = "No data received from server."
        case .decodingError:
            errorMessage = "Failed to decode the data."
        case .serverError(let statusCode):
            errorMessage = "Server error with status code: \(statusCode)."
        case .unknownError:
            errorMessage = "An unknown error occurred."
        }

        return errorMessage
    }

}

```

</details>
<br>

## 2. Timer invalidate

 Timer를 이용해 API 통신을 지속적으로 하는 기능을 구현했다. 하지만 이를 invalidate하지 않아서 타이머가 계속 실행되는 문제가 발생했고 이로 인해 불필요한 네트워크 요청이 계속 발생하여 앱의 성능 저하와 리소스 낭비로 이어질 수 있다.
 이를 개선하기 위해 특정 조건일 때 타이머를 invalidate 해줘야 한다. (예를 들어 사용자가 특정 화면에서 벗어나는 경우) 또한 API 콜수가 제한되어있는 점을 고려하여 서버 통신 주기 역시 적절하게 조절해 과도한 네트워크 요청을 방지해야한다.
 

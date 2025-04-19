# main_api API
**응답 형식을 보고자 하면 test_client를 참고하는게 빠를 수도 있음!**

환경 변수 설정:
- `.env` 파일 생성 후 OPENAI_API_KEY= 추가
## API 명세

### 엔드 포인트
- URL: `http://127.0.0.1:5001/process_image`
- Method: `POST`


### 요청 형식
#### Request Body
```json
{
  "image": "base64로 인코딩된 이미지 문자열",
  "mission": [
    "과학 원리/현상 관련 미션 1",
    "과학 원리/현상 관련 미션 2"
  ],
  "query": "이미지와 관련된 추가 질문 (선택사항)"
}
```

#### 필드 설명
- `image` (필수): JPEG 형식의 이미지를 base64로 인코딩한 문자열
- `mission` (필수): 분석할 과학 원리/현상에 대한 질문들의 배열
- `query` (선택): 이미지와 관련된 추가 질문

### 응답 형식
#### 성공 응답 (200 OK)
```json
{
  "result": {
    "judgement": {
      "0": {
        "success": true/false,
        "description": "분석 결과 설명 (400자 이내)"
      },
      "1": {
        "success": true/false,
        "description": ["원리 설명", "분석결과 설명", "예시1", "예시2", "예시3", "~ 카드를 발견하였습니다!"]
      }
    },
    "query_result": ["query 답변 1문단", "query 답변 2문단", ...]
  }
}
```

#### 응답 필드 설명
- `judgement`: 미션 분석 결과 객체
  - `mission_index`: 미션 배열의 인덱스 (문자열)
    - `success`: 해당 미션의 과학 원리/현상 부합 여부 (boolean)
    - `description`: 분석 설명 (string array, 400자 이내)
      - success가 true일 경우: [과학 원리와 설명]
      - success가 false일 경우: ["원리 설명", "분석결과 설명", "예시1", "예시2", "예시3", "~ 카드를 발견하였습니다!", "카드이름"]
- `query_result`: query에 대한 응답 string array(query가 없을 경우 빈 array)

#ai_router api
## AI엔드포인트(내부에서 처리)
- URL: `http://127.0.0.1:5000/analyze`
- Method: `POST`

# ai_router API
환경 변수 설정:
- `.env` 파일 생성 후 OPENAI_API_KEY= 추가
## API 명세

### 엔드포인트
- URL: `http://127.0.0.1:5000/analyze`
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
        "description": "분석 결과 설명 (400자 이내)"
      }
    },
    "query_result": "query에 대한 응답 (query가 없을 경우 빈 문자열)"
  }
}
```

#### 응답 필드 설명
- `judgement`: 미션 분석 결과 객체
  - 키: 미션 배열의 인덱스 (문자열)
  - `success`: 해당 미션의 과학 원리/현상 부합 여부 (boolean)
  - `description`: 분석 설명 (문자열, 400자 이내)
    - success가 true일 경우: 이미지에서 나타나는 과학 원리와 설명
    - success가 false일 경우: 해당 현상이 나타나지 않는 이유와 과학 원리 설명
- `query_result`: query에 대한 응답 (query가 없을 경우 빈 문자열)

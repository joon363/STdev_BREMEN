import requests
import base64
import os
import json
import re

def clean_json_string(json_str):
    # 실제 JSON 문자열을 찾습니다
    json_match = re.search(r'\{.*\}', json_str, re.DOTALL)
    if json_match:
        json_str = json_match.group()
    
    # 불필요한 이스케이프 문자와 줄바꿈 제거
    json_str = json_str.replace('\\n', ' ')
    json_str = json_str.replace('\\', '')
    json_str = re.sub(r'\s+', ' ', json_str)
    
    return json_str

def test_api():
    try:
        # 현재 디렉토리 출력
        print("현재 디렉토리:", os.getcwd())
        
        # 이미지 파일 존재 확인
        if not os.path.exists("test_image.jpeg"):
            print("에러: test_image.jpeg 파일을 찾을 수 없습니다!")
            return

        # 이미지를 base64로 인코딩
        with open("test_image.jpeg", "rb") as image_file:
            encoded_image = base64.b64encode(image_file.read()).decode('utf-8')

        # API 요청 데이터 - mission을 배열로 변경
        data = {
            "image": encoded_image,
            "mission": [
                "중력에 의한 물체의 낙하 현상이 나타나는가?",
                "관성의 법칙이 나타나는가?",
                "빛의 분광 현상이 나타나는가?"
            ]
        }
        
        # API 호출
        response = requests.post("http://127.0.0.1:5000/analyze", json=data)
        
        # 응답 상태 코드 출력
        print("응답 상태 코드:", response.status_code)
        
        if response.status_code == 200:
            # JSON 문자열 정리
            result = response.json()
            cleaned_json_str = clean_json_string(result['result'])
            
            try:
                # 정리된 문자열을 다시 JSON으로 파싱
                final_result = json.loads(cleaned_json_str)
                
                # 결과 출력
                print("분석 결과:", json.dumps(final_result, indent=2, ensure_ascii=False))
                
                # 정리된 결과를 JSON 파일로 저장
                with open('analysis_result.json', 'w', encoding='utf-8') as f:
                    json.dump(final_result, f, indent=2, ensure_ascii=False)
                print("결과가 analysis_result.json 파일에 저장되었습니다.")
                
            except json.JSONDecodeError as e:
                print("JSON 파싱 에러:", e)
                print("문제의 JSON 문자열:", cleaned_json_str)
            
        else:
            print("에러 응답:", response.text)
            
    except Exception as e:
        print("예외 발생:", str(e))

if __name__ == "__main__":
    test_api()
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

def add_card_message(result, mission_cards):
    """
    success가 True인 미션에 대해 해당하는 카드 획득 메시지를 추가합니다.
    
    Args:
        result (dict): API 응답 결과
        mission_cards (list): 각 미션에 해당하는 카드 이름 리스트
    
    Returns:
        dict: 카드 획득 메시지가 추가된 결과
    """
    if 'judgement' not in result:
        return result
        
    for mission_idx, mission_result in result['judgement'].items():
        if mission_result.get('success', False):
            # 해당 미션의 카드 이름 가져오기
            card_name = mission_cards[int(mission_idx)]
            card_message = f"🎉 축하합니다! '{card_name}'를 획득하셨습니다! 🎊"
            
            # description이 리스트인 경우
            if isinstance(mission_result['description'], list):
                mission_result['description'].append(card_message)
                mission_result['description'].append(card_name)
            # description이 문자열인 경우
            else:
                mission_result['description'] = [
                    mission_result['description'],
                    card_message,
                    card_name
                ]
    
    return result

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

        # API 요청 데이터
        data = {
            "image": encoded_image,
            "mission": [
                "중력에 의한 물체의 낙하 현상이 나타나는가?",
                "관성의 법칙이 나타나는가?",
                "빛의 분광 현상이 나타나는가?"
            ],
            "mission_card": [
                "중력 카드",
                "관성 카드",
                "분광 카드"
            ],
            "query": "이 사진에서 분광이 나타나는 이유는 뭐야?"
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
                final_result = json.loads(cleaned_json_str)
                
                # 카드 획득 메시지 추가 (mission_card 정보 전달)
                final_result = add_card_message(final_result, data['mission_card'])
                
                print("분석 결과:", json.dumps(final_result, indent=2, ensure_ascii=False))
                
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
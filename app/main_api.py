from flask import Flask, request, jsonify
import requests
import base64
import os
import json
import re

app = Flask(__name__)

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

@app.route('/process_image', methods=['POST'])
def process_image():
    try:
        data = request.get_json()
        
        # 필수 파라미터 확인
        required_params = ['image', 'mission', 'mission_card']
        if not all(param in data for param in required_params):
            return jsonify({'error': '필수 파라미터가 누락되었습니다.'}), 400
            
        # query 파라미터가 없으면 빈 문자열로 설정
        if 'query' not in data:
            data['query'] = ""

        # AI 서버로 요청 전송
        ai_response = requests.post("http://127.0.0.1:5000/analyze", json=data)
        
        if ai_response.status_code == 200:
            # JSON 문자열 정리
            result = ai_response.json()
            cleaned_json_str = clean_json_string(result['result'])
            
            try:
                final_result = json.loads(cleaned_json_str)
                
                # 카드 획득 메시지 추가
                final_result = add_card_message(final_result, data['mission_card'])
                
                return jsonify(final_result)
                
            except json.JSONDecodeError as e:
                return jsonify({'error': f'JSON 파싱 에러: {str(e)}'}), 500
            
        else:
            return jsonify({'error': 'AI 서버 응답 에러', 'details': ai_response.text}), ai_response.status_code
            
    except Exception as e:
        return jsonify({'error': str(e)}), 500

if __name__ == '__main__':
    app.run(port=5001)  # AI 서버와 다른 포트 사용
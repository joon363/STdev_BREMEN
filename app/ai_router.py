from flask import Flask, request, jsonify
from openai import OpenAI
import os
from dotenv import load_dotenv
import logging

# 로깅 설정
logging.basicConfig(level=logging.DEBUG)

# 환경 변수 로드
load_dotenv()

# Flask 앱 초기화
app = Flask(__name__)

# API 키 확인
api_key = os.getenv("OPENAI_API_KEY")
if not api_key:
    raise ValueError("OPENAI_API_KEY가 설정되지 않았습니다.")

try:
    # OpenAI 클라이언트 초기화
    client = OpenAI(
        api_key=api_key,
        base_url="https://api.openai.com/v1"  # 기본 URL 명시적 지정
    )
    logging.info("OpenAI 클라이언트 초기화 성공")
except Exception as e:
    logging.error(f"OpenAI 클라이언트 초기화 실패: {str(e)}")
    raise

@app.route('/analyze', methods=['POST'])
def analyze_image():
    try:
        data = request.get_json()
        logging.debug(f"받은 요청 데이터: {data.keys()}")
        
        if not all(key in data for key in ['image', 'mission']):
            return jsonify({'error': '필수 파라미터가 누락되었습니다.'}), 400

        prompt_text = """미션은 과학원리나 현상을 요구하는 부분입니다.
                        첨부된 이미지가 미션에 부합하는 과학원리나 현상인지 판단해주세요.
                        응답형식은 다음의 json 형식으로만 답합니다.

                        json response: {{'0': {'success': true/false, 'description': 'string'}, '1': {'success': true/false, 'description': 'string'}, ...}}

                        응답 형식 설명:
                        - 키는 미션의 인덱스(0부터 시작하는 문자열)입니다.
                        - 각 미션별로 success와 description을 포함하는 객체를 반환합니다.
                        - success는 boolean 값(true/false)입니다.
                        - description은 문자열입니다.

                        판단 기준:
                        - success: 이미지가 해당 미션의 과학원리나 현상을 명확하게 보여주는지를 엄격하게 판단합니다.
                        포괄적이거나 간접적인 연관성이 아닌, 가장 대표적이고 직접적인 과학현상이 나타나야 true입니다.
                        - description:
                        * success가 true일 경우: 이미지에서 과학원리가 나타나는 부분과 해당 과학원리에 대한 설명을 400자 이내로 작성
                        * success가 false일 경우: 해당 과학원리가 나타나지 않는 이유와 해당 과학원리에 대한 설명을 400자 이내로 작성

                        응답은 반드시 위의 json 형식으로만 작성하고, 추가 설명이나 다른 텍스트를 포함하지 마세요."""

        response = client.chat.completions.create(
            model="gpt-4.1",
            messages=[
                {
                    "role": "user",
                    "content": [
                        {
                            "type": "text",
                            "text": f"미션: {data['mission']}\n프롬프트: {prompt_text}"
                        },
                        {
                            "type": "image_url",
                            "image_url": {
                                "url": f"data:image/jpeg;base64,{data['image']}"
                            }
                        }
                    ]
                }
            ],
            max_tokens=500
        )
        
        return jsonify({
            'result': response.choices[0].message.content
        })
        
    except Exception as e:
        logging.error(f"API 호출 중 오류 발생: {str(e)}")
        return jsonify({'error': str(e)}), 500

if __name__ == '__main__':
    app.run(debug=True) 
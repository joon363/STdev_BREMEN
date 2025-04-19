import requests
import base64
import json
import os
from datetime import datetime

class ImageAnalysisClient:
    def __init__(self, server_url="http://127.0.0.1:5001"):
        self.server_url = server_url
        
    def save_result_to_json(self, result, filename=None):
        """
        분석 결과를 JSON 파일로 저장합니다.
        
        Args:
            result (dict): 저장할 분석 결과
            filename (str, optional): 저장할 파일 이름. 없으면 타임스탬프로 생성
        """
        if filename is None:
            # 결과 저장을 위한 디렉토리 생성
            os.makedirs('results', exist_ok=True)
            # 타임스탬프를 이용한 파일명 생성
            timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
            filename = f"results/analysis_result_{timestamp}.json"
            
        with open(filename, 'w', encoding='utf-8') as f:
            json.dump(result, f, indent=2, ensure_ascii=False)
        return filename

    def analyze_image(self, image_path, missions, mission_cards, query=""):
        """
        이미지를 분석하고 결과를 반환합니다.
        
        Args:
            image_path (str): 분석할 이미지 파일 경로
            missions (list): 미션 목록
            mission_cards (list): 미션 카드 목록
            query (str, optional): 추가 질문
            
        Returns:
            tuple: (성공 여부, 결과 또는 에러 메시지)
        """
        try:
            # 이미지를 base64로 인코딩
            with open(image_path, "rb") as image_file:
                encoded_image = base64.b64encode(image_file.read()).decode('utf-8')

            # API 요청 데이터
            data = {
                "image": encoded_image,
                "mission": missions,
                "mission_card": mission_cards,
                "query": query
            }

            # API 호출
            response = requests.post(f"{self.server_url}/process_image", json=data)
            
            if response.status_code == 200:
                result = response.json()
                return True, result
            else:
                return False, f"에러 응답 (코드: {response.status_code}): {response.text}"
                
        except Exception as e:
            return False, f"예외 발생: {str(e)}"

def main():
    # 클라이언트 인스턴스 생성
    client = ImageAnalysisClient()
    
    # 테스트 데이터
    missions = [
        "중력에 의한 물체의 낙하 현상이 나타나는가?",
        "관성의 법칙이 나타나는가?",
        "빛의 분광 현상이 나타나는가?"
    ]
    mission_cards = [
        "중력 카드",
        "관성 카드",
        "분광 카드"
    ]
    query = "이 사진에서 분광이 나타나는 이유는 뭐야?"
    
    # 이미지 분석 실행
    success, result = client.analyze_image(
        "test_image.jpeg",
        missions,
        mission_cards,
        query
    )
    
    if success:
        print("분석 성공!")
        print("분석 결과:", json.dumps(result, indent=2, ensure_ascii=False))
        
        # 결과 저장
        saved_file = client.save_result_to_json(result)
        print(f"결과가 {saved_file}에 저장되었습니다.")
    else:
        print("분석 실패:", result)

if __name__ == "__main__":
    main() 
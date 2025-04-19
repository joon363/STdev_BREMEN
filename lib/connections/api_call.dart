import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:stdev_bremen/models/card_item.dart';
import 'package:stdev_bremen/constants/card_styles.dart';

Future<List<bool>> fetchCardItemsFromApi({
  required String imagePath, // Flutter asset 경로
  required List<String> missions,
  List<String>? missionCards, // 선택 사항
  String? query,
}) async {
  // 이미지 base64 인코딩
  final File imageFile = File(imagePath);
  final Uint8List imageBytes = await imageFile.readAsBytes();
  final String base64Image = base64Encode(imageBytes);


  // 요청 데이터 구성
  final Map<String, dynamic> requestData = {
    "image": base64Image,
    "mission": missions,
    if (missionCards != null) "mission_card": missionCards,
    if (query != null) "query": query,
  };
  print("api call");
  final uri = Uri.parse("http://172.30.1.77:5001/process_image"); // 실제 API 주소로 대체
  final response = await http.post(
    uri,
    headers: {"Content-Type": "application/json"},
    body: jsonEncode(requestData),
  );

  if (response.statusCode != 200) {
    throw Exception('API 요청 실패: ${response.statusCode}');
  }

  final data = jsonDecode(response.body);
  final Map<String, dynamic> judgement = data['judgement'];

  List<bool> results = [];

  for (var entry in judgement.entries) {
    final item = entry.value;
    final bool success = item['success'];
    results.add(success);
  }

  return results;
}

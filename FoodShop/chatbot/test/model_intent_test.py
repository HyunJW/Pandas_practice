from chatbot.Preprocess2 import Preprocess2
from chatbot.IntentModel import IntentModel

p = Preprocess2(word2index_dic='c:/workspace/FoodShop/chatbot/data/chatbot_dict.bin',
                userdic='c:/workspace/FoodShop/chatbot/data/user_dic.tsv')
intent = IntentModel(model_name='c:/workspace/FoodShop/chatbot/model/intent_model.h5',
                     preprocess=p)

# 4가지 유형의 질문 테스트
# 주문
query1 = '오늘 탕수육 주문 가능한가요?'
# 예약
query2 = '다음주 일요일로 변경가능한가요?'
# 기타
query3 = '여행 가고 싶어요.'
# 인사
query4 = '안녕하세요'

querys = [query1, query2, query3, query4]
for query in querys:
    predict = intent.predict_class(query)
    predict_label = intent.labels[predict]
    print(query)
    print('의도 예측 클래스:', predict)
    print('의도 예측 레이블:', predict_label)
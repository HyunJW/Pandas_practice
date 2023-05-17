from chatbot.Preprocess2 import Preprocess2
from chatbot.NerModel import NerModel

p = Preprocess2(word2index_dic='c:/workspace/FoodShop/chatbot/data/chatbot_dict.bin',
                userdic='c:/workspace/FoodShop/chatbot/data/user_dic.tsv')
ner = NerModel(model_name='c:/workspace/FoodShop/chatbot/model/ner_model.h5',
               preprocess=p)
query = '오늘 오전 13시 2분에 탕수육 주문 하고 싶어요'
predicts = ner.predict(query)
tags = ner.predict_tags(query)
print(predicts)
print(tags)
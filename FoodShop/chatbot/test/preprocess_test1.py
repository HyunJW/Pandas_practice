from chatbot.Preprocess1 import Preprocess1
sent = '내일 오전 10시에 자장밥 두그릇 주문이요'
p = Preprocess1(userdic='../data/user_dic.tsv') # 사용자정의사전
pos = p.pos(sent)
keywords = p.get_keywords(pos, without_tag=False)
print(keywords)
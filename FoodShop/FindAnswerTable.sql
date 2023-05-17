SHOW DATABASES;
CREATE DATABASE mychatbotwebmychatbot;
USE mychatbot;
DROP TABLE chatbot_train_data;
CREATE TABLE chatbot_train_data (
	id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
	intent VARCHAR(45),
	ner VARCHAR(45),mychatbot
	QUERY TEXT,
	answer TEXT NOT NULL,
	answer_image VARCHAR(2048)
);

INSERT INTO `chatbot_train_data` (`id`, `intent`, `ner`, `query`, `answer`, `answer_image`) VALUES
   (1, '인사', NULL, '안녕하세요', '네 안녕하세요 :D\n반갑습니다. 저는 챗봇입니다.', 'https://i.imgur.com/UluUFMp.jpg'),
   (2, '인사', NULL, '반가워요', '네 안녕하세요 :D\n반갑습니다. 저는 챗봇입니다.', 'https://i.imgur.com/UluUFMp.jpg'),
   (3, '주문', 'B_FOOD', '{B_FOOD} 주문할게요', '{B_FOOD} 주문 처리 완료되었습니다. \n주문해주셔서 감사합니다.', NULL),
   (4, '주문', 'B_FOOD', '{B_FOOD} 주문할게요', '{B_FOOD} 주문 처리 감사!!', NULL),
   (5, '예약', 'B_DT,B_TI', '{B_DT} 예약', '{B_DT}에 예약 접수 되었습니다.', NULL),
   (6, '욕설', NULL, NULL, '욕하면 나빠요 ㅠ', NULL);

SELECT * FROM chatbot_train_data;

CREATE DATABASE pyweb;

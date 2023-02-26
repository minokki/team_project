DELIMITER $$
DROP PROCEDURE IF EXISTS loopInsert$$
 
CREATE PROCEDURE loopInsert()
BEGIN
    DECLARE i INT DEFAULT 20000;
        
    WHILE i <= 21000 DO
		
        INSERT INTO cmnty_mstr(POST_NO, USER_NO, CMNTY_ID, POST_ID, `SUBJECT`, CONTENT, CRT_DATE, VIEW_COUNT, sum_img)
          VALUES(i, 2, 'ADP_ACT', 'ADT_ING',concat('제목',i-19999), concat('내용',i-19999), NOW(), i-19999, NULL);

					
        SET i = i + 1;
    END WHILE;
END$$
DELIMITER $$


CALL loopInsert;
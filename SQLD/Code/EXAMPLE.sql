USE Kleague;

-- [DML_QUERY, P.19] team_id가 K07인 선수의 아이디, 이름, 백넘버를 출력하시오
SELECT PLAYER_ID, PLAYER_NAME, BACK_NO
FROM PLAYER
WHERE TEAM_ID = 'K07';

-- [DML_QUERY, P.41] 브라질출신 MF와 러시아출신 FW인 선수의 이름, 팀 아이디, 포지션, 국가를 출력하시오.
SELECT PLAYER_NAME, TEAM_ID, POSITION, NATION
FROM PLAYER
WHERE (NATION, POSITION) IN (('브라질', 'MF'), ('러시아', 'FW'));

-- [DML_QUERY, P.44] 장씨 선수의 정보를 출력하세요
SELECT *
FROM PLAYER
WHERE PLAYER_NAME LIKE '장%';

-- [DML_QUERY, P.47] 포지션이 존재하지 않는 선수의 이름과 포지션, 팀 아이디를 출력하세요
SELECT PLAYER_NAME, POSITION, TEAM_ID
FROM PLAYER
WHERE POSITION IS NULL;

-- [(추가)DML_QUERY, P.55] 포지션별 인원수, 키 데이터수, 최대키, 최소키, 평균키를 구하세요
SELECT POSITION, COALESCE(COUNT(*), 0), COALESCE(COUNT(HEIGHT), 0), 
	   MAX(HEIGHT), MIN(HEIGHT), ROUND(AVG(HEIGHT), 2)
FROM PLAYER
GROUP BY POSITION;

-- [DML_QUERY, P.64] 동명이인인 선수이름을 출력하시오
SELECT PLAYER_NAME
FROM PLAYER
GROUP BY PLAYER_NAME HAVING COUNT(*) >= 2;

SELECT PLAYER_NAME, COUNT(*) AS 동명이인수
FROM PLAYER
GROUP BY PLAYER_NAME HAVING 동명이인수 >= 2;

-- [DML_QUERY, P.65] 평균키가 180이상인 포지션을 출력하시오
SELECT POSITION
FROM PLAYER
GROUP BY POSITION HAVING AVG(HEIGHT) >= 180;

-- [DML_QUERY, P.67] 팀별로 각각의 생월에 대한 선수의 평균 키를 구하시오
SELECT TEAM_ID,
	   ROUND(AVG(CASE WHEN MONTH(BIRTH_DATE)=1 THEN HEIGHT END), 2) AS MO1,
       ROUND(AVG(CASE WHEN MONTH(BIRTH_DATE)=2 THEN HEIGHT END), 2) AS MO2,
       ROUND(AVG(CASE WHEN MONTH(BIRTH_DATE)=3 THEN HEIGHT END), 2) AS MO3,
       ROUND(AVG(CASE WHEN MONTH(BIRTH_DATE)=4 THEN HEIGHT END), 2) AS MO4,
       ROUND(AVG(CASE WHEN MONTH(BIRTH_DATE)=5 THEN HEIGHT END), 2) AS MO5,
       ROUND(AVG(CASE WHEN MONTH(BIRTH_DATE)=6 THEN HEIGHT END), 2) AS MO6,
       ROUND(AVG(CASE WHEN MONTH(BIRTH_DATE)=7 THEN HEIGHT END), 2) AS MO7,
       ROUND(AVG(CASE WHEN MONTH(BIRTH_DATE)=8 THEN HEIGHT END), 2) AS MO8,
       ROUND(AVG(CASE WHEN MONTH(BIRTH_DATE)=9 THEN HEIGHT END), 2) AS MO9,
       ROUND(AVG(CASE WHEN MONTH(BIRTH_DATE)=10 THEN HEIGHT END), 2) AS M10,
       ROUND(AVG(CASE WHEN MONTH(BIRTH_DATE)=11 THEN HEIGHT END), 2) AS M11,
       ROUND(AVG(CASE WHEN MONTH(BIRTH_DATE)=12 THEN HEIGHT END), 2) AS M12
FROM PLAYER
GROUP BY TEAM_ID;

-- [DML_QUERY, P.73] 팀별로 각 포지션에 대한 인원수, 그리고 팀의 전체 인원수를 구하시오. 단 데이터가 없는 경우는 0으로 표시한다.
SELECT TEAM_ID, COALESCE(COUNT(PLAYER_ID), 0),
       COALESCE(COUNT(CASE WHEN POSITION = 'MF' THEN PLAYER_ID END), 0) AS 'MF',
       COALESCE(COUNT(CASE WHEN POSITION = 'FW' THEN PLAYER_ID END), 0) AS 'FW',
       COALESCE(COUNT(CASE WHEN POSITION = 'DS' THEN PLAYER_ID END), 0) AS 'DS',
	   COALESCE(COUNT(CASE WHEN POSITION = 'GK' THEN PLAYER_ID END), 0) AS 'GK'
FROM PLAYER
GROUP BY TEAM_ID;

-- [DML_QUERY, P.88] 가장 규모가 큰 3개의 경기장의 아이디, 이름, 좌석수를 출력하시오
SELECT STADIUM_ID, STADIUM_NAME, SEAT_COUNT
FROM STADIUM
ORDER BY SEAT_COUNT DESC, STADIUM_NAME
LIMIT 3;

-- [DML_SingleRowFunction, P.23] 선수의 이름, 출생년도, 출생월, 출생일을 출력하시오
SELECT PLAYER_NAME, YEAR(BIRTH_DATE), MONTH(BIRTH_DATE), DAY(BIRTH_DATE)
FROM PLAYER;

-- [DML_SingleRowFunction, P.28] 선수의 이름과 나이를 출력하시오
SELECT PLAYER_NAME, TIMESTAMPDIFF(YEAR, BIRTH_DATE, NOW())
FROM PLAYER;

-- [DML_SingleRowFunction, P.46] K08팀의 이름과 포지션, 키를 출력하시오. 단 포지션과 키의 정보가 없을 때는 각각 *****, 0 으로 출력하시오
SELECT PLAYER_NAME, COALESCE(POSITION, '*****'), COALESCE(HEIGHT, 0)
FROM PLAYER
WHERE TEAM_ID = 'K08';

-- [DML_SingleRowFunction, P.47] 선수의 이름과 영어이름을 출력하시오. 영어이름이 없으면 닉네임을 출력하시오
SELECT PLAYER_NAME, COALESCE(E_PLAYER_NAME, NICKNAME)
FROM PLAYER;

-- [DML_Algebra P.17] K02 혹은 K07 팀 선수들을 검색 (UNION 사용)
SELECT *
FROM PLAYER
WHERE TEAM_ID = 'K02'
UNION 
SELECT *
FROM PLAYER
WHERE TEAM_ID = 'K07';

-- [DML_Algebra P.22] 소속이 K02 팀이면서 포지션이 GK인 선수들을 검색
SELECT *
FROM PLAYER
WHERE TEAM_ID = 'K02' AND POSITION = 'GK';

-- [DML_Algebra P.25] K02팀이면서 포지션이 MF가 아닌 선수들을 검색
SELECT *
FROM PLAYER
WHERE TEAM_ID = 'K02' AND POSITION <> 'MF';

-- [DML_Algebra P.36] 선수들의 이름, 백넘버, 소속 팀명 및 팀 연고지를 검색
SELECT PLAYER_NAME, BACK_NO, TEAM_NAME, REGION_NAME
FROM PLAYER JOIN TEAM USING (TEAM_ID);

-- [DML_Algebra P.38] 포지션이 ‘GK’인 선수들의 이름, 백넘버, 소속팀명 및 팀 연고지를 검색, 단 백넘버의 오름차순으로 출력
SELECT PLAYER_NAME, BACK_NO, TEAM_NAME, REGION_NAME
FROM PLAYER JOIN TEAM USING (TEAM_ID)
WHERE POSITION = 'GK'
ORDER BY BACK_NO;

-- [DML_Algebra P.41] 선수 이름, 소속 팀, 그 팀의 전용구장 정보를 같이 출력
SELECT PLAYER_NAME, TEAM_NAME, REGION_NAME, STADIUM_NAME, SEAT_COUNT
FROM PLAYER
     JOIN TEAM USING (TEAM_ID)
     JOIN STADIUM USING (STADIUM_ID);

-- [DML_Algebra P.57] GK 포지션의 선수 마다 팀 연고지명, 팀명, 구장명을 출력
SELECT PLAYER_NAME, REGION_NAME, TEAM_ID, STADIUM_NAME
FROM PLAYER
     JOIN TEAM USING (TEAM_ID)
     JOIN STADIUM USING (STADIUM_ID)
WHERE POSITION = 'GK';

-- [DML_Algebra P.59] 홈팀이 3점 이상 차이로 승리한 경기의 경기장 이름, 경기 일정, 홈팀 이름과 원정팀 이름 정보를 출력
SELECT STADIUM_NAME, SCHE_DATE, HT.TEAM_NAME AS HOMETEAM_NAME, AT.TEAM_NAME AS AWAYTEAM_NAME
FROM SCHEDULE AS SC 
	 JOIN TEAM AS HT ON SC.HOMETEAM_ID = HT.TEAM_ID
     JOIN TEAM AS AT ON SC.AWAYTEAM_ID = AT.TEAM_ID
     JOIN STADIUM AS ST ON SC.STADIUM_ID = ST.STADIUM_ID
WHERE HOME_SCORE >= AWAY_SCORE + 3;

WITH TEMP AS (SELECT S.STADIUM_ID, SCHE_DATE, X.TEAM_NAME AS HOMETEAM_NAME, HOME_SCORE, AWAYTEAM_ID, AWAY_SCORE
			  FROM TEAM AS X JOIN SCHEDULE AS S ON X.TEAM_ID = S.HOMETEAM_ID
              WHERE S.HOME_SCORE >= S.AWAY_SCORE + 3),
     TEMP2 AS (SELECT T.STADIUM_ID, SCHE_DATE, HOMETEAM_NAME, HOME_SCORE, X.TEAM_NAME AS AWAYTEAM_NAME, AWAY_SCORE
               FROM TEMP AS T JOIN TEAM AS X ON X.TEAM_ID = T.AWAYTEAM_ID)
SELECT S.STADIUM_NAME, SCHE_DATE, HOMETEAM_NAME, HOME_SCORE, AWAYTEAM_NAME, AWAY_SCORE
FROM TEMP2 AS T JOIN STADIUM AS S USING (STADIUM_ID);

-- [DML_Algebra P.91] 스케줄 테이블에서 경기장 이름, 홈팀 이름, 어웨이팀 이름을 출력하시오
SELECT STADIUM_NAME, HT.TEAM_NAME AS HOMETEAM_NAME, HOME_SCORE, AT.TEAM_NAME AS AWAYTEAM_NAME, AWAY_SCORE
FROM SCHEDULE AS S
     JOIN TEAM AS HT ON S.HOMETEAM_ID = HT.TEAM_ID
     JOIN TEAM AS AT ON S.AWAYTEAM_ID = AT.TEAM_ID
     JOIN STADIUM AS ST ON S.STADIUM_ID = ST.STADIUM_ID;
     
WITH TEMP1 AS (SELECT SC.STADIUM_ID, TEAM_NAME AS 'HOMETEAM_NAME', AWAYTEAM_ID
			   FROM SCHEDULE AS SC JOIN TEAM AS T ON SC.HOMETEAM_ID = T.TEAM_ID),
	 TEMP2 AS (SELECT T1.STADIUM_ID, HOMETEAM_NAME, TEAM_NAME AS 'AWAYTEAM_NAME'
			   FROM TEMP1 AS T1 JOIN TEAM AS T ON T1.AWAYTEAM_ID = T.TEAM_ID)
SELECT STADIUM_NAME, HOMETEAM_NAME, AWAYTEAM_NAME
FROM TEMP2 AS T2 JOIN STADIUM AS S USING (STADIUM_ID);

-- [DML_Algebra P.99] 날짜별 경기수를 출력하시오. 단 누락된 날짜가 없게 하시오
WITH RECURSIVE DATES(D) AS (SELECT CAST(MIN(SCHE_DATE) AS DATE)
							FROM SCHEDULE
                            UNION ALL
                            SELECT D + INTERVAL 1 DAY
                            FROM DATES
                            WHERE D + INTERVAL 1 DAY <= '2012-03-31')
SELECT DATES.D, COALESCE(COUNT(SCHE_DATE), 0) AS NO_OF_GAMES
FROM DATES LEFT JOIN SCHEDULE ON DATES.D = SCHEDULE.SCHE_DATE
GROUP BY DATES.D
ORDER BY DATES.D;
                    
-- [DML_Subquery P.17] 선수들의 평균 키보다 작은 선수들의 이름, 포지션, 백넘버를 출력
SELECT PLAYER_NAME, POSITION, BACK_NO
FROM PLAYER
WHERE HEIGHT <= (SELECT AVG(HEIGHT) FROM PLAYER);

-- [DML_Subquery P.18] 정현수 선수의 소속팀의 연고지명, 팀명, 영문팀명을 출력
SELECT REGION_NAME, TEAM_NAME, E_TEAM_NAME
FROM TEAM
WHERE TEAM_ID = ANY (SELECT TEAM_ID FROM PLAYER WHERE PLAYER_NAME = '정현수');

-- [DML_Subquery P.21] 각 팀에서 제일 키가 작은 선수들의 팀아이디, 선수명, 포지션, 백넘버, 키를 출력
SELECT TEAM_ID, PLAYER_NAME, POSITION, BACK_NO, HEIGHT
FROM PLAYER
WHERE (TEAM_ID, HEIGHT) IN (SELECT TEAM_ID, MIN(HEIGHT) FROM PLAYER GROUP BY TEAM_ID);

-- [DML_Subquery P.25] 각 팀에서 제일 키가 큰 선수들의 팀 아이디, 이름, 키를 출력
SELECT TEAM_ID, PLAYER_NAME, HEIGHT
FROM PLAYER
WHERE (TEAM_ID, HEIGHT) IN (SELECT TEAM_ID, MAX(HEIGHT) FROM PLAYER GROUP BY TEAM_ID);

-- [DML_Subquery P.29] 소속 팀의 평균 키보다 작은 선수들의 팀 아이디, 이름, 포지션, 백넘버, 키를 출력
SELECT TEAM_ID, PLAYER_NAME, POSITION, BACK_NO, HEIGHT
FROM PLAYER AS X
WHERE X.HEIGHT < (SELECT AVG(Y.HEIGHT) FROM PLAYER AS Y WHERE X.TEAM_ID = Y.TEAM_ID)
ORDER BY X.TEAM_ID, X.HEIGHT;

-- [DML_Subquery P.30] 브라질 혹은 러시아 출신 선수가 있는 팀을 검색(연관 서브커리 사용), 팀아이디, 팀명을 출력
SELECT TEAM_ID, TEAM_NAME
FROM TEAM
WHERE TEAM_ID = ANY (SELECT TEAM_ID FROM PLAYER WHERE NATION IN ('브라질', '러시아'));

-- [DML_Subquery P.32] 20120501부터 20120502 사이에 경기가 열렸던 경기장을 조회(연관 서브쿼리 사용), 경기장아이디, 경기장명을 출력
SELECT STADIUM_NAME
FROM STADIUM
WHERE STADIUM_ID IN (SELECT STADIUM_ID FROM SCHEDULE WHERE SCHE_DATE BETWEEN '2012-05-01' AND '2012-05-02');

-- [DML_Subquery P.34] 포지션이 GK인 선수들을 검색(연관 서브쿼리 사용)
SELECT PLAYER_NAME, POSITION
FROM PLAYER AS X
WHERE PLAYER_ID IN (SELECT PLAYER_ID FROM PLAYER WHERE POSITION='GK');

SELECT TEAM_ID, PLAYER_NAME, BACK_NO, HEIGHT
FROM PLAYER AS X
WHERE PLAYER_ID IN (SELECT PLAYER_ID FROM PLAYER AS Y WHERE X.PLAYER_ID = Y.PLAYER_ID AND POSITION = 'GK');

-- [DML_Subquery P.43] 팀 아이디, 선수명, 키, 소속 팀의 평균키를 출력
SELECT TEAM_ID, PLAYER_NAME, HEIGHT,
       (SELECT AVG(HEIGHT) FROM PLAYER AS Y WHERE X.TEAM_ID = Y.TEAM_ID) AS 팀평균키
FROM PLAYER AS X
ORDER BY TEAM_ID;

-- [DML_Subquery P.44] 팀 아이디, 팀명, 팀 인원수를 출력
SELECT TEAM_ID, TEAM_NAME,
       (SELECT COUNT(*) FROM PLAYER AS Y WHERE X.TEAM_ID = Y.TEAM_ID) AS 팀인원수
FROM TEAM AS X
ORDER BY TEAM_ID;

-- [DML_Subquery P.45] 팀 아이디, 팀명, 각 팀의 마지막 경기가 진행된 날짜를 출력
SELECT TEAM_ID, TEAM_NAME,
       (SELECT MAX(SCHE_DATE) FROM SCHEDULE AS Y WHERE X.TEAM_ID = Y.HOMETEAM_ID OR X.TEAM_ID = Y.AWAYTEAM_ID) AS '최종 경기일'
FROM TEAM AS X;

-- [DML_Subquery P.49] 포지션이 MF인 선수들의 소속팀명 및 선수이름과 백넘버를 출력
SELECT TEAM_NAME, PLAYER_NAME, BACK_NO
FROM (SELECT TEAM_ID, PLAYER_NAME, BACK_NO
      FROM PLAYER
	  WHERE POSITION = 'MF') AS P, TEAM AS T
WHERE P.TEAM_ID = T.TEAM_ID
ORDER BY TEAM_NAME, PLAYER_NAME;

-- [DML_Subquery P.50] 키가 제일 큰 5명의 선수들의 이름, 포지션, 백넘버를 출력
SELECT PLAYER_NAME, POSITION, BACK_NO, HEIGHT
FROM (SELECT PLAYER_NAME, POSITION, BACK_NO, HEIGHT
      FROM PLAYER
      WHERE HEIGHT IS NOT NULL
      ORDER BY HEIGHT DESC) AS TEMP
LIMIT 5;

-- [DML_Subquery P.52] K02 팀의 평균키보다 평균키가 작은 팀의 이름과 해당 팀의 평균키르 출력
SELECT TEAM_ID, TEAM_NAME, AVG(HEIGHT)
FROM TEAM JOIN PLAYER USING (TEAM_ID)
GROUP BY TEAM_ID
HAVING AVG(HEIGHT) < (SELECT AVG(HEIGHT) FROM PLAYER WHERE TEAM_ID='K02');



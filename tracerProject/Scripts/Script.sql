SELECT 
    u.TID,
    u.NICKNAME,
    (SUM(CASE WHEN t.ENDYN = 1 THEN 1 ELSE 0 END) * 100 / COUNT(*)) AS PROGRESS
FROM 
    USER_INFO u
JOIN 
    SCHEDULE s ON u.EMAIL = s.EMAIL
JOIN 
    TASK t ON s.SID = t.SID
WHERE 
    u.TID = 11  -- 특정 팀 ID를 선택
GROUP BY 
    u.TID, u.NICKNAME;

ALTER TABLE cjams.snapshothist ADD approvaldate timestamp NULL;


UPDATE cjams.snapshothist 
SET approvaldate = updatedon
WHERE objecttype='SPLAN' AND insertedon BETWEEN '11-01-2019' AND '01-02-2020'


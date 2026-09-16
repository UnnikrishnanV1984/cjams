-- D-32572
UPDATE person 
SET insertedon = insertedon - INTERVAL '4 hour'
WHERE (insertedon < '2019-11-03 06:00:00' AND insertedon > '2019-10-28 00:00:00');

UPDATE person 
SET insertedon = insertedon - INTERVAL '5 hour'
WHERE (insertedon > '2019-11-03 06:00:00' AND insertedon < '2020-03-08 07:00:00');

UPDATE person 
SET insertedon = insertedon - INTERVAL '4 hour'
WHERE (insertedon > '2020-03-08 07:00:00');


UPDATE personrole 
SET updatedon = updatedon - INTERVAL '4 hour'
WHERE (insertedon < '2019-11-03 02:00:00' AND insertedon > '2019-10-28 00:00:00') AND updatedon - insertedon = '04:00:00';

UPDATE personrole
SET updatedon = updatedon - INTERVAL '5 hour'
WHERE (insertedon > '2019-11-03 02:00:00' AND insertedon < '2020-03-08 02:00:00') AND updatedon - insertedon = '05:00:00';

UPDATE personrole 
SET updatedon = updatedon - INTERVAL '4 hour'
WHERE (insertedon > '2020-03-08 02:00:00') AND updatedon - insertedon = '04:00:00';
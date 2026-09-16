
--To be executed in order:
-- 1
UPDATE progressnote
SET contactdate = starttime::date
WHERE 
	contactdate::date > starttime::date 
AND old_id is null
AND insertedon >'2019-10-25';


-- 2
UPDATE progressnote
SET contactdate = contactdate::date
WHERE 
    old_id is null
AND insertedon >'2019-10-25'
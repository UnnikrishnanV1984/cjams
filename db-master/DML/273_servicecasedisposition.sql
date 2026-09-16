UPDATE servicecasedisposition SET activeflag = 0, updatedon =now(), effectivedate = '2010-10-09 14:21:34'
WHERE servicecaseid = 'f0a001f7-39e0-4a12-b521-f5a835b67442' AND intakeserreqstatustypekey ILIKE 'Open'
AND trunc (statusdate) ='2019-10-09';
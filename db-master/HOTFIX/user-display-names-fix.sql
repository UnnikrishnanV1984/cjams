UPDATE userprofile
SET displayname = fullname
WHERE 
fullname NOT ILIKE '%test%' AND 
activeflag = 1;
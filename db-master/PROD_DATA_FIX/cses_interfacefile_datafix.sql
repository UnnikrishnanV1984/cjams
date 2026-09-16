select personid, workphone, updatedby, updatedon
from personemployment
where personemploymentid = '91f7d79b-29b1-4ba9-9413-0f0b3b4acb4f'
and activeflag = 1 ;

update personemployment
set workphone = '3017221007',
updatedby = 'DFX021921',
updatedon = now()
where personemploymentid = '91f7d79b-29b1-4ba9-9413-0f0b3b4acb4f'
 and activeflag = 1 ;
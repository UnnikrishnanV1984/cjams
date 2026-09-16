--D-23208 Adoptive parent is listed twice in the person tab

update adoptioncaseactor set adoptioncaseid = null, updatedon = now() 
WHERE adoptioncaseid = '9cb979e6-0cb8-434d-942e-527269fde518' 
and personid = '18827367-0ffb-434c-a36c-36536b1b1037'

update person set activeflag=0, updatedon=now()  where cjamspid in (70995)
---

update caseassignment c set objecttypekey = 'servicecase' from servicecase s where 
s.servicecaseid = c.objectid ::uuid  and objecttypekey ='servicerequest' and c.activeflag = 1 
and ( c.enddate is null or c.enddate > now() )
--D-23618 a ticket was sent to close this case out in Chessie. Can you close this


update servicecase set enddate = '2014-05-27 13:37:49', dispositioncode ='Closed', updatedon=now(), updatedby = 'D-23618'
where servicecasenumber = '3238808'

update servicecasedisposition set activeflag = 0, updatedon=now(), updatedby = 'D-23618' 
where servicecasedispositionid = 'b40054dd-0b3d-4117-9f46-f502b35a559a'

update caseassignment set objectid = null, activeflag = 0, updatedon=now(), updatedby = 'D-23618' 
where caseassignmentid = '5bd7f15f-26d1-4218-8b28-769910b19403'
/*
   Issue Description: CDM-33459
   Category/ Module  : Approval iNbox
   Root cause: User requested to remve stuck approvalfrom inbox
   Pull request# for code fix: 
   Reason why no related code fix:  code fix done 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

UPDATE cjams.routing
SET activeflag = 0, 
updatedby='CDM-33459',
updatedon=now()
WHERE routingid='5e7dc9c8-0c02-403d-9506-694c42ae37c1' 
and eventcode='CPLAN2' 
and  routingstatustypeid=15 
and activeflag=1 
and servicerequestnumber='3151272';


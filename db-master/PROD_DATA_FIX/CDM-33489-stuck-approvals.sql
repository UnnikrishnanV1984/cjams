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
updatedby='CDM-33489', 
updatedon=now()
WHERE
 routingid in('7cc88970-95bf-4cbc-8ec0-90ed73d5d571',
 '4a4cc78d-ba33-4ce0-a0d8-0d78b5c1b9e5',
 '909afe26-b6e5-4005-950d-4c7da8bebaa1',
 '613da912-d5ba-4ec3-b31a-e75070bbd7e2',
 'da157017-e333-47c3-970d-f1376ac35cf9',
 '34fc7302-b1d7-4e5b-98ce-9df8bb544145')  
and 
 routingstatustypeid=15 and activeflag=1;
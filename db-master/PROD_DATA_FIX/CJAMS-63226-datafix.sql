/*
   Issue Description: CJAMS-63226
   Category/ Module  : Intake
   Root cause: Home health assessment request seen in assessment dashboard, User didnot review the request before closing it
   Fix provided: Data fix has been done to remove the Home health assessment request in assessment dashboard
   Pull request#
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
 Need to do data fix
*/

update routing 
 set activeflag = 0,
     updatedby = 'CJAMS-63226',
     updatedon = now()
where routingid = '16785314-a475-4808-9bed-32c2eb831635'
 and servicerequestnumber = '251023124530'
 and activeflag = 1
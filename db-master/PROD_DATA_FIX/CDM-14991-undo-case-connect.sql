/* Category/ Module  :  case connect
   Root cause: user error
   Pull request# for code fix: 
   Reason why no related code fix: 
   user error requested data fix
*/

update intakeservicerequest 
set servicecaseid = null,
updatedby = 'CDM-14991',
updatedon = now()
where servicerequestnumber = '211020123178';
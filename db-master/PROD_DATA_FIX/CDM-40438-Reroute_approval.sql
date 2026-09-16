/*
Issue Description: Please rerout the placement approval to default supervisor dashboard.
Category/ Module : Bug
Root cause: 
Fix provided: Yes, wrote Db query 
Code fix ticket#: CDM-40438
Reason why no related code fix: Status of the code fix  already submitted 
Status of the code fix if already submitted and expected prod fix date: 
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

 update routing
 set tosecurityusersid='4103969d-6c19-4065-8d86-fa7706680634',updatedby='CDM-40438',updatedon=now()
 where objectid='f7f1e7ae-f2f2-495d-97fb-87cd44227ba4' and activeflag=1 and routingid='2cdd14c7-9064-4786-99a2-811aa1591334';
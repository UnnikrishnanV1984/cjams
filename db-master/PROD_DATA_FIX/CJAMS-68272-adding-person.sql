/*
   Issue Description: CJAMS-68272
   Category/ Module  : person
   Root cause: User is trying to add the person CJAMS PID# 204104046 Hannah Woods
   Fix Provided: Data fix was provided by updating the icwaunderdefinition flag to null of the person CJAMS PID# 204104046 Hannah Woods
   Pull request# 
   code fix: Needed
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update person
set icwaunderdefinition = '', updatedby='CJAMS-68272', updatedon=now()
where cjamspid='204104046' and personid='f221eed9-9e1e-47e8-8015-3631c6944093';
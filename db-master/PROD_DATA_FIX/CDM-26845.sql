/*
   Issue Description: CDM-26845
   Category/ Module  : bug
   Root cause:  need to do data fix to create service case.
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

select *  from 
intakeservicerequest i 
where intakenumber = 'I221010339918';

select * from cjams.createservicecase('524b0db8-6e27-46ac-aa61-4ab7501d8397', 
null, 1, 'ef3032b3-2f5a-4b48-8b27-c33cf654abf6', 'intake', '');
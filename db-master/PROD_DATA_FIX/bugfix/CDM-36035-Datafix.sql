/*
   Issue Description: CDM-36035
   Category/ Module  : Child Welfare
   Root cause: user requeseted to remove as it was duplicate case done in eror
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/
-- Intake is not available in routing,intakesnapshot, Intakeservicerequest, usernotificationmap, usernotification tables so removed from remaining tables.

update cjams.intakedastatus set activeflag =0,updatedby ='CDM-36035', updatedon =now()
where intakenumber ='I231010976778';

update cjams.intakedastaging set activeflag =0,updatedby ='CDM-36035',updatedon =now()
where intakenumber ='I231010976778' and activeflag=1;

update cjams.actor set activeflag =0,updatedby ='CDM-36035',updatedon =now()
where intakenumber ='I231010976778' and activeflag=1;

update cjams.intakeservicerequestactor set activeflag =0,updatedby ='CDM-36035',updatedon =now()
where intakenumber ='I231010976778' and activeflag=1;




update personrole set activeflag=0, updatedby ='CDM-36035', updatedon =now()
where intakenumber ='I231010976778';

update personroletype  set activeflag=0, updatedby ='CDM-36035', updatedon =now()
where  personroleid = '25b9f263-12ea-4071-8632-e672de13ca44';

update actorrelationship set activeflag=0, updatedby ='CDM-36035', updatedon =now()
where intakenumber ='I231010976778';



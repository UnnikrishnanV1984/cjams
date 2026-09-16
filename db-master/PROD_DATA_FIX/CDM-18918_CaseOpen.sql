/* Issue Description:CDM-18918 - CPS-IR Case not available
   Category/ Module  :  Referral screenout/screenin/approved
   Root cause: unable to reproduce this
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 

*/

update cjams.intakeservicerequest
set intakeservicerequestclassid = '3e026a57-247c-4203-82b7-62749c98ccc5', actiontype = 'IR', 
offenselocation =  21061 , isaccepted = null, accepteddate = null, isrouted = false, routedusersid = null, 
updatedby = 'CDM-18918',
updatedon = now()
where servicerequestnumber = '211020160572';

update cjams.intakeservicerequestsdm 
set isfinalscreenin =true, isir= true,
updatedby = 'CDM-18918',
updatedon = now()
where intakeserviceid in ('ca905048-b2e1-4182-bb1e-aa12c860a16f');
	
update cjams.routing 
set activeflag = 0,  updatedby = 'CDM-18918',
updatedon = now() where  routingid = 'a0af7831-05ef-43e8-8a92-7100184874f6';

update caseassignment set enddate = now(), updatedon= now(), updatedby='CDM-18918' 
where objectid = 'ca905048-b2e1-4182-bb1e-aa12c860a16f' 
and caseassignmentid = '4826508b-2635-41b0-aa4a-060714cbc9ac';
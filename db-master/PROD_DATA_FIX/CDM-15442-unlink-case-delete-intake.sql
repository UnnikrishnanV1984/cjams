/*
 Issue Description:CDM-15442
 Category/ Module: Data fix needed
 Root cause: unlink case and delete intake
 Pull request# N/A
 Reason why no related code fix: N/A
 Status of the code fix if already submitted and expected prod fix date: N/A
*/
update intakeservicerequest set servicecaseid=null,updatedby='CDM-15442',updatedon=now() where intakeserviceid='a34596ad-ccf1-42c1-a83f-e7eb3059a660'
and servicecaseid='22a269d9-8ae9-46dd-95f6-1e60f13b8793';
update routing set activeflag=0,updatedon=now(),updatedby='CDM-15442'where objectid='I211010176334';
update intakedastatus set activeflag=0,updatedon=now(),updatedby='CDM-15442'where intakenumber='I211010176334';
update intakedastaging set activeflag=0,updatedon=now(),updatedby='CDM-15442'where intakenumber='I211010176334';
update intakesnapshot set activeflag=0,updatedon=now(),updatedby='CDM-15442'where intakenumber='I211010176334';
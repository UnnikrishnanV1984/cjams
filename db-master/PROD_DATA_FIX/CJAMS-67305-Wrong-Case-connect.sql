/*

Met the user , need to delete case ID - 261030677336 from CJAMS currently it is under to be assigned tab 

also Need to ensure that all Data before 4/20/26 , 3.13pm should be in CPS-IR : 261023720800 case also all summary info regarding start date and Intake information of 261030677336 should be captured before deleting and show in 261030677335, as the user wants to keep the case 261030677335

*/


update intakeservicerequest
set servicecaseid=null, updatedon=now(),updatedby='CJAMS-67305'
where intakenumber='I261013991215' and activeflag=1;


select * from cjams.createservicecase('eb3af294-240b-4d2e-8861-0a33e62b48b8','211a19c2-855a-4424-94e1-8571f8bd5eb8',0,'ef09e223-ee64-46f1-a6b1-c1526029a35f',NULL,'','intake',NULL);


update servicecase
set activeflag=0, updatedon=now(),updatedby='CJAMS-67305'
where servicecasenumber='261030677336' and activeflag=1; 


update servicecasedisposition
set activeflag=0, updatedon=now(),updatedby='CJAMS-67305'
where servicecasedispositionid='6b5f32ec-32e4-48e2-bdb0-f34960492412' and activeflag=1; 




update servicecaserequest
set activeflag=0, updatedon=now(),updatedby='CJAMS-67305'
where servicecaseid='032b9759-c8b1-4b77-ac95-608fc530da3b' and activeflag=1; 

update routing
set activeflag=0, updatedon=now(),updatedby='CJAMS-67305'
where objectid='032b9759-c8b1-4b77-ac95-608fc530da3b' and  activeflag=1; 

/*
 Issue Description:CJAMS-67300
 Category/ Module: Delete Intakes
 Root cause:user requested to delete intakes I221010273152,I221010329782,I221010329623,I211010220575,I211010220574.
 Fix provided: Data fix has been done to delete intakes from cjams
 Is code fix required: N
 Pull request# N/A
 Reason why no related code fix: N/A
 Status of the code fix if already submitted and expected prod fix date: N/A
*/



update intakedastatus 
set activeflag=0,updatedon=now(),updatedby='CJAMS-67300'
where intakenumber in ('I221010273152','I221010329782','I221010329623','I211010220575','I211010220574') and activeflag=1;

update intakedastaging 
set activeflag=0,updatedon=now(),updatedby='CJAMS-67300'
where intakenumber in ('I221010273152','I221010329782','I221010329623','I211010220575','I211010220574') and activeflag=1;
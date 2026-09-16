/*
 Issue Description:CJAMS-65161
 Category/ Module: delete intakes 'I261013869900','I261013860480','I261013672097','I251013565564','I251013447310','I251013341017','I251013331483','I251013323739','I251013309446','I251013308162' Old/incorrect intake 
 needs to be deleted from user roshelle hemby
 Root cause: delete intakes 'I261013869900','I261013860480','I261013672097','I251013565564','I251013447310','I251013341017','I251013331483','I251013323739','I251013309446','I251013308162'
 Pull request# N/A
 Reason why no related code fix: N/A
 Status of the code fix if already submitted and expected prod fix date: N/A
*/




update intakedastatus 
set activeflag=0,updatedon=now(),updatedby='CJAMS-65161'
where intakenumber in ('I261013869900','I261013860480','I261013672097','I251013565564','I251013447310','I251013341017','I251013331483','I251013323739','I251013309446','I251013308162') and activeflag=1;

update intakedastaging 
set activeflag=0,updatedon=now(),updatedby='CJAMS-65161'
where intakenumber in ('I261013869900','I261013860480','I261013672097','I251013565564','I251013447310','I251013341017','I251013331483','I251013323739','I251013309446','I251013308162') and activeflag=1;
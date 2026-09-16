/*
   Issue Description: CDM-31857
   Category/ Module  :  
   Root cause: user wants remove intake # I231010514762 from the Pending Transfer dashboard and update data 
   Pull request# for code fix: na
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/

update intakesnapshot set jsondata=jsonb_set(jsondata,'{General,countyid}','"817e0751-1fa8-4c31-8233-8fffd6426235"') where intakenumber='I231010514762' and activeflag=1; 

update intaketransfers set approvalstatus='Approved',approvedby='49ae215c-497c-4ce5-88a6-7b5c087001e7',approvedon='2023-03-03 11:47:20',
receivingcountysupervisor='bcd0eec6-bb5e-4181-a07f-2abca7223434',updatedby='CDM-31857',updatedon=now()
where intaketransferid='3750756c-0709-4d4b-9612-a418c6ca6b11';
/*
Issue Description: User requested to reject both kids current subsidy rate records,
so that user can add the correct subsidy rate for both of them
Category/Module: Bug
Root cause: Data fix has been done to reject both kids current subsidy rate records,
so that user can add the correct subsidy rate for both of them
Fix provided: Data fix has been done to reject both kids current subsidy rate records,
so that user can add the correct subsidy rate for both of them
Data/Code fix ticket#: CJAMS-58771
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
*/


update gapagreementrate
   set status = 'Rejected',
	   updatedby = 'CJAMS-58771',
	   updatedon = now()
where gapagreementrateid = '92dc6a9f-2cd2-42f9-afe2-7daa5f27e108' 
and activeflag = 1;

update routing 
   set routingstatustypeid = 17,
       routeddescription= 'Guardianship Rate Rejected',	 
       remarks = 'return to worker'
   where routingid in ('53c390a0-77da-4c80-bc4f-7cc8d898c2a0','cbf8b169-dee6-4480-bef5-7a01fa59180e');
   
--Zion Richardson

update gapagreementrate
   set status = 'Rejected',
	   updatedby = 'CJAMS-58771',
	   updatedon = now()
where gapagreementrateid = 'a408a8b4-0a72-4276-9297-c770e89a9a7f' 
and activeflag = 1;

update routing 
   set routingstatustypeid = 17,
       routeddescription= 'Guardianship Rate Rejected',	 
       remarks = 'return to worker'
   where routingid in ('ef07743c-6577-4bf5-a333-3881a514d96f','a4b6beb8-0f2f-45b9-8b61-6170cac9d265');


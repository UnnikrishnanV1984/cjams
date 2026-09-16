/*
   Issue Description: CJAMS-66688
   Category/ Module: Pending approval Inbox
   Root cause: User requested to delete the case from pending approval inbox 
   Fix Provided : Deleted the case from supervisor pending approval inbox
   Pull request# for code fix:  N/A
   Reason why no related code fix: N/A
   Status of the code fix if already submitted and expected prod fix date: N/A
   Backup before update/ delete: N/A
*/

update routing
set activeflag =0, updatedby ='CJAMS-66688', updatedon =now()
where objectid ='5da10cfd-5d96-44aa-8e23-cc63a0290f9a' and routingid ='29ca3213-f31a-44de-85e8-972c7b0890bb' and activeflag =1;

/*
Issue Description: Case closed to GAP on 7/29/24. GAP subsidy case created and then case was closed, rather than continuing to be open so that payments could be issued
Category/Module: Bug
Root cause: Users cannot change the dates  in  approved gap agreementrate
Fix provided: DB queries to update query to gapagreementrate table
Data/Code fix ticket#: CJAMS-58267
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Support ticket
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/


update gapratesrevision
set  updatedby = 'CJAMS-58267', updatedon = now(),approvaldate = now()
where gapratesrevisionid in ('c8371912-f4d6-4f7e-ac5e-ab5a901409bb', '8f16d8db-dc15-4851-91d6-dc8b7d48d008') and activeflag = 1;


update gapsuspension
set activeflag =0,  updatedby = 'CJAMS-58267', updatedon = now()
where  gapsuspensionid = 'd57b551f-3f0a-43a2-ab8f-694c1463c0d9' and activeflag =1;


update gapsuspensionrevision
set  activeflag =0,  updatedby = 'CJAMS-58267', updatedon = now()
where gapsuspensionrevisionid = '84081ffa-8a9d-417f-886a-7d58291f2562' and activeflag =1;


update routing 
set activeflag =0,  updatedby = 'CJAMS-58267', updatedon = now()
where routingid = 'fee205fc-653a-4923-9f14-998f2701d88f' and activeflag =1;

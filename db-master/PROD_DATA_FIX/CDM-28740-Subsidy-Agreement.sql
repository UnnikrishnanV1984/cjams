/*
   Issue Description: CDM-28740
   Category/ Module  : Agreement documents
   Root cause: user wants to delete the Incomplete record from ADOPTION SUBSIDY RATES and date changes
   Pull request# for data fix:8044
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/
update adoptioncaseagreementrate 
set startdate = '2023-01-18 00:00:00', updatedby = 'CDM-28740', updatedon = now()
where adoptionagreementrateid in ('0ed3a153-fdda-40f0-8473-2617578f2b94','334352c9-f615-4169-888c-54df85290108');

update adoptioncaserevision set startdate = '2023-01-18 00:00:00', approvaldate = now(), updatedby = 'CDM-28740', updatedon = now() 
where adoptionagreementrateid in ('0ed3a153-fdda-40f0-8473-2617578f2b94','334352c9-f615-4169-888c-54df85290108')
and activeflag = 1;

update adoptioncaseagreementrate set activeflag = 0, updatedby = 'CDM-28740', updatedon = now() 
where adoptionagreementrateid in ('f4035e20-f294-49eb-8b17-23cd884a1a42', 'c39b40a8-4f8d-4b01-a8a7-ff57c9e1d307', '3323f071-c7a5-41ce-9830-e6b120f57161');

update adoptionagreementraterevision set activeflag = 0, updatedby = 'CDM-28740', updatedon = now() 
where adoptionagreementrateid in ('f4035e20-f294-49eb-8b17-23cd884a1a42', 'c39b40a8-4f8d-4b01-a8a7-ff57c9e1d307', '3323f071-c7a5-41ce-9830-e6b120f57161');
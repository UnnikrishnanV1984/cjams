/*
Issue Description:CJAMS-68856 Incorrect GAP Subsidy Start Date
Category/Module: Permanency plan
Root cause: User error, Uer requested to update the Guardianship Start Date
Fix provided: Data fix has been done to update the Guardianship Start Date for client 200158316 Larkin Birmingham
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error and data fix needed to update the permanency plan details.
*/

------------To revert back all previous changes 
update guardianship g
set activeflag =1,
updatedby ='CJAMS-68856',updatedon =now()
where gapid ='b666b386-74d9-4bec-8263-2d6076c70c9d' and activeflag =0;

update gapagreement
set activeflag =1,
updatedby ='CJAMS-68856',updatedon =now()
where gapagreementid ='75b845d3-d433-4b04-a408-22526908a7e0' and activeflag =0;

update routing 
set activeflag =1,
updatedby ='CJAMS-68856',updatedon =now()
where objectid ='75b845d3-d433-4b04-a408-22526908a7e0' and activeflag =0;

-----------------------------------------------------------

update gapagreement 
SET startdate = '2025-01-10 10:00:00.000',enddate='2025-01-15 05:00:00.000',
    updatedby = 'CJAMS-68856',
    updatedon = now()
where gapagreementid ='81d25ab2-0584-4d4f-8726-ce8cc380d55e' and activeflag =1;

update gapagreementrevision
SET startdate = '2025-01-10 10:00:00.000',
    updatedby = 'CJAMS-68856',
    updatedon = now()
where gapagreementid ='81d25ab2-0584-4d4f-8726-ce8cc380d55e' and activeflag =1;

update gapagreementrevision
SET enddate  = '2025-01-15 05:00:00.000',
    updatedby = 'CJAMS-68856',
    updatedon = now()
where gapagreementrevisionid in ('2fbef352-3346-4fb9-a0d1-6bef402774f0',
'e04d6c18-498e-4e0a-ae03-d3efe0b0a3dd') and activeflag =1;

update gapagreementrate
SET startdate = '2025-01-10 10:00:00.000',enddate='2025-01-15 05:00:00.000',
    updatedby = 'CJAMS-68856',
    updatedon = now()
where gapagreementid ='81d25ab2-0584-4d4f-8726-ce8cc380d55e' and activeflag =1;

update gapratesrevision
SET ratestartdate  = '2025-01-10 10:00:00.000',rateenddate='2025-01-15 05:00:00.000',approvaldate =now(),
    updatedby = 'CJAMS-68856',
    updatedon = now()
where gaprateid ='03684e50-5987-4bda-9ab2-0d62408c2fb7' and activeflag =1;


-------------------------------------------------------------------------

update guardianship
set permanencyplanid='71af1495-b12c-467f-8f3b-ee9e5b80708f',
updatedby ='CJAMS-68856',updatedon =now()
where gapid='b666b386-74d9-4bec-8263-2d6076c70c9d';

update guardianship
set permanencyplanid='c0dea0fc-6287-4210-a25b-ff7b3eb6236a',
updatedby ='CJAMS-68856',updatedon =now()
where gapid='ad509bac-dda6-450e-adad-f84e4a4c0e5e';
-------------------------------------------------------------------------

---- To update guarship start date 
update gapagreement
set startdate ='2026-06-25 05:00:00.000',
updatedby ='CJAMS-68856',updatedon =now()
where gapagreementid ='75b845d3-d433-4b04-a408-22526908a7e0' and activeflag =1;


update gapagreementrevision
SET startdate ='2026-06-25 05:00:00.000',
    updatedby = 'CJAMS-68856',
    updatedon = now()
where gapagreementid ='75b845d3-d433-4b04-a408-22526908a7e0' and activeflag =1;

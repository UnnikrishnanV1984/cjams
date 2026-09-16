/*
Issue: CJAMS-11337 Incorrect Suspension Dates
Category/Module: ADOPTION / Suspension
Root cause: Dev team - Please change current system generated suspension start date to 3/20/26. 
Fix provided:  Data fix has been done to remove the incorrect GAP suspension record and trigger the pending payments.
Data/Code fix ticket#: 
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: 
*/


update adoptioncasesuspension
set  suspensionbegindate='2026-03-20',updatedon =now(), updatedby ='CJAMS-66980'
where adoptionsuspensionid  in ('f4dcd597-d445-4ad1-b1cd-990e23ec8cf3')
and activeflag=1;


update adoptioncasesuspensionrevision
set  suspensionbegindate='2026-03-20', approvaldate = now(),updatedon =now(), updatedby ='CJAMS-66980'
where adoptionsuspensionid in ('f4dcd597-d445-4ad1-b1cd-990e23ec8cf3')
and activeflag=1;

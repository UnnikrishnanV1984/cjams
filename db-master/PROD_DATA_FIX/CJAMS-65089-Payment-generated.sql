/*
Root Cause:
1. Update the GAP agreement from 11/28/2002 to 05/18/2011.
2. Update the 1st Subsidy Rate slab start date from 11/28/2002 to 05/18/2011.
3. Update the GAP program assignment start date from 11/28/2002 to 05/18/2011 for Cissina Sterrett (PID# 3028160)
4. Update the child removal & OOH program end date need to be updated to 05/18/2011
Fix Provided (Data Fix Only):Data fix was done by Updated gapagreement,gapagreementrevision table .
Data/Code fix ticket#: CJAMS-65089
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Error.
Status of the code fix: Data fix completed, PR raised for documentation.
Backup before update/ delete:Query:
*/

update gapagreement 
set startdate ='2011-05-18 00:00:00.000', updatedby = 'CJAMS-65089', updatedon = now()
where gapagreementid ='ed6a233a-8cff-4081-9522-53f051a33241' and activeflag =1;



update gapagreementrate 
set startdate ='2011-05-18 00:00:00.000',
updatedby='CJAMS-65089',updatedon=now() 
where gapagreementrateid='e11825d4-0c33-4b4d-a993-88332492176a' and activeflag =1;


update personprogramarea 
set  startdate = '2011-05-18 00:00:00.000', updatedby = 'CJAMS-65089', updatedon = now()
where personprogramid ='91f11452-335a-46f1-9696-b5f8d9d0be75' and activeflag=1;

update personprogramarea 
set  enddate  = '2011-05-18 00:00:00.000', updatedby = 'CJAMS-65089', updatedon = now()
where personprogramid ='8aa788f3-129a-4c98-9c58-cbb8fd2b34cf' and activeflag=1;


update intakeservreqchildremoval 
set exitdate = '2011-05-18 00:00:00.000', updatedby = 'CJAMS-65089', updatedon = now()
where intakeservreqchildremovalid = 'a0c69e74-acf8-4cb2-9b54-488c59a2f37c' and activeflag =1;



update gapagreementrevision 
set  startdate = '2011-05-18 00:00:00.000', updatedby = 'CJAMS-65089', updatedon = now(),approvaldate =now()
where gapagreementid  in ('ed6a233a-8cff-4081-9522-53f051a33241') and activeflag =1;

update gapagreementrate 
set updatedon = now(), updatedby = 'CJAMS-65089'
where gapagreementid = 'ed6a233a-8cff-4081-9522-53f051a33241'
and activeflag = 1 ;
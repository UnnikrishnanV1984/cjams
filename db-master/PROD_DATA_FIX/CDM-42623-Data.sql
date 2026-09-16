/*
  Issue Description:  CDM-42623
   Category/ Module  : Permanency Plan
   Root cause: User request to Dayquail scott
   Subsidy rate start date - 08/14/2024  to 08/15/2025 - no change in amount
   Agreement start date and court order date to be changed to -08/14/2024
   Pull request# for code fix: NA
   Reason why no related code fix: NA
   Status of the code fix if already submitted and expected prod fix date: NA
   Backup before update/ delete: NA
*/

update gapagreementrate set startdate = '2024-08-14 ', enddate = '2025-08-15', updatedby='CDM-42623', updatedon = NOW() 
where gapagreementrateid = 'fd4a2fd5-7853-41c4-bbce-d1aac9d9c65e' and activeflag = 1;

update gapratesrevision set ratestartdate = '2024-08-14', rateenddate = '2025-08-15', updatedby = 'CDM-42623', updatedon = now() 
where gaprateid ='fd4a2fd5-7853-41c4-bbce-d1aac9d9c65e' and activeflag=1 ;

update 	intakeservreqcourtorder 
set 	courtorderdate = '2024-08-14 00:00:00.000',
		updatedby = 'CDM-42623',
		updatedon  = now()
where 	intakeservreqcourtorderid = 'f3a8cc3e-e98c-481f-acc6-d4b11cf50bf5';

update 	gapagreement
set 	startdate = '2024-08-14 00:00:00.000',
		updatedby = 'CDM-42623',
		updatedon  = now()
where 	gapagreementid = '81248636-7866-4aab-bd9a-dfce93077f89';

update 	gapagreementrate
set 	startdate = '2024-08-14 00:00:00.000',
		updatedby = 'CDM-42623',
		updatedon  = now()
where 	gapagreementid = '81248636-7866-4aab-bd9a-dfce93077f89'
and   gapagreementrateid= 'fd4a2fd5-7853-41c4-bbce-d1aac9d9c65e' and activeflag = 1;

update 	gapagreementrevision
set 	startdate = '2024-08-14 00:00:00.000',
        approvaldate = now(),
		updatedby = 'CDM-42623',
		updatedon  = now()
where 	gapagreementid = '81248636-7866-4aab-bd9a-dfce93077f89'
        and activeflag = 1;
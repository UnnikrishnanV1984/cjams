
/*
Issue Description: case start date should be - Narrative last updated time : 04/14/2026 2:10 PM, Child Program assignment , case ID missing needs to fix so as to show him active in house hold,all clients program assignments to be changed to 4/14,Case worker assignments start date to be 4/14 for all assignments
Category/Module: Case Management
Root cause: All above is the result of Intake not resulted in case creation , fix provided for case creation of 5/1-CJAMS-67069, as per the user request it should show as 4/14
Fix provided: Data fix has been promoted to update the case start date, Program assignments start date and missing case ID from backend
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: No
Reason why no related code fix: Data fix 
*/

update servicecase
set startdate='2026-04-14 14:10:00', insertedon='2026-04-14 14:10:00',
effectivedate = '2026-04-14 14:10:00',
updatedby = 'CJAMS-67572', updatedon=now()
where servicecaseid='2c94e805-4a06-4a99-b2ef-6087ff1bc1d1';

update personprogramarea
set entityid='261030683120',
objectid='2c94e805-4a06-4a99-b2ef-6087ff1bc1d1',
updatedby = 'CJAMS-67572', updatedon=now()
where personprogramid='6abcba21-4fc9-4e4a-8bdf-e2fcba62f218'; 


update personprogramarea set startdate ='2026-04-14 00:00:00.000',
updatedby = 'CJAMS-67572', updatedon=now()
where personprogramid in ('4170a2fa-26a1-4cd4-a991-e614d0eb3585','29e8c330-ac1d-4c19-8cd2-adffc9f55098','1968ea5b-5dbd-4daa-ad0f-ff9433e67db4','07098013-7973-4ca1-8185-934c9ccf0631'); 

update servicecasedisposition
set statusdate='2026-04-14 14:10:00', insertedon='2026-04-14 14:10:00',
effectivedate = '2026-04-14 14:10:00',
updatedby = 'CJAMS-67572', updatedon=now()
where servicecaseid='2c94e805-4a06-4a99-b2ef-6087ff1bc1d1' and activeflag=1;
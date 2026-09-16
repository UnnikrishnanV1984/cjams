/*
Issue: CJAMS-47775 Data fix for start date
Category/Module: 
Root cause: This is not a defect. Once the SEN is selected in the Person profile and service case has generated from the intake, the SEN history checkbox will disable and not able to be un-checked.
            Service case # 231030203714 has been closed on 11/08/2023 and connected to Intake # I231011362158
            CJAMS PID#: 202040591 (Nehemiah Cook)
            SSA approval has been provided to modify the Intake # I231011362158 & Service case # 231030203714 start date to 10/17/23 at 4:27PM as requested.
Fix provided: Data fix has been done to modify the Intake # I231011362158 narrative date & Service case # 231030203714 start date to 10/17/23 at 4:27PM as requested.
              Updated the records in Decision tab and submission history as well to match these dates. 
Data/Code fix ticket#: CJAMS-47775 
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: SSA approval provided for data fix.
*/

update servicecase
set insertedon = '2023-10-17 16:27:52',
	updatedon = now(),
	updatedby = 'CJAMS-47775'
where servicecasenumber = '231030203714'
and activeflag =1;


update servicecasedisposition
set statusdate = '2023-10-17 16:27:52',
	updatedon = now(),
	updatedby = 'CJAMS-47775'
where servicecasedispositionid = 'f60ac667-4a7d-4364-b922-fdbf612e2224'
and activeflag =1;


update servicecasedisposition
set statusdate = '2023-10-17 17:41:04',
	updatedon = now(),
	updatedby = 'CJAMS-47775'
where servicecasedispositionid = '9c1ffdad-23ed-42d5-827e-e24fd2c4fa2c'
and activeflag =1;

UPDATE intakesnapshot
SET jsondata = jsonb_set(
    jsondata,
    '{General,narrativeUpdatedDate}',
     '"2023-10-17T20:27:52.721Z"',
    true
),
updatedon = now(),
updatedby = 'CJAMS-47775'
WHERE intakenumber = 'I231011362158' and activeflag=1;

update routing
set intakerecommendation = 'Scrnin',
	supervisordecision = 'Scrnin',
	insertedon = '2023-10-17 16:19:07.112',
	updatedon = '2023-10-17 16:27:52'
where objectid = 'I231011362158'
and activeflag = 1;
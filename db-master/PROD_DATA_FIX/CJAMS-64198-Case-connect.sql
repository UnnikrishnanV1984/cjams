/*
Issue: CJAMS-64198 Service Case Did not Generate
Category/Module: Intake
Root cause: Service case is not generated after the intake creation and data fix is needed to create a service case and link it to the intake.
            intake# I251013596940.
Fix provided:  Data fix has been done to create service case and connect it to intake# I251013596940.
Data/Code fix ticket#: CJAMS-64198
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Service case is not created due to network glitch and data fix should resolve it.
*/

----intakeserviceid -->d9b77897-2cc7-4fe4-b86c-acf861419924
----servicaseid --> To be created
--supervisor id --> 'fc251376-8745-4381-a750-6a617c748678' - Jessica Roundtree
 
select * from createservicecase('d9b77897-2cc7-4fe4-b86c-acf861419924', null,1,'fc251376-8745-4381-a750-6a617c748678',null,'ASSGN','intake',null);

update servicecase 
set insertedon = '2025-12-18 15:57:21.307',
    updatedby = 'CJAMS-64198',
    updatedon = now()
where servicecaseid = (select servicecaseid from intakeservicerequest i where intakenumber = 'I251013596940')
and activeflag =1;    
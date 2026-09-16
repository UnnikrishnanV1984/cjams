
/*
Issue: CJAMS populated multiple cases to assign; one was chosen from the list to assign to the worker but the others remain
Category/Module:
Root cause: Need data fix as mentioned below:
1. Delete the CPS-AR # 261023622303, it is a duplicate case and does not have case assignment.
2. Delete the CPS-AR # 261023622475, it is a duplicate case and does not have case assignment.
3. From CPS-AR # 261023622301: Remove the CPS AR program assignment of Case # 261023622303 for all the clients.
Fix provided: Daaaaattttta fix has been provided to inactivate the duplicate cases and remove the CPS AR program assignment of Case # 261023622303 for all the clients.
Data/Code fix ticket#: CJAMS-65211
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data entry error, no code fix needed.
*/
update intakeservicerequest
    set activeflag = 0,
        updatedby = 'CJAMS-65211',
        updatedon = now()
    where servicerequestnumber in ('261023622303', '261023622475')
    and activeflag = 1;
   
update intakeservicerequestactor
    set activeflag = 0,
        updatedby = 'CJAMS-65211',
        updatedon = now()
    where intakeserviceid in  ('10dbff6e-f5ab-43df-a6b5-a24ed09eb255', '328649da-bd88-4ad9-97d5-77318e64edeb') and activeflag=1;

update actor
    set activeflag = 0,
        updatedby = 'CJAMS-65211',
        updatedon = now()
    where intakeserviceid in  ('10dbff6e-f5ab-43df-a6b5-a24ed09eb255', '328649da-bd88-4ad9-97d5-77318e64edeb') and activeflag=1;
   
update intakeservrequestsdmmaltreatment
    set activeflag=0,
        updatedby = 'CJAMS-65211',
        updatedon = now()
    where intakeservicerequestsdmid in (select intakeservicerequestsdmid from intakeservicerequestsdm
where intakeserviceid in ('10dbff6e-f5ab-43df-a6b5-a24ed09eb255', '328649da-bd88-4ad9-97d5-77318e64edeb')
    and activeflag = 1)
    and activeflag = 1;

update intakeservicerequestsdm
    set activeflag = 0,
        updatedby = 'CJAMS-65211',
        updatedon = now()
    where intakeserviceid in ('10dbff6e-f5ab-43df-a6b5-a24ed09eb255', '328649da-bd88-4ad9-97d5-77318e64edeb')
    and activeflag = 1; 
	
--From CPS-AR # 261023622301: Remove the CPS AR program assignment of Case # 261023622303 for all the clients.
update personprogramarea
set activeflag=0,
updatedby='',
updatedon=now()
where personprogramid in ('442889c6-96d9-41ed-bead-72107a99c0f6','6ba0c1ba-9282-4e24-803f-6a573a6a93a5','985f8f39-f6bb-4f58-8067-568c65de055e')
and objectid='10dbff6e-f5ab-43df-a6b5-a24ed09eb255';
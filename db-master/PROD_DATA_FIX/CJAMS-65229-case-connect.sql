/*
Issue: CJAMS-65229 Case Assignment
Category/Module: Service Case / Create Service case 
Root cause: Intake I261013885869 is screened-in on 02/06 and case connect was not done during the creation due to the slowness issue.
            Data fix has been requested by the user to create a new case and connect it to the intake.
Fix provided:  Data fix has been done to create a new case and connect it to the intake I261013885869
Data/Code fix ticket#: CJAMS-65229
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User requested for data fix as case connect was not done.
*/

----intakeserviceid -->af88190c-0f41-463d-85fd-f9aa413521d9
----servicaseid --> null -->To be created
--supervisor id --> '34b4c48c-5411-46ff-856d-c4e2b2119efc' - Veronica Wright-Richardson
 
select * from createservicecase('af88190c-0f41-463d-85fd-f9aa413521d9', null,1,'34b4c48c-5411-46ff-856d-c4e2b2119efc',null,'ASSGN','intake',null);

--Deactivating other incorrect insertions
update intakeservicerequest 
set activeflag = 0,
    updatedby = 'CJAMS-65229',
    updatedon = now()
where intakenumber = 'I261013885869'
and intakeserviceid in ('a575eb71-9c05-478c-80a9-3cd6feb9055d','dbf90140-afd2-4b10-a4a8-eb56433ef908','b3ee6c68-2f3f-4496-ae54-7c13c57ce18f','28efc7a7-719d-44cd-b428-3b523ea6de0e','f099ea46-e40b-4077-b6f3-0024d1ec9812')
and activeflag =1;


--Setting the servicecase start date

update servicecase sc
set startdate = '2026-02-06 13:22:00.000',
    insertedon = '2026-02-06 13:22:00.000',
    updatedon = now(),
    updatedby = 'CJAMS-65229'
from intakeservicerequest isr
where isr.servicecaseid = sc.servicecaseid 
and isr.intakeserviceid = 'af88190c-0f41-463d-85fd-f9aa413521d9'
and sc.activeflag =1;

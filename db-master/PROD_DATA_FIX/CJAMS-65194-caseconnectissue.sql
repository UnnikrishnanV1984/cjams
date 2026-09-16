/*
Issue: CJAMS-65194 no case number attached
Category/Module: Case connect
Root cause: I261013890407:Screened in an intake but  and case connect was not done during the creation due to the slowness issue.
            Data fix has been requested by the user to create a new case and connect it to the intake.
Fix provided: Data fix has been done to create a new case and connect it to the intake I261013890407 
Data/Code fix ticket#: CJAMS-65194
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User requested for data fix as case connect was not done.
*/


----intakeserviceid --> 42d19e16-6cc5-4470-8e1c-e142482282b7
----servicaseid --> null -->To be created
--supervisor id --> 'b212e3d2-4ffa-44e3-9038-91648f194bb2' - Kara Finamore
 
select * from createservicecase('42d19e16-6cc5-4470-8e1c-e142482282b7', null,1,'b212e3d2-4ffa-44e3-9038-91648f194bb2',null,'ASSGN','intake',null);

--Deactivating other incorrect insertions
update intakeservicerequest 
set activeflag = 0,
    updatedby = 'CJAMS-65194',
    updatedon = now()
where intakenumber = 'I261013890407'
and intakeserviceid in ('d741f638-b2ee-4b22-a896-d26675a1663c','703cb29c-6d99-491c-be60-0678159edf88')
and activeflag =1;

 --Setting the servicecase start date

update servicecase sc
set startdate = '2026-02-06 13:50:15.332',
    insertedon = '2026-02-06 13:50:15.332',
    updatedon = now(),
    updatedby = 'CJAMS-65194'
from intakeservicerequest isr
where isr.servicecaseid = sc.servicecaseid 
and isr.intakeserviceid = '42d19e16-6cc5-4470-8e1c-e142482282b7'
and sc.activeflag =1;
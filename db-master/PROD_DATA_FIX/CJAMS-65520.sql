/*
Issue Description:CJAMS-65520:One case was created on 02/06/2026, the one ending in 3622566. CJAMS created multiple cases where the timer is running on those cases. On the original case the timer was stopped on 02/06/2026. The 3 additional cases need to be deleted. The only case showing on the worker Dashboard is the one ending in 3622566 
Category/Module: Ccase 
Root cause:Mutliple cases are created and user requested to delete 261023622571, 261023622567 & 261023622572
Fix provided: Data fix to delete duplicate  cases.
Regression Impacts: N/A
Is Code fix Required?: No
Reason why no related code fix: N/A
*/

/*
261023622567	69379580-53a0-4d1f-be06-7ebf59842723
261023622571	47a0e8bd-f5e5-4f63-ad91-37877ac12452
261023622572	98224a17-9a52-4074-947b-6acf2f991af8
*/

update intakeservicerequest
    set activeflag = 0,
        updatedby = 'CJAMS-65520',
        updatedon = now()
    where servicerequestnumber in ('261023622571', '261023622567', '261023622572')
    and activeflag = 1;

update intakeservicerequestactor
    set activeflag = 0,
        updatedby = 'CJAMS-65520',
        updatedon = now()
    where intakeserviceid in ('69379580-53a0-4d1f-be06-7ebf59842723','47a0e8bd-f5e5-4f63-ad91-37877ac12452','98224a17-9a52-4074-947b-6acf2f991af8')
    and activeflag = 1;

update actor
    set activeflag = 0,
        updatedby = 'CJAMS-65520',
        updatedon = now()
    where intakeserviceid in ('69379580-53a0-4d1f-be06-7ebf59842723','47a0e8bd-f5e5-4f63-ad91-37877ac12452','98224a17-9a52-4074-947b-6acf2f991af8')
    and activeflag = 1;

update intakeservrequestsdmmaltreatment
    set activeflag=0,
        updatedby = 'CJAMS-65520',
        updatedon = now()
    where intakeservicerequestsdmid in (select intakeservicerequestsdmid from intakeservicerequestsdm
where intakeserviceid in ('69379580-53a0-4d1f-be06-7ebf59842723','47a0e8bd-f5e5-4f63-ad91-37877ac12452','98224a17-9a52-4074-947b-6acf2f991af8')
    and activeflag = 1)
    and activeflag = 1;

update intakeservicerequestsdm
    set activeflag = 0,
        updatedby = 'CJAMS-65520',
        updatedon = now()
    where intakeserviceid in ('69379580-53a0-4d1f-be06-7ebf59842723','47a0e8bd-f5e5-4f63-ad91-37877ac12452','98224a17-9a52-4074-947b-6acf2f991af8')
    and activeflag = 1;     

update personprogramarea
    set activeflag = 0,
        updatedby = 'CJAMS-65520',
        updatedon = now()
    where objectid in('69379580-53a0-4d1f-be06-7ebf59842723','47a0e8bd-f5e5-4f63-ad91-37877ac12452','98224a17-9a52-4074-947b-6acf2f991af8')
    and activeflag = 1;    

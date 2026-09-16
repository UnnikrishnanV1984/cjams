/*
Issue: CJAMS-64954 case assignment
Category/Module: Case 
Root cause: New case got created after intake worker screened In the intake I261013837951. 
            Data fix needs to be done to the intake to correct case and delete the wrongly created case.
            Intake - I261013837951
            Existing case number - 261023571718 (correct case)
            New case number - 261023624094
Fix provided:  Data fix has been done to connect correct case to intake and delete the wrongly created case.
            Intake - I261013837951
            Existing case number - 261023571718 (correct case)
            New case number - 261023624094
Data/Code fix ticket#: CJAMS-64954
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: We are unable to reproduce this issue in stage-3 and we are doing data fix to delete the incorrect case created
*/


update intakeservicerequest
    set activeflag = 1,
        updatedby = 'CJAMS-64954',
        updatedon = now()
    where intakeserviceid in ('385bdf28-4fb9-473c-bff8-7a9813f34cf1')
    and activeflag = 0;


update intakeservicerequest
    set activeflag = 0,
        updatedby = 'CJAMS-64954',
        updatedon = now()
    where intakeserviceid in ('e47512c6-6de8-4c9c-8996-6a773a4504e4')
    and activeflag = 1;

update intakeservicerequestactor
    set activeflag = 0,
        updatedby = 'CJAMS-64954',
        updatedon = now()
    where intakeserviceid in ('e47512c6-6de8-4c9c-8996-6a773a4504e4')
    and activeflag = 1;

update actor
    set activeflag = 0,
        updatedby = 'CJAMS-64954',
        updatedon = now()
    where intakeserviceid in ('e47512c6-6de8-4c9c-8996-6a773a4504e4')
    and activeflag = 1;

update intakeservrequestsdmmaltreatment
    set activeflag=0,
        updatedby = 'CJAMS-64954',
        updatedon = now()
    where intakeservicerequestsdmid in (select intakeservicerequestsdmid from intakeservicerequestsdm
where intakeserviceid in ('e47512c6-6de8-4c9c-8996-6a773a4504e4')
    and activeflag = 1)
    and activeflag = 1;


update intakeservicerequestsdm
    set activeflag = 0,
        updatedby = 'CJAMS-64954',
        updatedon = now()
    where intakeserviceid in ('e47512c6-6de8-4c9c-8996-6a773a4504e4')
    and activeflag = 1;     

update personprogramarea
    set activeflag = 0,
        updatedby = 'CJAMS-64954',
        updatedon = now()
    where objectid in('e47512c6-6de8-4c9c-8996-6a773a4504e4')
    and activeflag = 1;    

update intakeservicerequestsdm
    set ismalpa_caregiver = false,
    	isnoimmed_physicalabuse =false,
        updatedon = now(),
        updatedby = 'CJAMS-64954'
    where intakeserviceid  = '385bdf28-4fb9-473c-bff8-7a9813f34cf1'
    and activeflag = 1;
    
update cpsresponsetimeractions 
    set activeflag = 0,
    	updatedon = now(),
    	updatedby = 'CJAMS-64954'
    where cpsresponsetimeractionsid = 'ed69b148-9251-431c-92e2-589162a34ac5'
    and activeflag =1;   
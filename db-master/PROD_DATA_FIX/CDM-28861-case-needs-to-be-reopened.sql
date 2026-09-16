/*
   Issue Description: CDM-28861
   Category/ Module  :  data fix to reopen CPS case
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update
    intakeservicerequest
set
    exitdate = null,
    updatedby = 'CDM-28861',
    updatedon = now(),
    intakeserreqstatustypeid = 'c8dbf10f-843d-4b40-97ca-288d750463da'
where
    intakeserviceid = '25bc6c95-7c2f-4121-89c8-4a8d8bf37be3';

update
    Intakeservicerequestdispositioncode
set
    activeflag = 0,
    updatedby = 'CDM-28861',
    updatedon = now()
where
    intakeservicerequestdispositioncodeid in (
        '6740a92c-617f-4ea4-a16a-3c80afe6854d',
        'c7c984be-0a30-4a4e-9c72-828331071692'
    );
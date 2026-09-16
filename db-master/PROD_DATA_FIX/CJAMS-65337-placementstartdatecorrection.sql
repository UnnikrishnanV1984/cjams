/*
Issue: CJAMS-65337 Placement
Category/Module: Placement / Hospitalization
Root cause: User wanted to edit the placement start date and system is not allowing to update it to the backdated date.
            Case ID: 231030249993
            Client ID: 202082624 (EVAN RYAN SANFORD)
            Living Arrangement Type: Inpatient Psychiatric Hospital
Fix provided:  Data fix has been done to update the placement start date as 2026-02-06 12:00:00.000
Data/Code fix ticket#: CJAMS-65337
Regression Impacts: N/A
Is Code fix Required?: yes
Code fix ticket#:  CDM-44708 
Reason why no related code fix: N/A
*/


update placement
set startdatetime = '2026-02-06 12:00:00.000',
    starttime = '12:00',
    updatedby = 'CJAMS-65337',
    updatedon = now()
where placementid = '9628527d-e114-44b6-a857-00af72ffe630'
and activeflag =1;


update placementrevision 
set entrydate  = '2026-02-06 12:00:00.000',
    entrytime  = '12:00',
    updatedby ='CJAMS-65337',
    updatedon=now()
where placementid = '9628527d-e114-44b6-a857-00af72ffe630'
and activeflag = 1;


update livingarrangement
set livingstartdate = '2026-02-06 12:00:00.000',
    updatedby ='CJAMS-65337',
    updatedon=now()
where placementid = '9628527d-e114-44b6-a857-00af72ffe630'
and activeflag = 1;



update personhospitalization 
set hospital_inpatientadmissiondate  ='2026-02-06 12:00:00.000',
    updatedby  ='CJAMS-65337', 
    updatedon =now()
where hospitalizationid  ='edf5a76e-a071-434c-825d-3b1988d738ee';
                             
update personhospitalization_history  
set hospital_inpatientadmissiondate  ='2026-02-06 12:00:00.000',
    updatedby  ='CJAMS-65337',
    updatedon =now()
where personhospitalizationhistoryid  ='edf5a76e-a071-434c-825d-3b1988d738ee';
                                        
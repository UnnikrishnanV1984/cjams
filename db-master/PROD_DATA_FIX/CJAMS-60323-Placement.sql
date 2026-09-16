/*
Issue Description: remove the Child Removal & OOH Program Assignment End Date as requested.
Category/Module: Bug
Root cause: user could not abe to delete end dates ,they can only create.
Fix provided: DB queries  update enddate intakeservreqchildremoval,personprogramarea tables
Data/Code fix ticket#: CJAMS-60323
Regression Impacts: N/A 
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/
update personprogramarea
set enddate = null, updatedby = 'CJAMS-60323', updatedon = now()
where personprogramid = '7530ff2e-94c4-4fcb-acd0-da26f3355613' and activeflag=1;


update intakeservreqchildremoval
set exitdate = null ,updatedby = 'CJAMS-60323', updatedon = now(),
returntransts = Null,returndate = Null,returntime = Null,removalexitreason = NULL
where intakeservreqchildremovalid = 'c296d7c0-d072-48e9-9b9a-d3567075fb72' and activeflag =1;

update intakeservreqchildremoval_history 
set exitdate = null ,updatedby = 'CJAMS-60323', updatedon = now()
where intakeservreqchildremovalhistoryid in ('2f546cfe-fdc0-4c8c-8b9d-c70b74abab6a') and activeflag =1;

update tb_client_eligibility 
set end_dt = null, update_ts = now(),update_user_id  = 'CJAMS-60323'
where eligibility_id  = 10005944 and delete_sw = 'N';



update placement
set enddatetime= null,endtime = null,updatedby = 'CJAMS-60323', updatedon = now()
where placementid = 'adce7c1e-de9f-4fc0-b43e-4a0c04802c47' and activeflag=1;


--update placementrevision
--set exitdate= null,exittime = null,updatedby = 'CJAMS-60323', updatedon = now()
--where placementrevisionid = 'f7c49571-a81c-4974-9035-5100fb89093d' and activeflag=1;


insert into intakeservreqchildremoval_history(
intakeservreqchildremovalhistoryid,      
rowtype,                                 
intakeservreqchildremovalid,             
intakeserviceid,                         
removaladd1,                             
removaladd2,                             
removalzip,                              
activeflag,                              
insertedby,                              
insertedon,                              
updatedby,                               
updatedon,                               
agencytypekey,                           
intakeservicerequestactorid,             
removaldate,                             
familystructuretypekey,                  
clientmergeid,                           
removaltime,                             
returntime,                              
removaltransts,                          
returntransts,                           
removaltypekey,                          
primarycaregiveractorid,                 
removalid,                               
primarycaregiveradd,                     
isverifiedreporteradd,                   
isverifiedcaregiver1add,                 
isverifiedcaregiver2add,                 
servicecaseid,                           
personid,                                
isuploadedmanually,                      
isshelterauthcompleted,                  
ischildaddressasprimaryaddress,          
removalexitreason,                       
childremovalluggage,                     
luggageupdatedby,                        
luggageupdatedon,
modifieddata)
values
(
gen_random_uuid(),
 'HISTORY',
 'c296d7c0-d072-48e9-9b9a-d3567075fb72',
 '5cf3dad2-aac6-4125-b12e-4df0362af880',
 '301 Fernglen Ave, Glen Burnie, MD',
 '[NULL]',
 '65559999',
 '1',
 'CJAMS-60323',
 now(),
 'CJAMS-60323',
 now(),
 'TGH',
 '052d36cf-53ce-4b25-8b94-732de72d0f61',
 '2022-10-13  00:00:00.000',
 '290',
 '290',
 '2022-10-13 11:00:00.000',
 '2025-05-29 13:00:00.000',
 '2022-10-14',
 '2025-06-06',
 'JD',
 '809c4025-3d43-445b-ba89-0127902ca777',
 '254746',
 '301 Fernglen Ave, Glen Burnie, MD',
 '1',
 '1',
 '0',
 '84866b84-7ff4-4ab0-9add-bca0ecac7e9e',
 '5490bbba-ed10-46a0-86a3-a33d2a563fb1',
 '1',
 '1',
 '1',
 'GUARDR',
 'true',
 'Sarah Bevins',
 '2025-06-05 20:27:54.656',
'{"status": "Updated", "data": [ {"key": "comments","data_type": "text", "new_value": "the child removal was re-opened with the datafix ticket CJAMS-60323.","display_name": "Comments"}]}');




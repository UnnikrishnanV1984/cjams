/*
  Issue Description: 231030117727:Child removal was ended but need to place child in a pre-adoptive placement. Cjams is not allowing me to do so due to the removal being end dated for 11/22
  Category/ Module  : Child Removal
  Root cause: User error
  case #: 3240575
  Case ID: 202106306379
  Client ID: 200856148 (Treasure Coates)
  Provider ID: 5088981 (Rosa Chittams)
    1) Remove the Child Removal End Date
    2) Remove the OOH Program Assignment End Date
    3) Change the Placement Exit Type from Permanently Leaving Custody & Care to Change In Placement Structure.

    Case ID: 231030117727
    Client ID: 201176602 (Lucas Findley)
    Provider ID: 6174104 (Shevon Kaintuck)
    Placement Exit Date: 11/22/2025
    Placement Exit Type: Permanently Leaving Custody & Care
  Pull request# for code fix: 
  Reason why no related code fix: 
  Status of the code fix if already submitted and expected prod fix date: N/A
  Backup before update/ delete: 
*/

/*
select exitdate,
  returntransts,
  returndate,
  returntime,
  removalexitreason,removalid ,intakeservreqchildremovalid ,personid , * from intakeservreqchildremoval i 
 where servicecaseid  = '5ee4c83e-c94e-49a8-a03f-b5b3908826ea' and activeflag =1
and intakeservreqchildremovalid = 'eb532062-c88d-4ea2-89a2-567c42c0a65c';

select * from person where cjamspid = '201176602'
*/


update intakeservreqchildremoval
  set exitdate = null,
  returntransts = Null,
  returndate = Null,
  returntime = Null,
  removalexitreason = NULL,
  updatedon = now(), 
  updatedby = 'CJAMS-63738'
where servicecaseid  = '5ee4c83e-c94e-49a8-a03f-b5b3908826ea'	
  and personid = '42409bc5-a377-43ef-8c87-6d8a428f363a'
  and intakeservreqchildremovalid = 'eb532062-c88d-4ea2-89a2-567c42c0a65c'
  and activeflag  = 1 ;
 
/*
select exitdate ,removalexitreason ,* from intakeservreqchildremoval_history 
where servicecaseid = '5ee4c83e-c94e-49a8-a03f-b5b3908826ea' 
  and intakeservreqchildremovalid = 'eb532062-c88d-4ea2-89a2-567c42c0a65c'
	and activeflag =1;
*/
 
update intakeservreqchildremoval_history 
set exitdate = null ,
    removalexitreason = null,
    updatedby = 'CJAMS-63738', 
    updatedon = now()
where servicecaseid = '5ee4c83e-c94e-49a8-a03f-b5b3908826ea'
and intakeservreqchildremovalhistoryid = '4803f50d-8a98-4568-a3f4-9d29fa108d2a'
  and intakeservreqchildremovalid = 'eb532062-c88d-4ea2-89a2-567c42c0a65c'
and activeflag =1;

--select end_dt ,* from tb_client_eligibility where removal_id = '273921'

update cjams.tb_client_eligibility
set end_dt = Null,
	update_user_id = 'CJAMS-63738',
	update_ts = now()
where removal_id = '273921'
and delete_sw = 'N';

/*
select enddate ,* from personprogramarea p where personid = '42409bc5-a377-43ef-8c87-6d8a428f363a' and activeflag =1
and objectid = '5ee4c83e-c94e-49a8-a03f-b5b3908826ea';
*/

update personprogramarea
  set enddate = null,
      updatedby = 'CJAMS-63738', 
      updatedon = now()
where programkey = 'OOH' 
  and personprogramid = 'c02ddb11-7657-46b4-95b8-270d8b6d7078'
  and activeflag = 1;
 
-- personid: 42409bc5-a377-43ef-8c87-6d8a428f363a  Royalty	Goldstocks	K
insert into intakeservreqchildremoval_history(           
intakeservreqchildremovalhistoryid,                      
rowtype,                                                 
intakeservreqchildremovalid,
intakeserviceid,                                         
activeflag,                                              
insertedby,                                              
insertedon,                                              
updatedby,                                               
updatedon,                                               
intakeservicerequestactorid,  
removaldate,
removaltypekey, 
primarycaregiveractorid,
removalid,
servicecaseid,                                           
personid,                                                
modifieddata)                                            
values
(
 gen_random_uuid(),
  'HISTORY',
  'eb532062-c88d-4ea2-89a2-567c42c0a65c',
  null,
  '1',
  'CJAMS-63738',
  now(),
  'CJAMS-63738',
  now(),
  'c6e9316f-da3e-4e52-bd6c-093de875a913',
  '2023-05-19 00:00:00.000',
  'JD',
  'e46c9a3f-d565-40e6-93a4-bac07ebe4e7a',
  273921,
  '5ee4c83e-c94e-49a8-a03f-b5b3908826ea',
  '42409bc5-a377-43ef-8c87-6d8a428f363a',
  '{"status": "Updated", "data": [ {"key": "comments","data_type": "text", "new_value": "the child removal was re-opened with the datafix ticket CJAMS-63738.","display_name": "Comments"}]}');
  
 
 -- 3) Change the Placement Exit Type from Permanently Leaving Custody & Care to Change In Placement Structure.

 /*
--42409bc5-a377-43ef-8c87-6d8a428f363a: Client ID: 201176602 (Lucas Findley) 
select intakeservreqchildremovalid ,exittypekey ,exittime ,* from placement p where servicecaseid = '5ee4c83e-c94e-49a8-a03f-b5b3908826ea' 
and activeflag =1
--and intakeservreqchildremovalid = ''
order by updatedon desc;
*/

update cjams.placement  
set exittypekey = 'CIPS',
	exitreasontypekey = null,--ADNRE
	updatedon = now(), 
	updatedby = 'CJAMS-63738'
where placementid = 'fd442382-d912-4172-9346-de0eb9e592ba'
	and activeflag  = 1;

/*
select * from placementrevision p 
where placementid = 'fd442382-d912-4172-9346-de0eb9e592ba'
	and activeflag  = 1;
*/

update cjams.placementrevision  
set 
    exittypekey = 'CIPS',
    exitreasontypkey = null,--ADNRE
	updatedon = now(),
	updatedby = 'CJAMS-63738'
where placementrevisionid = '5826dd8b-397e-431d-a0a0-982ff8825329' and activeflag  = 1;  
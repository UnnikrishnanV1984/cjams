/* 
    Issue Description: CDM-38023
   Category/ Module  : Approval
   Root cause:  intake is currently stuck under pending status. old intake the values are not populating correctly.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/


update routing set updatedby = '55c8ea0d-98d3-455a-98ec-db067c1ec65d', routingstatustypeid = 8 where 
routingid = '9d18174f-6c4a-4744-8f25-25bd7b204f95' and eventcode = 'INTR' and activeflag = 1;

update intakeservicerequest set intakeservreqinputtypeid='9d5ab74f-4b48-4f80-b5ec-405286241efe',
intakeservreqtypeid='d207bdd4-f281-4ec8-949c-8fd9657227f9' where intakenumber = 'CW9980069';
INSERT INTO intakeservicerequestservice (intakeserviceid,intakeservreqservicekey,teamtypekey,insertedby,
insertedon,updatedby,updatedon,activeflag,old_id,etl_userid,etl_load_date) VALUES
	 ('d5554ee4-7872-46aa-8d28-89b86413b4c6','CPSHC','CW','CW9980069','2020-07-17 09:49:11','CW9980069',
     '2020-07-17 10:00:59',1,'CW9980069','Data Migration','2020-07-25');

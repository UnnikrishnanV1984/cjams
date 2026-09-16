/*
   Issue Description: CDM-25678
   Category/ Module  : child removal 
   Root cause: user requested 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


update cjams.intakeservreqchildremoval set activeflag =0, updatedby='CDM-25678', updatedon =now()

where intakeservreqchildremovalid ='7e8dc9e8-80ce-4124-87bf-9f03c3e26e50';


update cjams.tb_client_eligibility set delete_sw ='Y', update_user_id='CDM-25678', update_ts =now()

 where removal_id ='252547';

update cjams.personprogramarea set activeflag =0, updatedby='CDM-25678', updatedon =now()

where personprogramid ='bca8f2a4-1789-4a4a-b5b1-2cdb632e662b';


update cjams.personprogramarea set startdate ='2021-08-16 00:00:00', updatedby='CDM-25678', updatedon =now()

where personprogramid ='30899598-6a1a-408f-bd4a-36b77312a10e';


update cjams.intakeservreqchildremoval set removaldate ='2021-08-16 00:00:00', updatedby='CDM-25678', updatedon =now()

where intakeservreqchildremovalid ='cd3b3afa-973f-4e0f-8e19-b40a203e82b6';


update cjams.tb_client_eligibility set start_dt ='2021-08-16', update_user_id='CDM-25678', update_ts =now()

 where removal_id ='252547' and delete_sw = 'N' ;


 
update cjams.placement set intakeservreqchildremovalid ='cd3b3afa-973f-4e0f-8e19-b40a203e82b6', updatedby ='CDM-25678', updatedon =now()
where placementid ='a8f045a5-a7c8-41e7-a154-33c9f99cf0bb';


update cjams.routing set activeflag =0, updatedby ='CDM-25678', updatedon =now()
where routingid ='c3d814b6-b197-43bf-9fb5-da7dddabace3';

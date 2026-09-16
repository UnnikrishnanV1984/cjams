/*
   Issue Description: CDM-28329
   Category/ Module  :  Removal Date revision
   Root cause: user wants to edit removal date
   Pull request# for data fix: 6420,7834
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update intakeservreqchildremoval set removaldate ='2022-02-15 00:00:00', updatedby ='CDM-28329', updatedon = now()
where intakeservreqchildremovalid ='08661b84-279e-4021-94b6-69c2cedee4d6';

update personprogramarea set startdate = '2022-02-15 00:00:00',updatedon = now(), updatedby = 'CDM-28329'
where personprogramid='5e780db6-a0e9-4d08-ae5f-1d9a0ebd523f';

update tb_client_eligibility set start_dt ='2022-02-15 00:00:00',update_ts = now(), update_user_id = 'CDM-28329'
where eligibility_id='10004411';
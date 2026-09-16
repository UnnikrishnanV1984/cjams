/*
   Issue Description: CDM-27838
   Category/ Module  :  Removal Date revision
   Root cause: user wants to edit removal date
   Pull request# for data fix: 6420
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update intakeservreqchildremoval set removaldate  = '2021-07-21 00:00:00',updatedon = now(), updatedby = 'CDM-27838'
where intakeservreqchildremovalid='f76ee354-b77b-452d-9e8b-93b96cda9af8';


update personprogramarea set startdate = '2021-07-21 00:00:00',updatedon = now(), updatedby = 'CDM-27838'
where personprogramid='4519aa37-5b71-4140-b474-d6a28f797d1b';


update tb_client_eligibility set start_dt ='2021-07-21 00:00:00',update_ts = now(), update_user_id = 'CDM-27838'
where eligibility_id='10001712';

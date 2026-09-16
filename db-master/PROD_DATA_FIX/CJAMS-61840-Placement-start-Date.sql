/*
Issue Description:data fix is needed to update the latest placement start date from 11/01/2024 to 02/16/2024 for SAMIRA JONES (PID# 3706333). So CJAMS will creating a system adjustment payment then Finance can write-off the AR for Samira Jones.
Root cause: User requert to adjust the dates due to they do not access do that.
Fix provided: DB query to udate placement.
Data/Code fix ticket#:CJAMS-61840
Regression Impacts: N/A
Is Code fix Required?: Yes
Code fix ticket#:  no
Reason why no related code fix:User error, not logic error.
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

update placement
set startdatetime = '2024-02-16 00:00:00',updatedby ='CJAMS-61840',updatedon=now()
where placementid='73baad22-de89-4eef-bfe5-459f6352414d' and activeflag=1;

update  placementrevision 
set entrydate  = '2024-02-16 00:00:00',updatedby ='CJAMS-61840',updatedon=now()
where placementrevisionid  in ('68acae68-a0ee-4588-b3e8-08fa13a5cdc9','8547f507-0a90-46cd-9526-48a8fdddf594') ;


update tb_placement_validation
set delete_sw = 'N',
validation_start_dt = '2024-02-16',
update_user_id = 'CJAMS-61840',
update_ts = now()
where placement_id = 1852310
and delete_sw = 'Y' ;


update tb_placement_validation
set validation_start_dt = '2024-02-16',
update_user_id = 'CJAMS-61840',
update_ts = now()
where placement_id = 1852310
and placement_validation_id = 2178602
and delete_sw = 'N' ;

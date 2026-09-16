/* 
    Issue Description: CJAMS-58375
   Category/ Module  : Child removal 
   Root cause: User requested add child removal end date which was missing due to invalid manual placement added though (CDM-44106)
   Pull request# for code fix: 
   Reason why no related code fix: Invalid data fix (CDM-44106)
*/

update personprogramarea 
set enddate= '2024-09-27 01:00:00',
    updatedby = 'CJAMS-58375',
    updatedon= now()
where personprogramid in ('03315fa5-5304-4abb-b9ed-bb39688a8033','277626da-35af-4a8e-b29b-6b4b6e9ddeeb');


update Intakeservreqchildremoval
set exitdate= '2024-09-27 01:00:00',
    updatedby = 'CJAMS-58375',
    updatedon = now()
where intakeservreqchildremovalid ='eebd8bb7-0c8f-4a91-acb5-5c99652e5666';


update tb_client_eligibility
set end_dt = '2024-09-27 01:00:00',
    update_user_id = 'CJAMS-58375',
    update_ts = now()
where removal_id = 308011 and case_id = 241030279693;
/*
Ticket no:- CJAMS-67829
Root cause: Account Receivable data issue for this provider # 5015042 (Receivable Collection Status is having active_sw as null for ARs created in back 2021).

Fix Provided: Datafix has been promoted to active_sw as ‘Y’. 

Reason why no related code fix: Data issue, only one time data cleanup is required.

*/

update cjams.tb_receivable_collection_status set active_sw = 'Y', update_ts = now(), update_user_id  = 'CJAMS-67829'
where collection_status_id  in (
23916061, 23916062, 23916060, 23916059, 23916058, 23916057, 23916056, 23916055, 23916054, 23916053,
23916052, 23916051, 23916050, 23916049, 23916048, 23916047, 23916046, 23916045, 23916044, 23916043,
23916042, 23916041, 23916040, 23916039, 23916038, 23916037, 23916036, 23916035, 23916034, 23916033,
23916032, 23916031, 23916030, 23916029, 23916028, 23916027, 23916026, 23916025, 23916024, 23916023,
23916022, 23916021, 23921281, 23921282, 23921283, 23921284, 23921256, 23921257, 23921258, 23921259,
23921260, 23921261, 23921262, 23921263, 23921264, 23921265
)
and delete_sw = 'N'
and active_sw is null ;
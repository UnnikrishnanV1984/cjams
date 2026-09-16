/*
   Issue Description: CIDM-10049
   Category/ Module : IV-E GAP
   Root cause: Data fix for CIDM-9958 IV-E GAP - GAP initial data should pick based on GuardianSubsidyID
   Fix Provided: Did data fix to update guardian subsidy id

*/

----Updating caseid where it is null in tb_client_eligibility

update tb_client_eligibility tce
set case_id  = tgs.case_id , update_user_id ='CIDM-10049',update_ts = now()
from tb_guardian_subsidy tgs
where tce.delete_sw ='N' and tgs.delete_sw ='N' and tce.client_id = tgs.client_id  and tce.case_id is null
and tgs.client_id in (
'2090516',
'3622331') ;

--Updating guardian subsidy id where it is null in tb_client_eligibility
update tb_client_eligibility tce
set guardian_subsidy_id = tgs.guardian_subsidy_id, update_user_id ='CIDM-10049',update_ts = now() 
from tb_guardian_subsidy tgs
where tce.delete_sw ='N' and tgs.delete_sw ='N' and tce.case_id = tgs.case_id and tce.guardian_subsidy_id is null
and tgs.client_id in (
'3637750',
'200138012',
'4488198',
'3283058',
'4464906',
'4256853',
'3882204',
'200018324');



--Soft deleting gapeligibility info table with more than one active record.


--Client-id:- 2654841
update gapeligibilityinfo
 set activeflag = 0, updatedby = 'CIDM-10049', updatedon = now()
 where activeflag = 1 and client_id = 2654841 and gapeligibilityinfoid in (
 '09d8a402-2d3b-4fe1-a03d-c6a0f79d7652',
'65e6bfbd-481f-4392-9f0b-4eae655c335b',
'0e43db71-8693-43f4-ab5d-3c40b805ef2f',
'85fb4e8c-bfae-479b-8d77-263529c62448',
'efd5c264-d8a4-4ae8-b8ad-445190464604',
'7e5920ab-4e3f-44c4-b008-8b949ef6e88e',
'c9278396-b1eb-48fb-8900-f2521c0869a0',
'a902c7ca-24ac-4c0a-b697-d81b4d10a1c5'
 );

 --Client-id:- 2332541

 update gapeligibilityinfo
 set activeflag = 0, updatedby = 'CIDM-10049', updatedon = now()
 where activeflag = 1 and client_id = 2332541 and gapeligibilityinfoid in (
 '387b7300-5195-4c83-8a11-decd8f7c2000',
'bf4e6d46-bddf-49e5-af56-a904dc051d6f',
'eda65b37-10e2-4b5a-9841-2811fddc9e82',
'274d8c36-abe9-4c6a-a6ee-f8b3404bf702',
'b2af4f62-1778-48c9-a62f-2c341abd132d'
 );

 --Client-id:- 3597446 
 update gapeligibilityinfo
 set activeflag = 0, updatedby = 'CIDM-10049', updatedon = now()
 where activeflag = 1 and client_id = 3597446 and gapeligibilityinfoid in (
 'e9210ee2-9d92-44a4-b998-955e76a26756',
'c2749ef8-f8cd-4c50-80ce-a1be19fec339',
'1ed66447-a16e-4818-8e29-b245ffa0441e',
'f549a7ca-47fc-4237-bb24-2ce1751d01c6',
'a632be9e-ff39-4b4d-900f-41f2fb075cc0',
'd05309c1-c0e4-4187-b215-8a9185592805',
'3bba8ddc-0d7c-4121-b31f-b268b49dca36',
'4686d4b9-2b7a-4391-939e-091c34f544dd',
'751465d2-3b42-41dd-ae0b-2aeee5b52b70',
'26ad6886-eb2f-4a8f-a30f-2c982ef27bf5',
'ffa0cc06-a233-43a8-8850-a95cca1e7534',
'a61fafca-b3d9-41e3-b13d-50b9a57c83d3',
'45243145-15af-48c4-a911-2545dda4bd22',
'fb7ca754-a48b-4e42-abb6-556868f14dcf'
 );

  ----Client-id:- 3900044 
   update gapeligibilityinfo
 set activeflag = 0, updatedby = 'CIDM-10049', updatedon = now()
 where activeflag = 1 and client_id = 3900044 and gapeligibilityinfoid in (
 'c1fd2c92-791b-4f58-b9df-31befdbbbf80',
'227bb9b6-5b97-4ace-aaea-75a5b26fab01',
'75d151c4-eed9-481d-90ac-904c282c8f25',
'a9530bf1-4c3c-4d9c-ac6a-81a6231d92c4',
'9ab40859-7031-4994-97b2-5fa17f33049a'
 );

   --Client-id:- 200137365
   update gapeligibilityinfo
 set activeflag = 0, updatedby = 'CIDM-10049', updatedon = now()
 where activeflag = 1 and client_id = 200137365 and gapeligibilityinfoid in (
 'f2ec5c7f-ea63-4efb-ade6-80da9a8b1230',
'0e59dad1-726c-42cf-bf3c-196ca23aac2e'
 );

----Client-id:-3566688
    update gapeligibilityinfo
 set activeflag = 0, updatedby = 'CIDM-10049', updatedon = now()
 where activeflag = 1 and client_id = 3566688 and gapeligibilityinfoid in (
 '82224605-adbe-4e3d-90a8-bcc3cf9e5355',
 'e29868be-b2a4-48eb-ba59-a08d636a1d76',
'4c5c91a7-b558-4dd4-9101-8fc38c3ba78e',
'2f27afde-26cb-4784-b4f8-1e9bc6c9363e'
 ); 
     
--Client-id:- 3817911

update gapeligibilityinfo
 set activeflag = 0, updatedby = 'CIDM-10049', updatedon = now()
 where activeflag = 1 and client_id = 3817911 and gapeligibilityinfoid in (
 '6eab038e-615e-45b6-bee6-5e7ac146a4d3'
 );

--Client-id:- 4306659
update gapeligibilityinfo
 set activeflag = 0, updatedby = 'CIDM-10049', updatedon = now()
 where activeflag = 1 and client_id = 4306659 and gapeligibilityinfoid in (
 'd9c057a7-6208-4416-a75b-81a3428a0ce5',
'400e1384-f6b3-4492-9b7c-09100231fa22',
'0647cd56-251e-4b7d-9f5e-e041b89d4d01',
'c11027f8-99b3-4e58-91da-b835b81b37fa'
 ); 

--Client-id:- 3861288
update gapeligibilityinfo
 set activeflag = 0, updatedby = 'CIDM-10049', updatedon = now()
 where activeflag = 1 and client_id = 3861288 and gapeligibilityinfoid in (
 'e99824b1-9e69-4ed3-928a-5abc3f5879fc',
'2c43c3af-48f9-4b9f-800c-7dfb6d85c95c',
'a5e06a5e-1162-4c92-bf07-f9a56bee5cb3',
'607ba0ea-e088-426f-a2f9-190f89c2d41a',
'2e38eef7-2bab-4fbe-8de7-eb9d1a5164b1',
'631d3af7-8029-4b81-8ef8-0363de042a9c',
'b4afb344-e73f-457d-9f92-36fc519ce9e2',
'15f293e0-e6c6-4fd4-a63f-3af6ce322d78',
'1bc3e300-3d62-47da-b379-010cec3ebef0',
'47a2781c-8733-4155-adb2-ce18ad3cf665'
 );
        
--Client-id:- 3729757

update gapeligibilityinfo
 set activeflag = 0, updatedby = 'CIDM-10049', updatedon = now()
 where activeflag = 1 and client_id = 3729757 and gapeligibilityinfoid in (
 'fa9aaa8e-45db-470e-b972-18e13e2d7cd3',
'3493f7b6-b908-4f01-b8ce-0da3dc1f4d5a',
'94930bc5-769e-44e7-bb6a-1111e96b5fb3'
 );
 
--Client-id:- 3957255
update gapeligibilityinfo
 set activeflag = 0, updatedby = 'CIDM-10049', updatedon = now()
 where activeflag = 1 and client_id = 3957255 and gapeligibilityinfoid in (
 '660ea2bc-c2f2-47ee-8723-d642943fd946',
'83ae986f-09d7-412c-9af7-3cdfba907d95',
'dc1ed15f-97c7-417b-8628-7bfbec87b17e'
 );
 
--Client-id:- 4012994
update gapeligibilityinfo
 set activeflag = 0, updatedby = 'CIDM-10049', updatedon = now()
 where activeflag = 1 and client_id = 4012994 and gapeligibilityinfoid in (
 'b121bcfd-8a81-4712-9149-0e4c407c2a58'
 );

---Updating case number in gapeligibility info
UPDATE gapeligibilityinfo gei
SET casenumber = tce.case_id, updatedby='CDM-10049', updatedon = now()
FROM tb_client_eligibility tce
WHERE tce.client_id::bigint = gei.client_id
  AND gei.activeflag = 1
  AND gei.casenumber IS NULL
  AND tce.delete_sw = 'N'
  AND tce.client_id in('2332541',
'3516645',
'3629179',
'3817911',
'3861288',
'3900044',
'3957255',
'200137365', '4012994' ) ;

---Updating case number in tb_client_eligiblty when it is null
UPDATE tb_client_eligibility tce
SET  case_id = gei.casenumber::bigint, update_user_id='CIDM-10049', update_ts=now()
FROM  gapeligibilityinfo gei
WHERE  tce.client_id::bigint = gei.client_id
 and tce.eligibility_type_cd = '2935'
  AND gei.activeflag = 1
  AND gei.casenumber IS NOT NULL
  AND tce.delete_sw = 'N'
  AND gei.client_id in ('2768123', '3340856');


--Query to update GUARDIAN SUBSIDY ID in gapeligibilityinfo table from tb_client_eligibility table. 

 WITH OrderedGap AS (
    SELECT g.client_id,g.casenumber :: bigint ,g.guardian_subsidy_id, g.guardianshipapplicationdate 
    FROM gapeligibilityinfo g
    WHERE g.activeflag = 1
),
OrderedTCE AS (
    SELECT tce.client_id,tce.case_id, tce.guardian_subsidy_id, tce.start_dt,
           ROW_NUMBER() OVER (PARTITION BY tce.client_id ORDER BY tce.start_dt desc,tce.end_dt DESC) AS rn
    FROM tb_client_eligibility tce
    WHERE tce.delete_sw = 'N' AND tce.eligibility_type_cd = '2935'
)
UPDATE gapeligibilityinfo g
SET guardian_subsidy_id = tce.guardian_subsidy_id, updatedby = 'CIDM-10049', updatedon= NOW()
FROM gapeligibilityinfo ge
JOIN OrderedGap og ON ge.client_id = og.client_id
JOIN OrderedTCE tce ON og.client_id = tce.client_id 
WHERE g.client_id = og.client_id
and G.casenumber :: bigint = tce.case_id 
  AND tce.rn = 1; 


--2 records didn't get updated after Bulk datafix.


  update gapeligibilityinfo 
 set guardian_subsidy_id = 		2177, updatedby ='CIDM-10049', updatedon = now()
 where client_id = 1014436 and casenumber = '3172741' and guardian_subsidy_id is null and activeflag =1;

update gapeligibilityinfo 
 set guardian_subsidy_id = 4593, updatedby ='CIDM-10049', updatedon = now()
 where client_id = 2640214 and casenumber = '3175006'  and guardian_subsidy_id is null and activeflag =1;


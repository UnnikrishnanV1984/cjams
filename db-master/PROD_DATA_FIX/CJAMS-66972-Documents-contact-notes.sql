
/*
Issue Description:CJAMS-66972
  Root cause: 
  
New service case - 261030669200
Old service case - 3185929

Data fix needed to move the following data from case# 3185929 to case# 261030669200 and remove it from the case# 3185929:

1. Contact notes starting on page 5 with date of 9/11/2025 Contact ID: 15316437
Through to page 1 with date of 4/3/2025 Contact ID;  16111895.
48 contact notes(15316437, 15330876, 15338157, 15361632, 15361671, 15420025, 15438176, 15456034, 15493355, 15533046, 15533058, 15533082, 15533096,15533111, 15533125, 15533139, 15533162, 15533205, 15533222, 15533232, 15547866, 15552350, 15552368,15552621, 15566042, 15568176, 15589797, 15601966, 15636343, 15663949, 15668135, 15684521, 15688379, 15696125,15738487, 15753867, , 15796241, 15802955, 15891199, 15958491, 15966088, 15971175, 15982204, 16003418, 16042321, 16054950, 16068083, 16111895)
2. CANS F Assessment - All 5 assessments with updated date - 03/24/2026 - 9:15:48 AM, 12/16/2025 - 11:41:03 AM, 11/20/2025 - 11:49:35 AM, 09/24/2025 - 3:34:45 PM, 09/05/2025 - 4:46:04 PM
3. FACILITATED MEETING REFERRAL FORM with updated date -12/17/2025 - 10:40:31 AM
4. PADS Form - 09/24/2025 - 3:33:51 PM
5. MARYLAND FAMILY RISK REASSESSMENT with updated date - 03/24/2026 - 9:12:23 AM, 12/19/2025 - 12:54:38 PM, 11/20/2025 - 1:03:57 PM, 09/24/2025 - 3:35:54 PM
6. *SAFE-C *- 09/11/2025 - 4:37:16 PM, 09/24/2025 - 3:10:49 PM, 11/20/2025 - 3:23:24 PM, 12/19/2025 - 12:46:47 PM, 12/23/2025 - 4:37:40 PM, 01/05/2026 - 12:17:45 PM, 03/16/2026 - 2:01:39 PM
7. *Service Plan *- FRIEND Family Service plan(09/24/2025 to 09/22/2026) along with all the 3 versions.
8. Documents:
Document Name - Uploaded date
TF Release GCBOE.pdf - 09/23/2025 10:55 AM
TF Family Assmt.pdf - 09/23/2025 10:53 AM
TF Iinitial SA.pdf - 09/23/2025 10:56 AM
Friend Supervision.pdf - 09/22/2025 01:25 PM
SKM_C4051i26030314030.pdf - 03/03/2026 03:02 PM
SKM_C361i26022008360.pdf - 02/20/2026 09:16 AM
PF IEP12-4-25.pdf - 01/02/2026 10:30 AM
TF Service Plan 11-21-25.pdf - 12/08/2025 02:38 PM
State of Maryland - Department of Human Services (13).pdf - 11/17/2025 03:42 PM
Friend Supervision (1).pdf -10/09/2025 03:20 PM
IN-HOME FAMILY SERVICES REFERRAL REVISED Paige.pdf - 09/30/2025 11:15 AM
0099_001.pdf - 09/30/2025 10:54 AM
TF Family Assmt.pdf - 09/23/2025 10:53 AM
TF Referral.pdf - 09/23/2025 10:59 AM
9. Service Agreement with agreement date -09/17/2025

   Fix provided : 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date:  
   Backup before update/ delete:
*/





update progressnote
set entitytypeid='06fb3fa2-f8d3-4e5f-a807-6eb786586669', servicecaseid='06fb3fa2-f8d3-4e5f-a807-6eb786586669', updatedby = 'CJAMS-66972', updatedon = now()
where witsid in ('15316437', '15330876', '15338157', '15361632', '15361671', '15420025', '15438176', '15456034', '15493355', 
'15533046', '15533058', '15533082', '15533096', '15533111', '15533125', '15533139', '15533162', '15533205', '15533222', '15533232', 
'15547866', '15552350', '15552368', '15552621', '15566042', '15568176', '15589797', '15601966', '15636343', '15663949', 
'15668135', '15684521', '15688379', '15696125', '15738487', '15753867', '15796241', '15802955', '15891199', '15958491', 
'15966088', '15971175', '15982204', '16003418', '16042321', '16054950', '16068083', '16111895') 
and servicecaseid='1a17ca5d-cfe2-4ab5-8893-da6b7aa07a83' and activeflag=1;  

--Update assessments

update assessment
set servicecaseid='06fb3fa2-f8d3-4e5f-a807-6eb786586669', updatedby='8e3e83ca-0693-4fe5-af19-62ac4a60b5b8'
where  servicecaseid='1a17ca5d-cfe2-4ab5-8893-da6b7aa07a83' 
and activeflag = 1 and assessmenttemplateid ='e348d7c4-a392-447a-ba42-17078941a721' and assessmentid in ('a3c21cf6-cc17-4466-aa48-55173d7ca1a3',
'a7ebd683-fb2e-46c0-81b8-f8108a817879',
'cc9243bb-b4b3-47a5-a176-7c421f903521',
'f031cfe4-2c62-4019-b9b0-e8acef95783d',
'c837e7a5-bbec-4424-ad2d-91c55ddf94cc');




update assessment
set servicecaseid='06fb3fa2-f8d3-4e5f-a807-6eb786586669' , updatedby='8e3e83ca-0693-4fe5-af19-62ac4a60b5b8'
where  servicecaseid='1a17ca5d-cfe2-4ab5-8893-da6b7aa07a83' 
and activeflag = 1 and assessmentid = '2315eacf-e1af-458c-8984-57524cb0baf9';

update assessment
set servicecaseid='06fb3fa2-f8d3-4e5f-a807-6eb786586669', updatedby='8e3e83ca-0693-4fe5-af19-62ac4a60b5b8'
where  servicecaseid='1a17ca5d-cfe2-4ab5-8893-da6b7aa07a83' 
and activeflag = 1 and assessmentid = '907fc6ab-ea07-4f9b-9029-60d0755932d6';

update assessment
set servicecaseid='06fb3fa2-f8d3-4e5f-a807-6eb786586669' , updatedby='8e3e83ca-0693-4fe5-af19-62ac4a60b5b8'
where  servicecaseid='1a17ca5d-cfe2-4ab5-8893-da6b7aa07a83' 
and activeflag = 1 and assessmentid in ('7abd4138-f223-42db-bd4b-4696bed1724f','988b0ada-eb4a-4314-98d7-eb7fa092f41d','94099412-8d37-4d4e-9ca6-526c2a0aac47','bf7990b0-093c-4825-b19a-60b6e4c3b651');



update assessment
set servicecaseid='06fb3fa2-f8d3-4e5f-a807-6eb786586669' , updatedby='8e3e83ca-0693-4fe5-af19-62ac4a60b5b8'
where  servicecaseid='1a17ca5d-cfe2-4ab5-8893-da6b7aa07a83' 
and activeflag = 1  and assessmentid in ('250b08f4-103e-45f3-9312-208ec7eac2b6','2c948dca-6117-49bd-8a0c-8a3b14547a4a','e6607aa2-7679-4172-9489-153a2badab71','3c0327b1-366a-496d-b58d-ab0cc2826ca0','383c1672-e4d9-4e0a-b120-0f6f934885fc','e6607aa2-7679-4172-9489-153a2badab71',
'94fc891d-af56-4243-912a-a13f67784fb4') ;

update assessment
set servicecaseid='06fb3fa2-f8d3-4e5f-a807-6eb786586669' , updatedby='da23f52d-6348-413b-9e37-0de2ab823825'
where  servicecaseid='1a17ca5d-cfe2-4ab5-8893-da6b7aa07a83' 
and activeflag = 1  and assessmentid in ('48a8ba20-5e83-4142-ae73-cdc8faa58883') ;


--7. *Service Plan *- FRIEND Family Service plan(09/24/2025 to 09/22/2026) along with all the 3 versions.

update serviceplan
set objectid='06fb3fa2-f8d3-4e5f-a807-6eb786586669', updatedby ='CJAMS-66972', updatedon =now()
where serviceplanid ='91092a5e-3616-4a86-8455-88e3b1e50ba4' and objectid='1a17ca5d-cfe2-4ab5-8893-da6b7aa07a83' and activeflag =1;

/*
8. Documents:
Document Name - Uploaded date
TF Release GCBOE.pdf - 09/23/2025 10:55 AM
TF Family Assmt.pdf - 09/23/2025 10:53 AM
TF Iinitial SA.pdf - 09/23/2025 10:56 AM
Friend Supervision.pdf - 09/22/2025 01:25 PM
SKM_C4051i26030314030.pdf - 03/03/2026 03:02 PM
SKM_C361i26022008360.pdf - 02/20/2026 09:16 AM
PF IEP12-4-25.pdf - 01/02/2026 10:30 AM
TF Service Plan 11-21-25.pdf - 12/08/2025 02:38 PM
State of Maryland - Department of Human Services (13).pdf - 11/17/2025 03:42 PM
Friend Supervision (1).pdf -10/09/2025 03:20 PM
IN-HOME FAMILY SERVICES REFERRAL REVISED Paige.pdf - 09/30/2025 11:15 AM
0099_001.pdf - 09/30/2025 10:54 AM
TF Family Assmt.pdf - 09/23/2025 10:53 AM
TF Referral.pdf - 09/23/2025 10:59 AM
*/


update documentproperties
set servicerequestid='06fb3fa2-f8d3-4e5f-a807-6eb786586669',rootobjectid='06fb3fa2-f8d3-4e5f-a807-6eb786586669', servicecaseid='06fb3fa2-f8d3-4e5f-a807-6eb786586669', objectid='06fb3fa2-f8d3-4e5f-a807-6eb786586669',
	updatedby = 'CJAMS-66972',
	updatedon = now()
where documentpropertiesid in ('db22e31c-ac50-446b-a956-6d9958b6aa67','8daf249b-c4d0-4017-9332-d6dc80cf1be8','21d98adf-1d55-48dc-a042-fab3d1e2d4fe',
  'c1a1843a-2932-4460-9419-352404b31090','451082f2-c3e2-4098-9ca7-477ed272b014','adda4541-78a5-4402-bcdc-5df8cc4d588c','2eb356c9-edc6-4753-842d-d532c868ed70',
  'bc45a773-ffc6-47a4-8960-0593e6eefd9e','72ea564a-8dc1-4e08-ae9b-757ff865322b','4cbceb8c-52dd-49c1-bc4e-e7dd497681e2',
  '6b36fc76-6f28-4d15-907f-fcbb90f9e232','002e89ed-b0c0-426a-8e90-15554bbee0fe','172515d8-86a4-4050-96e2-61e2a80d1137')
 	  and objectid='1a17ca5d-cfe2-4ab5-8893-da6b7aa07a83' and activeflag = 1 ;

-- 9. Service Agreement with agreement date -09/17/2025
update serviceagreement 
set caseid ='06fb3fa2-f8d3-4e5f-a807-6eb786586669', updatedon = now(), updatedby = 'CJAMS-66972' 
where agreementid ='7f03127a-3770-4eb0-9a4f-1d007b93cd01' and caseid ='1a17ca5d-cfe2-4ab5-8893-da6b7aa07a83' and activeflag =1;
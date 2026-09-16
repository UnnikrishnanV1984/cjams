 /*
   Issue Description: CDM-38045 End Date Living Arrangement
   Category/ Module  : Placement
   Root cause: Cjams won't let me end date a living arrangement. 
   Fix Provided: Data fix has been promoted to update the placement table and insert records into living arrangements table
   Code fix ticket#: N/A
   Reason why no related code fix: N/A 
   Status of the code fix if already submitted and expected prod fix date: N/A
   Backup before update/ delete: N/A
*/


insert into livingarrangement
 (livingid, livingstartdate, insertedon, insertedby, updatedon, updatedby, personid, placementid)
 (select gen_random_uuid(),'2024-03-15 00:00:00', now(),'CDM-38045',now(),'CDM-38045','f01818b6-ffb5-4115-825c-dba19f90eb36','62113f04-fe03-42e4-a93a-19adbfec8aeb');
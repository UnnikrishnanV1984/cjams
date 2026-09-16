/*
  Issue Description:  CDM-44229
   Category/ Module  :  Documents
   Root cause: Data fix to transfer all of the uploaded documents and contact notes 
    starting on 9/29/2022 until now to be moved from case 3183181 to case 251030456662.
   Pull request# for code fix: NA
   Reason why no related code fix: NA
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: NA
*/

 update progressnote set servicecaseid = '4ee75cff-1d0f-4a38-9447-71f1a95604ed',entitytypeid = '4ee75cff-1d0f-4a38-9447-71f1a95604ed',
 updatedby = 'CDM-44229', updatedon = now()
 where servicecaseid = '297693ee-e0b3-452a-a807-fec780868f37'
AND contactdate BETWEEN '2022-09-29 00:00:00' AND '2025-02-20 00:00:00'
AND activeflag = 1;

update documentproperties set servicecaseid = '4ee75cff-1d0f-4a38-9447-71f1a95604ed', updatedby = 'CDM-44229'
where servicecaseid = '297693ee-e0b3-452a-a807-fec780868f37' and documentdate BETWEEN '2022-09-29 00:00:00' AND '2025-02-20 23:59:59';

update documentproperties set objectid = '6034e7b2-51b6-4dad-a474-823158874482', updatedby = 'CDM-44229'
where objectid = '50b2302b-0120-49a7-8734-36f65a5f9d73' and documentdate BETWEEN '2022-09-29 00:00:00' AND '2025-02-20 23:59:59';

  


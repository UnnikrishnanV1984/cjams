/*
   Issue Description: CDM-34464
   Category/ Module  : Document    
   Root cause: purchaseAuth tab unsaved records inserted duplicated in loop due to glich , chekced with new case it is working as expected 
   Fix Provided: Did data fix to remove those duplicate record 
*/


update cjams.documentproperties set activeflag  =0,
updatedby ='CDM-34464', updatedon  = now()
where objectid='8b8dc955-cfdd-4fc0-9f9e-29e416e89a80' and objecttypekey ='purchaseAuthReceipt'  and activeflag =2;
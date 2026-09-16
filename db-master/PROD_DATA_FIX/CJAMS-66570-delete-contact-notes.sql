/*
   Issue Description: CJAMS-66570
   Category/ Module: Contact Notes
   Root cause: User requested to data fix to remove the contact notes 16005082, 16004574
   Fix Provided: Data fix was done by removing 16005082, 16004574
   Code Fix: Not Needed
*/

update progressnote 
set activeflag =0, updatedby ='CJAMS-66570', updatedon =now()
where witsid in ('16005082', '16004574') and activeflag =1;

update progressnotedetail 
set activeflag =0, updatedby ='CJAMS-66570', updatedon =now()
where progressnoteid in('0b3348f7-8ac2-4852-9fd7-d85d19bee2dd', '71807f60-5a86-479e-b1be-e8de61f64151') and activeflag =1;

update progressnote_audit_detail 
set activeflag=0, updatedby ='CJAMS-66570', updatedon =now()
where auditdetailid in ('6d703c89-cc26-474d-bb4e-5cdb46c85208', 'ac5ecbff-fe92-4324-95e4-9ab33e0c328d') and activeflag =1;

update  contactparticipant 
set  activeflag=0, updatedby ='CJAMS-66570', updatedon =now()
where progressnoteid in ('0b3348f7-8ac2-4852-9fd7-d85d19bee2dd', '71807f60-5a86-479e-b1be-e8de61f64151') and activeflag =1;
/*
   Issue Description: CDM-20123
   Category/ Module  : Contact notes
   Root cause: User Error, user wants to remove the duplicate contact notes
*//*
select * from progressnote p where progressnoteid = 'c8c82974-9f32-4642-bb11-e55ce57364fc';
select * from progressnotedetail p where progressnoteid = 'c8c82974-9f32-4642-bb11-e55ce57364fc'
*/

UPDATE progressnote 
SET activeflag = 0, updatedby = 'CIDM-10368' , updatedon = now()
WHERE progressnoteid = 'c8c82974-9f32-4642-bb11-e55ce57364fc';

UPDATE progressnotedetail 
SET activeflag  = 0, updatedby = 'CIDM-10368' , updatedon = now()
WHERE progressnoteid = 'c8c82974-9f32-4642-bb11-e55ce57364fc';
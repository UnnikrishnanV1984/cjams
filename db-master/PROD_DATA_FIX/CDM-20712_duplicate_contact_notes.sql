/*
   Issue Description: CDM-20712
   Category/ Module  : Contact notes
   Root cause: user asked to remove duplicate contact notes
*/

UPDATE progressnote 
SET activeflag = 0, updatedby = 'CDM-20712', updatedon = now() 
WHERE progressnoteid in ('d0dc6160-b280-43e3-8861-fef76bb55415', '93be30ed-eef5-4d45-8bf2-b80e51d4abd1', 'f15fe51a-4e04-4d61-aa43-8a22ccbe1391');

UPDATE progressnotedetail 
SET activeflag  = 0, updatedby = 'CDM-20712', updatedon = now()
WHERE progressnoteid in ('d0dc6160-b280-43e3-8861-fef76bb55415', '93be30ed-eef5-4d45-8bf2-b80e51d4abd1', 'f15fe51a-4e04-4d61-aa43-8a22ccbe1391');

/*
Issue Description: CJAMS-62132
Category/Module: Delete Note Request
Root cause: User requested to remove the marked contact note 
Fix provided: Data fix has been done to to remove the marked contact note 
Regression Impacts: N/A
Is Code fix Required?: NO
Code fix ticket#: N/A 
Reason why no related code fix: Data fix needed to correct the user entry error
*/

UPDATE progressnote 
  SET activeflag = 0, 
      updatedby = 'CJAMS-62132' , 
      updatedon = now()
where progressnoteid in('f2862544-663a-4993-a0ea-ecc3aae793d8','87cad873-3398-4744-9024-2981d7b8bf02')
   and activeflag=1;

update progressnotedetail  
   set activeflag = 0,  
       updatedby = 'CJAMS-62132',  
       updatedon = now()
WHERE  progressnoteid in('f2862544-663a-4993-a0ea-ecc3aae793d8','87cad873-3398-4744-9024-2981d7b8bf02')
   and activeflag=1;

update contactparticipant
  SET activeflag = 0, 
      updatedby = 'CJAMS-62132' , 
      updatedon = now()
WHERE progressnoteid in('f2862544-663a-4993-a0ea-ecc3aae793d8','87cad873-3398-4744-9024-2981d7b8bf02')
   and activeflag = 1;

update progressnote_audit_detail
set activeflag = 0,
	updatedby = 'CJAMS-62132',
	updatedon = now()
where progressnoteid in('f2862544-663a-4993-a0ea-ecc3aae793d8','87cad873-3398-4744-9024-2981d7b8bf02')
	and activeflag = 1 ;
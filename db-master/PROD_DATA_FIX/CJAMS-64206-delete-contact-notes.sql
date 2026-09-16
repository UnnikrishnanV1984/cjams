/*
Issue: CJAMS-64206 removal of contact note
Category/Module: Contact Notes
Root cause: Data entry error and user has created a contact note by mistake. Data fix is needed to correct delete the incorrect contact notes.
            Case ID: 231030134152
            Contact ID: 15614816
Fix provided:  Data fix has been done to delete the incorrect contact notes information.
Data/Code fix ticket#: CJAMS-64206
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: This is a data entry error and data fix should resolve it.
*/

UPDATE progressnote 
  SET activeflag = 0, 
      updatedby = 'CJAMS-64206' , 
      updatedon = now()
where progressnoteid in('05039ca4-0db7-4973-bf5e-8badf77fc98f')
   and activeflag=1;

update progressnotedetail  
   set activeflag = 0,  
       updatedby = 'CJAMS-64206',  
       updatedon = now()
WHERE  progressnoteid in('05039ca4-0db7-4973-bf5e-8badf77fc98f')
   and activeflag=1;

update contactparticipant
  SET activeflag = 0, 
      updatedby = 'CJAMS-64206' , 
      updatedon = now()
WHERE progressnoteid in('05039ca4-0db7-4973-bf5e-8badf77fc98f')
   and activeflag = 1;

update progressnote_audit_detail
set activeflag = 0,
	updatedby = 'CJAMS-64206',
	updatedon = now()
where progressnoteid in('05039ca4-0db7-4973-bf5e-8badf77fc98f')
	and activeflag = 1 ;
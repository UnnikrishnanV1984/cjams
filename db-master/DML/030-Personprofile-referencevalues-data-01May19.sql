   delete from referencevalues where referencetypeid='176' and ref_key='CHILD';
   
   INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('CHILD', 176, 'Child', 'Child', NULL, 1, 15, NULL, now(), NULL, now(), NULL, NULL, 'CHILD');

   update referencevalues set ref_key='AM' where referencetypeid='176' and value_text='Alleged Maltreator';
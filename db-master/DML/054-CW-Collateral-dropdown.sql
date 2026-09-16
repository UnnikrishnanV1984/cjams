
delete from referencevalues where  ref_key='AM' and referencetypeid=175 and value_text='Alleged Maltreator';

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag,
displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('AM', 175, 'Alleged Maltreator', 'Alleged Maltreator', NULL, 1, 
3, NULL, current_date, NULL, current_date, NULL, NULL, 'AM');

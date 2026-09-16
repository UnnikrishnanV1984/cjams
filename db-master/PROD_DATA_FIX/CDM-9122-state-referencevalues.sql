insert into referencevalues (ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
select 'LA', referencetypeid, 'Louisiana', 'Louisiana', teamtypekey, 1, 19, 'CDM-9122', now(), 'CDM-9122', now(), parenttypeid, parentkey, 'LA'
from referencevalues where referencetypeid = 211 and ref_key = 'UM';


delete from referencevalues where referencetypeid = 211 and activeflag = 0;
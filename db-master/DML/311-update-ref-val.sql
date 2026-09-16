
INSERT INTO referencetype (referencetypeid, typedescription, tablename, activeflag, insertedby, insertedon, updatedby, updatedon, flag)
VALUES(142, 'School Setting', 'schoolsettings', 1, 'admin', now(), 'admin',now(), NULL);

update referencevalues set ref_key = 'UTC' where value_text = 'College / University' and referencetypeid = 142 ;
update referencevalues set ref_key = 'HS' where value_text = 'Home' and referencetypeid = 142 ;
update referencevalues set ref_key = 'OLI' where value_text = 'None' and referencetypeid = 142 ;
update referencevalues set ref_key = 'ASS' where value_text = 'Parochial' and referencetypeid = 142 ;
update referencevalues set ref_key = 'VO' where value_text = 'Private' and referencetypeid = 142 ;
update referencevalues set ref_key = 'TFC' where value_text = 'Public' and referencetypeid = 142 ;
update referencevalues set ref_key = 'CVS' where value_text = 'Vocational' and referencetypeid = 142 ;


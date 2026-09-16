--D-12061/Suffix not autopopulating for legacy cases
--for id =302 there were spaces before and after each value_text, ref_key, description; 

UPDATE referencevalues SET 
value_text =  trim(value_text)
,ref_key = trim(ref_key)
,description = trim(description)
,updatedby = 'admin'
,updatedon = Now()
WHERE referencetypeid = 302 
AND activeflag = 1;  


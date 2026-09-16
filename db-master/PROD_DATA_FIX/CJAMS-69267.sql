/*
Issue Description: CJAMS-69267 - CPS AR Summary
Category/Module: Maltreatment / AR Summary
Root cause: A duplicate maltreatment record was created for the victim Kenny E Vyles Buisserete on CPS-AR # 261023818185, so the same VICTIM / MALTREATMENT TYPE / ALLEGED MALTREATOR row is displayed twice under the AR Summary tab. The duplicate record has no data recorded against it.
Fix provided: Data fix has been done to remove the duplicate record of the victim Kenny E Vyles Buisserete from the AR Summary tab of CPS-AR # 261023818185. 
Data/Code fix ticket#: CJAMS-69267
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Support
*/

update investigationallegation 
	set activeflag = 0, updatedon = now(), updatedby = 'CJAMS-69267' 
	where investigationallegationid in ('ddfc1d07-5f82-4664-b7a0-014a9f51f517') and activeflag = 1;

update investigationallegationmaltreators 
	set activeflag = 0, updatedon = now(), updatedby = 'CJAMS-69267' 
	where investigationallegationid in ('ddfc1d07-5f82-4664-b7a0-014a9f51f517') and activeflag = 1;
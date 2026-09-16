
/*
    Issue : Updatedon and updatedby were not handled in the personeducation table when inserting a new row
    Solution : Done a code fix to handle the same and data fix to correct the existing data

*/ 
update personeducation 
set updatedby = insertedby, 
    updatedon = insertedon 
where updatedby is null and updatedon is null and activeflag = 1;

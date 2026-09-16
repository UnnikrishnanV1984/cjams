/*
   Issue Description: CDM-41959
   Category/ Module  : Contact Notes
   Root cause: user wants to remove contact notes
   Pull request#
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
 Need to do data fix
*/
/*
select * from progressnote where progressnoteid = 'b0d7a576-ef01-482c-960b-ad4284e8de07' and activeflag = 1;
Note: progressnoteid == referenceid
*/
update progressnote set activeflag = 0, updatedon = now(), updatedby = 'CDM-41959' 
where progressnoteid = 'b0d7a576-ef01-482c-960b-ad4284e8de07';

/*
select * from progressnotedetail where progressnoteid = 'b0d7a576-ef01-482c-960b-ad4284e8de07' and activeflag = 1;
*/
update progressnotedetail set activeflag  = 0, updatedon = now(), updatedby = 'CDM-41959'
where progressnoteid = 'b0d7a576-ef01-482c-960b-ad4284e8de07' and activeflag  = 1;
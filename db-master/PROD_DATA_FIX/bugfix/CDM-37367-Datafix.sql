/*
   Issue Description: CDM-37367
   Category/ Module  :Type of contact note change
   Root cause: re-enter contact note change type from Worker Visit to Face to Face
   Pull request# for code fix: na
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

select progressnotetypeid, progressnotereasontypekey, contactdate, activeflag, updatedby, updatedon
	from progressnote
where witsid = 12061047
	and activeflag = 1 ;

update progressnote
set progressnotetypeid = '786495b2-c779-4cc4-b812-6a8439bfa96e', -- Face To Face
	updatedby = 'CDM-37367',
	updatedon = now()
where witsid = 12061047
	and activeflag = 1 ;
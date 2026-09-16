/*
Issue Description: Please do a datafix to remove the COVID Vaccines completely from the bottom.
Category/ Module : Error
Root cause: Wrong Vaccine was added in Immunization by mistake.
Fix provided: Yes, write Db query
Code fix ticket#: CDM-40073
Reason why no related code fix: Status of the code fix already submitted 
Status of the code fix if already submitted and expected prod fix date: 
void the rejected provider placement from backend
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Upadting personimmunization
update personimmunization
set 
	activeflag = 0,
	updatedby = 'CDM-40073',
	updatedon = now()
where personimmunizationid = 'e3fc332c-387f-4ab3-952e-f155bdcf0852' and activeflag = 1;
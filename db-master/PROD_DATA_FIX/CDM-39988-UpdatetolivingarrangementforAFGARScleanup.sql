/*
Issue Description: The child, Kaden Bolyard PID: 4399261 Living Arrangement for dates: 8/5/2022-9/12/2022 need to have the caregiver updated, as the system will not allow the changes to be made/saved. The caregiver to be identified is Barbara Sweitzer. A previous ticket was completed for this child and closed as it was stated that it was duplicate ticket, which it was not, due to 2 separate tickets were completed for 2 separate children. I was advised by Frank M. to complete a new ticket as Feby was not able to open the closed ticket. That ticket number was: S20240162059427
Category/ Module :BUG
Root cause: BARBARA  SWEITZER should be in primarycaregiver 
Fix provided: Yes, write DB query.
Code fix ticket#: CDM-39988
Reason why no related code fix: Status of the code fix already submitted 
Status of the code fix if already submitted and expected prod fix date: 
void the rejected provider placement from backend
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Modifying record in livingarrangement
update livingarrangement
 set
 	caregiverclientid = '18dc7ae2-8490-4398-914e-c6078b1bd10d',
    primarycaregiver = 'BARBARA  SWEITZER',
    secondarycaregiver = null,
    partnerid = null,
    updatedby = 'CDM-39988',
    updatedon = now()
where livingid = 'cb0fdfad-1ec6-47a9-93a6-42b68b231d0c' and activeflag = 1;
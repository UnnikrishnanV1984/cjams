/* 
    Issue Description: CJAMS-66644
   Category/ Module  : Persons
   Root cause: Alleged Maltreator name is typed in correct that needs to be corrected as - Jose Salvador Carbajal also Date of Birth needs to be corrected as 03/19/1986
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete:
*/

update person 
set firstname = 'Jose', middlename = 'Salvador' , lastname = 'Carbajal', dob = '1986-03-19 00:00:00.000',
updatedby = 'CJAMS-66644', updatedon = now()
where cjamspid = 3409365 and activeflag = 1;

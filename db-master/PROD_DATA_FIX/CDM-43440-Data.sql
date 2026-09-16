/* 
    Issue Description: CDM-43440
   Category/ Module  : Persons
   Root cause: :Data fix to update the client ID# 4435563 profile's to Client name: JOSEPH ANTHONY EARNSHAW & DOB: 6/11/1957
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete:
*/

update person set firstname = 'JOSEPH', middlename = 'ANTHONY' , lastname = 'EARNSHAW', dob = '1957-06-11 00:00:00.000',
updatedby = 'CDM-43440', updatedon = now()
where cjamspid = '4435563' and activeflag = 1;

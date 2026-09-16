/*
 Issue Description:  CDM-41535
 Category/ Module: Persons
 Root cause: In db instead of empty, the coloumn is showing \""\. so it was throwing the pattern error 
 Pull request# for code fix: NA
 Reason why no related code fix: NA
 Status of the code fix if already submitted and expected prod fix date: NO
 Backup before update/ delete: NA
 */

 update person set alienregistrationtext='',
updatedby = 'CDM-41535', updatedon = now()
where personid = 'b27f9916-1596-4525-b7c5-e0c1546f0d1d' and activeflag = 1;
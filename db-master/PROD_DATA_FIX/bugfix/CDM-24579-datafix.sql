/*
   Issue Description: CDM-24579
   Category/ Module  : Service Plan Print version


   Reason why no related code fix: User wanted to update the approval date
   Status of the code fix if already submitted and expected prod fix date: 
   Data fix: Updating approval date in the snapshothist for the Service plan print version
*/
 update snapshothist
 set 	approvaldate = '2022-08-18',
 		updatedby = 'de241831-88ae-4347-b704-345e8bef3fff',
 		updatedon = now()
 where 	id = 'e02695e6-8679-4d9b-98b1-1601f39990a0';
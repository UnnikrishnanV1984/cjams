/*
   Issue Description: CDM-43699
   Category/ Module  :  Child Removal 
   Root cause: The youth's removal home information is not completely entered in the service case under the child removal tab and the case closed on 3/13/2024. Initial IV-E determination is incomplete.
   Pull request# for code fix: 
   Reason why no related code fix: raised an internal ticket for RCA: User Error.
   Status of the code fix if already submitted and expected prod fix date: 
*/


update intakeservreqchildremoval 
set primarycaregiveractorid ='974adb5b-aa34-49f6-a6d4-600886cd293f', 
	primarycaregiveradd ='Arundel House of Hope at 514 Crain Highway, Glen Burnie, Maryland 21061',
	updatedon = now(), 
    updatedby = 'CDM-43699'
where intakeservreqchildremovalid =  'e20da2e2-bf02-4d3f-922a-6f2dd367378c' and activeflag =1
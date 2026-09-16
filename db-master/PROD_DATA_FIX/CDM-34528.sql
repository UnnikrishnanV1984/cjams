/*
   Issue Description: CDM-34528
   Category/ Module  : person
   Root cause: user want to update data Person last name and AKA for intake I231011252475 , PID # 201922435
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update person set lastname ='Hiatt',updatedby ='CDM-34528',updatedon =now() 
where personid ='b65b6594-ea99-4838-bf99-c4bf108de887';


update alias set activeflag =1 , firstname='Rebekah' , lastname='Stuckey',updatedby ='CDM-34528',updatedon =now()
where aliasid ='2f9984a1-8b68-4c32-89ac-39a0ad1524ec' and personid ='b65b6594-ea99-4838-bf99-c4bf108de887';


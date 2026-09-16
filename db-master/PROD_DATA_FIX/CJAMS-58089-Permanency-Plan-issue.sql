/*
   Issue Description: CJAMS-58089
   Category/ Module  : Permanency plan   
   Root cause: User Request  
  Fix Provided: Did data fix to update the intake screenout 

  Need data fix for the following
    Case # 3218029
    Remove the Permanency plan guardianship program which is not in active status.
    Add the following details to the Permanency plan guardianship program with active status.
    Plan established 02/19/13
    Concurrent plan: custody/guardianship by relative
    Achieved/end date: 10/10/2013
    Reason for ending: Custody and guardianship to relative 
*/

update permanencyplan  set activeflag  = 0,
updatedby ='CJAMS-58089',updatedon  =now() 
where permanencyplanid  ='21d3c448-3697-4457-af63-eb23f7d92431' and activeflag=1;


update permanencyplan  
set establisheddate='2013-02-19' ,
	concurrentpermanencytype = 'GUARDR',
	achieveddate = '2013-10-10',
	--enddate = '2013-10-10',
	reason = 'Custody and guardianship to relative.',
updatedby ='CJAMS-58089',updatedon  =now() 
where permanencyplanid  ='e815269e-e11f-40f0-b04e-f01fbd0bc38b' and activeflag=1;

/*
   Issue Description: CDM-10614
   Category/ Module  :  child removal
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   back up: removaldate: 2012-07-17 00:00:00
*/
update intakeservreqchildremoval set removaldate=null,removaltime=null,exitdate=null,  updatedby='CDM-10614',updatedon=now() where personid='a1a2ecb5-9057-4525-9389-f4789e344580' and servicecaseid='2b71562b-b162-4757-931b-ff756c30b2fb'
and intakeservreqchildremovalid='4bf36934-a7b9-4430-8d24-08ee73d3134c';

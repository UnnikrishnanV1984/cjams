/* 
    Issue Description: CDM-34820
   Category/ Module  : PLacement
   Root cause: user wants to update the wrong cpahome entrydate
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    
*/


update placementcpahomes 
set 
 entrydt ='2022-11-14 14:00:00',
 entrytm ='2022-11-14 14:00:00' ,
 updatets = now(),
 updateuserid ='CDM-34820' 
where
 placementid ='c4f3e344-6c8a-4722-ad80-0575b809cfcc';
/*
Issue Description: CJAMS-62089
Root cause: User requested to remove the remove the duplicate Neglect findings through data fix for the CPS IR # 251023075247 case.
Fix provided: Data fix has been done to remove the remove the duplicate Neglect findings through data fix for the CPS IR # 251023075247 case.
Data/Code fix ticket#: CJAMS-62089
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: This is a one-off user entry error; application logic and dropdown options are functioning correctly. A data fix was sufficient to correct the reason values.
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

update
    investigationallegation
set
    activeflag = 0,
    updatedby = 'CJAMS-62089',
    updatedon = now()
where
    investigationallegationid = '9236d552-0c55-4c92-88be-bf3cc1c64d52'
    and allegationid = 'e11fc4b5-1edf-4f17-af54-b536bbf6df31';
   
update 
  investigationallegationmaltreators
set activeflag = 0,
	updatedon = now(), 
	updatedby = 'CJAMS-62089'	
where investigationallegationid = '9236d552-0c55-4c92-88be-bf3cc1c64d52'
	and activeflag = 1 ;

update
   investigationmaltreatment
set
   activeflag = 0,
   updatedby = 'CJAMS-62089',
   updatedon = now()
where maltreatmentid ='ad28da43-1d3c-4c7e-8210-38f79c75f1df' 
  and activeflag=1;
  
    
   update investigationfinding
set activeflag = 0,
	updatedon = now(), 
	updatedby = 'CJAMS-62089'	
 where investigationallegationid = '9236d552-0c55-4c92-88be-bf3cc1c64d52'
	and activeflag = 1 ;

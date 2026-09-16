/*
   Issue Description: CDM-31808
   Category/ Module  : 
   Root cause: user want to remove Claire Murphy and Sunnaye Rogers from CPS Unit 1 Workload 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    . Need to do data fix
*/ 

update teammemberassignment set activeflag=0,updatedby='CDM-31808', updatedon=now() where teammemberassignmentid='a27542b1-e901-4d51-81e6-92bc764fc7e5';
update teammember set activeflag=0,updatedby='CDM-31808', updatedon=now() where teammemberid='06b0ce08-a948-4447-b3be-d673924deb82';


update teammemberassignment set activeflag=0,updatedby='CDM-31808', updatedon=now() where teammemberassignmentid='83add595-6a92-41df-a412-366729fd0427';
update teammember set activeflag=0,updatedby='CDM-31808', updatedon=now() where teammemberid='c9be2bcb-4ee0-4a24-abda-3e2776dabd8a';
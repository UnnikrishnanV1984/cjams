/*
   Issue Description: CDM-25786
   Category/ Module  : Child Removal/Placement
   Root cause: user wants to end date program assignment 
   Pull request# for code fix: 6671
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/
update personprogramarea 
set enddate = '2022-08-01 00:00:00', updatedon = now(), updatedby = 'CDM-25786' 
where personprogramid = '1972ff5c-31c1-47cd-99b4-0624470c837f';
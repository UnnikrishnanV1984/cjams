/*
   Issue Description: CDM-17691
   Category/ Module  : delete person program
   Root cause: user wants to remove duplicate person program are
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update personprogramarea set activeflag =0 ,updatedby ='CDM-17691',updatedon =now() where personprogramid ='84cba9ec-064a-4e13-8d77-07def680a399';
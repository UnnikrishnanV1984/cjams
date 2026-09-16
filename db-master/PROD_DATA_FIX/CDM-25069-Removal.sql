/*
   Issue Description: CDM-25069
   Category/ Module  :  Child removal 
   Root cause: user requested to remove childremoval 
   Pull request# for code fix: 
   Reason why no related code fix: checked the proc changes everything is good seems to be it's a glitch
*/



update cjams.intakeservreqchildremoval set activeflag =0, updatedby ='CDM-25069', updatedon =now()

where intakeservreqchildremovalid ='01fafef2-cc19-402b-bb89-95d096494ce4';


update cjams.personprogramarea set activeflag =0, updatedby ='CDM-25069', updatedon =now()

where personprogramid ='4db3232b-e9b7-4ead-8f74-06e9edb5a568';


update cjams.routing set activeflag =0, updatedby ='CDM-25069', updatedon =now()

where objectid ='01fafef2-cc19-402b-bb89-95d096494ce4';

/*
   Issue Description: CDM-28454
   Category/ Module  : Program Assignment did not end for a removal
   Root cause:3196463:The children whose removal ended on 3/21/22 for Dilynn Simms (3811737) and Harlynn Simms (3689026) were not closed in the Program Area.
   Pull request# for code fix: It's a data fix
   Reason why no related code fix:  
   
*/



update personprogramarea set activeflag = 0, updatedby = 'CDM-28454', updatedon = now() where personprogramid in ('804c562a-9240-4771-b9b6-e10763a3bb4d', '8a9df960-9d60-4dc7-8ffe-1734f37ec236');
    /*
   Issue Description: CDM-34091
   Category/ Module  : permanencyplanl
   Root cause: As requested by user
   Fix Privided: Did data fix to remove the draft record  
*/

update cjams.permanencyplan set activeflag  =0,
updatedon = now(), updatedby ='CDM-34091'
where permanencyplanid  ='e0495ae8-4710-4f99-a68f-ce73c1e4bcf8';

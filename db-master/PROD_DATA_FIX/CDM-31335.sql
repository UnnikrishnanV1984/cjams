
    /*
  Issue Description:  CDM-31335
   Category/ Module  : maltreatment-information 
   Root cause: wrongly created
   Pull request# for code fix: 
   Reason why no related code fix: user requested 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete:
   
*/

--updating as per Alphabetical order 
update cjams.maltreatmentcharactersticstype set displayorder ='82', updatedby ='CDM-31335', updatedon = now() where maltreatmentcharactersticstypekey ='Pushing';
update cjams.maltreatmentcharactersticstype set displayorder ='83', updatedby ='CDM-31335', updatedon = now() where maltreatmentcharactersticstypekey ='PVPT';
update cjams.maltreatmentcharactersticstype set displayorder ='84' , updatedby ='CDM-31335', updatedon = now()where maltreatmentcharactersticstypekey ='PVPTN';
update cjams.maltreatmentcharactersticstype set displayorder ='85', updatedby ='CDM-31335', updatedon = now() where maltreatmentcharactersticstypekey ='PTOMAN';
update cjams.maltreatmentcharactersticstype set displayorder ='86' , updatedby ='CDM-31335', updatedon = now()where maltreatmentcharactersticstypekey ='PTOPAN';

--Removing duplicate value 
update cjams.maltreatmentcharactersticstype set activeflag =0, updatedby ='CDM-31335', updatedon = now() where maltreatmentcharactersticstypekey ='PVPTN';


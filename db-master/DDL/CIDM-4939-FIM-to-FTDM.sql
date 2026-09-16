 /*
 User story CIDM to replace the text FIM to FTDM
 */
 
 update progressnotereasontype  
 set updatedby = 'CIDM-4939', updatedon =now(), 
 progressnotereasontypekey = 'FTDM',typedescription  = 'Family Teaming Decision Meeting(FTDM)' 
 where progressnotereasontypeid  = '2123bbaf-0ff3-48af-83d0-ee3cffb2734c';

 update meetingtype set meetingtypekey ='FTDM',typedescription = 'FTDM', updatedby = 'CIDM-4939' , updatedon = now() 
 where meetingtypeid = '656f2680-fddf-4aa4-aff8-b376f2c7dc0d' ;

 update progressnote set progressnotereasontypekey ='FTDM', updatedby = 'CIDM-4939' , updatedon = now() where progressnotereasontypekey ='FIM';

update meetingrecording set meetingtypekey = 'FTDM',updatedby = 'CIDM-4939', updatedon =now() where meetingtypekey = 'FIM';
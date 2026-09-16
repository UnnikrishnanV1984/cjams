 CREATE OR REPLACE FUNCTION public.updateallegation(v_investigationallegationid uuid, v_maltreatmentid uuid)                                 
  RETURNS text                                                                                                                               
  LANGUAGE plpgsql                                                                                                                           
 AS $function$                                                                                                                             
                                                                                                                                           
 Begin                                                                                                                                     
                                                                                                                                           
             UPDATE investigationallegationinjurycharacterstics set activeflag = 0 where                                                   
             investigationallegationid = v_investigationallegationid;                                                                      
             UPDATE investigationallegationcharacterstics set activeflag = 0 where investigationallegationid = v_investigationallegationid;
                 UPDATE investigationallegationinjury set activeflag = 0 where investigationallegationid = v_investigationallegationid;    
                 UPDATE investigationallegationindicator set activeflag = 0 where investigationallegationid = v_investigationallegationid; 
                                                                                                                                           
         UPDATE maltreatmentjurisdictionuser set activeflag = 0 where maltreatmentid = v_maltreatmentid;                                   
                                                                                                                                           
                 Return 'Success';                                                                                                         
                                                                                                                                           
 End                                                                                                                                       
                                                                                                                                           
 $function$                                                                                                                                  


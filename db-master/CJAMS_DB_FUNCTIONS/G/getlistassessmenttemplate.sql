 CREATE OR REPLACE FUNCTION public.getlistassessmenttemplate(servreqtypeid character varying, servreqsubtypeid character varying, agencycode character varying, target character varying)
  RETURNS TABLE(assessmenttemplateid uuid, titleheadertext text, isrequired boolean)                                                                                                     
  LANGUAGE plpgsql                                                                                                                                                                       
 AS $function$                                                                                                                                                                           
                                                                                                                                                                                         
                                                                                                                                                                                         
  DECLARE                                                                                                                                                                                
                                                                                                                                                                                         
                                                                                                                                                                                         
 v_servreqtypeid character varying;                                                                                                                                                      
 v_servreqsubtypeid character varying;                                                                                                                                                   
 v_target character varying;                                                                                                                                                             
 v_agencycode character varying;                                                                                                                                                         
 v_targets character varying;                                                                                                                                                            
                                                                                                                                                                                         
                                                                                                                                                                                         
  BEGIN                                                                                                                                                                                  
                                                                                                                                                                                         
                                                                                                                                                                                         
  v_servreqtypeid := servreqtypeid ;                                                                                                                                                     
  v_servreqsubtypeid := servreqsubtypeid ;                                                                                                                                               
  v_targets := target;                                                                                                                                                                   
  v_agencycode:=agencycode;                                                                                                                                                              
                                                                                                                                                                                         
  if (coalesce(servreqtypeid,'')='') then                                                                                                                                                
                                                                                                                                                                                         
         v_servreqtypeid := '00000000-0000-0000-0000-000000000000';                                                                                                                      
  end if;                                                                                                                                                                                
                                                                                                                                                                                         
   if (coalesce(servreqsubtypeid ,'')='' or                                                                                                                                              
       coalesce(servreqtypeid,'')= coalesce(servreqsubtypeid ,'')) then                                                                                                                  
          v_servreqsubtypeid := '00000000-0000-0000-0000-000000000000';                                                                                                                  
                                                                                                                                                                                         
  end if;                                                                                                                                                                                
                                                                                                                                                                                         
  ------Fetiching Assessment Template name ,IsRequired for Sub Category -------                                                                                                          
                                                                                                                                                                                         
            RETURN QUERY                                                                                                                                                                 
                                                                                                                                                                                         
                                                                                                                                                                                         
   select   AST.assessmenttemplateid , AST.titleheadertext,ast.isrequired                                                                                                                
                                                                                                                                                                                         
                 from assessmenttemplate AST                                                                                                                                             
                 inner join assessmenttemplatecategoryfiltermap ATCM                                                                                                                     
                 On AST.assessmenttemplateid  = ATCM.assessmenttemplateid                                                                                                                
                 and ATCM.activeflag =1                                                                                                                                                  
                 inner join assessmenttemplatetarget ATT                                                                                                                                 
 on ATCM.assessmenttemplatetargetid  = ATT.assessmenttemplatetargetid                                                                                                                    
         where  ATCM.intakeservicerequesttypeid = v_servreqtypeid::uuid                                                                                                                  
         and ATCM.intakeservicerequestsubtypeid= v_servreqsubtypeid::uuid                                                                                                                
         and ATCM.teamtypekey = v_agencycode                                                                                                                                             
         and lower(ATT.target) = lower(v_targets)                                                                                                                                        
         and AST.activeflag = 1  ;                                                                                                                                                       
                                                                                                                                                                                         
  end;                                                                                                                                                                                   
                                                                                                                                                                                         
 $function$                                                                                                                                                                              


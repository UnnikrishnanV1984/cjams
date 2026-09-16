 CREATE OR REPLACE FUNCTION public.getintaketaskclosed(intakserviceid uuid)                                                 
  RETURNS TABLE(activitytaskname character varying, status character varying)                                               
  LANGUAGE plpgsql                                                                                                          
 AS $function$                                                                                                              
                                                                                                                            
 BEGIN                                                                                                                      
          RETURN QUERY                                                                                                      
        select att."name" as activitytaskname,ATST.typedescription as status from investigation IVS                         
  join activity ACT on IVS.investigationid=ACT.objectid and Lower(ACT.activitytypekey)='investigation' and  ACT.activeflag=1
  join ammapping AMM on AMM.ammappingid=ACT.ammappingid and  AMM.activeflag=1                                               
  --join amactivity AMA                                                                                                     
  join ammappingtask AMMT on AMMT.ammappingid=ACT.ammappingid and AMMT.activeflag=1                                         
  join activitytask ATT on ATT.amtaskid=AMMT.amtaskid and ATT.activityid=ACT.activityid and  ATT.activeflag=1               
  join activitytaskstatustype ATST on ATST.activitytaskstatustypekey =ATT.activitytaskstatustypekey and ATST.activeflag=1   
  where intakeserviceid=IntakserviceId and AMMT.activeflag=1;                                                               
                                                                                                                            
                                                                                                                            
                                                                                                                            
 end                                                                                                                        
                                                                                                                            
 $function$                                                                                                                 


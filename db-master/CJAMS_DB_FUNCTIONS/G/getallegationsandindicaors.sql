 CREATE OR REPLACE FUNCTION public.getallegationsandindicaors(p_intakeservicereqtypeid uuid)                                                                        
  RETURNS TABLE(allegationname character varying, allegationid uuid, indicatorid uuid, allegationindicatorname character varying, datype character varying)         
  LANGUAGE plpgsql                                                                                                                                                  
 AS $function$                                                                                                                                                      
 BEGIN                                                                                                                                                              
                                                                                                                                                                    
 RETURN QUERY                                                                                                                                                       
 select a.name as allegagtionname, a.allegationid, i.indicatorid, i.indicatorname as allegationindicatorname, isrt.intakeservreqtypekey as datype from allegation a 
 JOin indicator i on i.allegationid=a.allegationid                                                                                                                  
 Join intakeservicerequesttype isrt on isrt.intakeservreqtypeid= a.intakeservicereqtypeid where isrt.intakeservreqtypeid=p_intakeservicereqtypeid                   
 order by a.name, i.indicatorname;                                                                                                                                  
                                                                                                                                                                    
 END;                                                                                                                                                               
 $function$                                                                                                                                                         


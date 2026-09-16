 CREATE OR REPLACE FUNCTION public.getservicerequestsubtype(p_intakeservreqtypeid uuid, p_intakeservid uuid)                     
  RETURNS TABLE(servicerequestsubtypeid uuid, description character varying, classkey character varying)                         
  LANGUAGE plpgsql                                                                                                               
 AS $function$                                                                                                                   
                                                                                                                                 
                                                                                                                                 
 BEGIN                                                                                                                           
                                                                                                                                 
                                                                                                                                 
         Return  Query                                                                                                           
                                                                                                                                 
 select SST.servicerequestsubtypeid,SST.description,SST.classkey                                                                 
 from intakeagencyserv  IAS                                                                                                      
 inner join servicerequesttypeconfig SRTC on IAS.servicerequesttypeconfigid=SRTC.servicerequesttypeconfigid and SRTC.activeflag=1
 --inner join intakeserv ITS on ITS.intakeservid =IAS.intakeservid and its.activeflag=1                                          
 inner join servicerequestsubtype  SST on SST.servicerequestsubtypeid=SRTC.servicerequestsubtypeid                               
 where SRTC.intakeservreqtypeid =p_intakeservreqtypeid and IAS.intakeservid=p_intakeservid and IAS.activeflag=1 ;                
                                                                                                                                 
 end;                                                                                                                            
                                                                                                                                 
 $function$                                                                                                                      


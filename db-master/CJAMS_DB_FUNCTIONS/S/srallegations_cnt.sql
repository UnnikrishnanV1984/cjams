 CREATE OR REPLACE FUNCTION public.srallegations_cnt(_servicerequestnumber character varying)        
  RETURNS SETOF bigint                                                                               
  LANGUAGE plpgsql                                                                                   
 AS $function$                                                                                       
 DECLARE                                                                                             
                                                                                                     
 BEGIN                                                                                               
                                                                                                     
 RETURN QUERY                                                                                        
 select Count(*) as cnt from                                                                         
 (SELECT ISR.ServiceRequestNumber, INVA.Name, INVA.Financial,INVA.Indicators, INVA.Reported,         
                 INV.EDL, INV.ReviewDate, INV.CompletionDate, INV.RiskScore, inv.InvestigationSummary
 FROM InvestigationAllegation INVA                                                                   
      JOIN Investigation INV   ON INV.InvestigationId  = INVA.InvestigationId and INV.ActiveFlag = 1 
      JOIN IntakeServiceRequest ISR ON INV.IntakeServiceId  = ISR.IntakeServiceId                    
 WHERE    ISR.ServiceRequestNumber = _servicerequestnumber and INVA.ActiveFlag = 1) as A;            
                                                                                                     
 END;                                                                                                
 $function$                                                                                          


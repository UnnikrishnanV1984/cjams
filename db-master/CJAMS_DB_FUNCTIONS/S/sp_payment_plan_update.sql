 CREATE OR REPLACE FUNCTION public.sp_payment_plan_update(al_receivable_id bigint, as_transaction_type character varying, adc_transaction_amt numeric, OUT al_sqlcode integer)
  RETURNS integer                                                                                                                                                             
  LANGUAGE plpgsql                                                                                                                                                            
 AS $function$                                                                                                                                                                
 ------------------------------------------------------------------------                                                                                                     
 -- SQL Stored Procedure                                                                                                                                                      
 -- Author: Vineet Tirodkar                                                                                                                                                   
 -- Date Created :12/19/2008                                                                                                                                                  
 -- Arguments: 1) Receivable ID                                                                                                                                               
 --            2) Transaction Type -                                                                                                                                          
 --               Receipt Entry - REC                                                                                                                                         
 --               Receipt Reversal Entry Approval - RER                                                                                                                       
 --               Off Entry - OFF                                                                                                                                             
 --               Receivable Write Off Approval - WOA                                                                                                                         
 --               Calling from SP_PAYMENT_PLAN_INSERT - PPI                                                                                                                   
 --            3) Transaction Amount                                                                                                                                          
 --               Case REC, OFF, WOA adc_transaction_amt as (+ve) to add subtract from Plan                                                                                   
 --               Case RER pass adc_transaction_amt as (-ve) to add in Plan                                                                                                   
 --               Case PPI pass Current Total Receivable balance to update the Plan                                                                                           
 --            4) SQLCODE as OUT                                                                                                                                              
 -- After every transaction like Receipt, Receipt Reversal, Off and Receivable Write Off                                                                                      
 -- update payment plan to reflect updated Receivable amount and payment plan amount.                                                                                         
 -- 09/01/2015 - Vineet Tirodkar - PRJ-05327 - MD CHESSIE Fiscal Phases 2                                                                                                     
 --                              Changes to update payment plan as 'Recovery' - 100% for GAP & Adoption Subsidy account receivables.                                          
 ------------------------------------------------------------------------                                                                                                     
 DECLARE                                                                                                                                                                      
 SQLCODE BIGINT DEFAULT 0;--                                                                                                                                                  
                                                                                                                                                                              
 vl_payment_plan_id BIGINT DEFAULT 0;--                                                                                                                                       
 vl_new_payment_plan_id BIGINT DEFAULT 0;--                                                                                                                                   
 vl_months_no INT DEFAULT 0;--                                                                                                                                                
                                                                                                                                                                              
  vdc_amount_no Decimal(10,2) DEFAULT 0.00;--                                                                                                                                 
  vdc_percent_no Decimal(5,2) DEFAULT 0.00;--                                                                                                                                 
  vdc_recv_bal_exl_sub decimal(10,2);--                                                                                                                                       
  vdc_recv_bal_sub decimal(10,2);--                                                                                                                                           
  vdc_receivable_bal Decimal(10,2) DEFAULT 0.00;--                                                                                                                            
  vdc_new_receivable_bal Decimal(10,2) DEFAULT 0.00;--                                                                                                                        
  vdc_new_amount Decimal(10,2) DEFAULT 0.00;--                                                                                                                                
  vdc_new_percent_no Decimal(5,2) DEFAULT 0.00;--                                                                                                                             
  vdc_new_payment_percentage decimal(5,2) DEFAULT 0.00;--                                                                                                                     
                                                                                                                                                                              
  vs_provider_cat VARCHAR(5);--                                                                                                                                               
  vs_off_sw CHAR(1);--                                                                                                                                                        
  vs_payment_option_sw CHAR(1);--                                                                                                                                             
  vs_off_option_sw CHAR(1);--                                                                                                                                                 
  vs_payment_plan_id VARCHAR(50) DEFAULT 'sq_payment_plan';--                                                                                                                 
                                                                                                                                                                              
  vs_new_off_sw CHAR(1);--                                                                                                                                                    
  vs_new_off_option CHAR(1);--                                                                                                                                                
  vs_new_payment_option CHAR(1);--                                                                                                                                            
                                                                                                                                                                              
  vd_old_plan_start_dt   DATE;--                                                                                                                                              
  vd_old_plan_end_dt     DATE;   --                                                                                                                                           
                                                                                                                                                                              
 BEGIN                                                                                                                                                                        
                                                                                                                                                                              
 SELECT PAYMENT_PLAN_ID,                                                                                                                                                      
        AMOUNT_NO,                                                                                                                                                            
        PERCENTAGE_NO,                                                                                                                                                        
        MONTHS_NO,                                                                                                                                                            
        offset_sw,                                                                                                                                                            
        PAYMENT_OPTION_SW,                                                                                                                                                    
        OFFSET_OPTION_SW,                                                                                                                                                     
        CURRENT_RECEIVABLE_AMOUNT,                                                                                                                                            
            START_DT                                                                                                                                                          
   INTO vl_payment_plan_id,                                                                                                                                                   
        vdc_amount_no,                                                                                                                                                        
        vdc_percent_no,                                                                                                                                                       
        vl_months_no,                                                                                                                                                         
        vs_off_sw,                                                                                                                                                            
        vs_payment_option_sw,                                                                                                                                                 
        vs_off_option_sw,                                                                                                                                                     
        vdc_receivable_bal,                                                                                                                                                   
            vd_old_plan_start_dt                                                                                                                                              
 FROM public.tb_PAYMENT_PLAN                                                                                                                                                  
 WHERE RECEIVABLE_ID = al_receivable_id                                                                                                                                       
       AND DELETE_SW = 'N'                                                                                                                                                    
       AND START_DT is NOT NULL                                                                                                                                               
       AND END_DT is NULL                                                                                                                                                     
 ORDER BY PAYMENT_PLAN_ID DESC                                                                                                                                                
 FETCH FIRST ROW ONLY ;  --                                                                                                                                                   
                                                                                                                                                                              
 IF vl_payment_plan_id > 0 THEN                                                                                                                                               
    IF vs_off_sw is NULL THEN                                                                                                                                                 
        vs_off_sw = 'N' ;        --                                                                                                                                           
    END IF;--                                                                                                                                                                 
                                                                                                                                                                              
    --  New CURRENT_RECEIVABLE_AMOUNT                                                                                                                                         
    IF as_transaction_type = 'PPI' THEN                                                                                                                                       
        vdc_new_receivable_bal = adc_transaction_amt;    --                                                                                                                   
    ELSE                                                                                                                                                                      
        vdc_new_receivable_bal = vdc_receivable_bal - adc_transaction_amt;       --                                                                                           
    END IF;--                                                                                                                                                                 
                                                                                                                                                                              
    IF vs_off_sw = 'Y' THEN --  Plan OFF                                                                                                                                      
        vdc_new_amount = ROUND(( vdc_new_receivable_bal * vdc_percent_no ) / 100, 2) ;--                                                                                      
        vdc_new_percent_no = vdc_percent_no ; -- Original % of plan                                                                                                           
    ELSE --  Plan RECOVERY                                                                                                                                                    
       IF vs_payment_option_sw = 'A' THEN -- Percentage                                                                                                                       
           vdc_new_amount = ROUND(( vdc_new_receivable_bal * vdc_percent_no ) / 100, 2) ;--                                                                                   
           vdc_new_percent_no = vdc_percent_no ; -- Original % of plan                                                                                                        
       ELSEIF vs_payment_option_sw = 'B' THEN -- Monthly Amount                                                                                                               
          IF vdc_new_receivable_bal >= vdc_amount_no AND vdc_amount_no > 0 THEN                                                                                               
              vdc_new_amount = vdc_amount_no ; -- Original Amount of plan                                                                                                     
          ELSE                                                                                                                                                                
              vdc_new_amount = vdc_new_receivable_bal;--                                                                                                                      
          END IF;--                                                                                                                                                           
          IF vdc_new_receivable_bal > 0 THEN                                                                                                                                  
              vdc_new_percent_no = ROUND(( vdc_new_amount * 100 )/ vdc_new_receivable_bal, 2) ;--                                                                             
          ELSE                                                                                                                                                                
              vdc_new_percent_no = vdc_percent_no ; -- Original % of plan                                                                                                     
          END IF;--                                                                                                                                                           
       ELSEIF vs_payment_option_sw = 'C' THEN -- Number of Months                                                                                                             
           vdc_new_amount = ROUND(( vdc_new_receivable_bal * vdc_percent_no ) / 100, 2) ;--                                                                                   
           vdc_new_percent_no = vdc_percent_no ; -- Original % of plan                                                                                                        
       END IF;--                                                                                                                                                              
    END IF;--                                                                                                                                                                 
                                                                                                                                                                              
    UPDATE public.tb_PAYMENT_PLAN set                                                                                                                                         
       AMOUNT_NO = vdc_new_amount,                                                                                                                                            
          PERCENTAGE_NO = vdc_new_percent_no,                                                                                                                                 
          CURRENT_RECEIVABLE_AMOUNT = vdc_new_receivable_bal,                                                                                                                 
          UPDATE_TS = CURRENT_TIMESTAMP,                                                                                                                                      
          UPDATE_USER_ID = 'finance'                                                                                                                                          
    WHERE PAYMENT_PLAN_ID = vl_payment_plan_id                                                                                                                                
          AND DELETE_SW = 'N' ;--                                                                                                                                             
                                                                                                                                                                              
     al_sqlcode = SQLCODE;--                                                                                                                                                  
                                                                                                                                                                              
         -- PRJ-05327 - Update Payment Plan when Foster Care Receivables are PIF and remaining balance is only for Subsidies - START                                          
         IF as_transaction_type <> 'PPI' THEN -- called from SP_PAYMENT_PLAN_INSERT & the SP is having this logic                                                             
                 -- Get Provider Category                                                                                                                                     
                 SELECT F_PRVPCKLST_CAT(RH.PROVIDER_ID,'PLACEMENT') AS PROV_CAT                                                                                               
                         INTO vs_provider_cat                                                                                                                                 
                 FROM public.tb_RECEIVABLE_HEADER RH                                                                                                                          
                 WHERE RH.DELETE_SW =  'N'                                                                                                                                    
                         AND RH.RECEIVABLE_ID = al_receivable_id ;--                                                                                                          
                                                                                                                                                                              
                 IF vs_provider_cat = '1783' or vs_provider_cat = '1785' THEN -- chessie_mask Providers                                                                       
                         -- Identify Receivable balance for Foster Care Payments - START                                                                                      
                         SELECT SUM(RD.RECEIVABLE_BALANCE_NO)                                                                                                                 
                                         INTO vdc_recv_bal_exl_sub                                                                                                            
                                 FROM public.tb_RECEIVABLE_DETAIL RD,                                                                                                         
                                         public.tb_RECEIVABLE_COLLECTION_STATUS RCS,                                                                                          
                                         public.tb_PAYMENT_DETAIL PD                                                                                                          
                         WHERE RCS.RECEIVABLE_DETAIL_ID = RD.RECEIVABLE_DETAIL_ID                                                                                             
                                 AND RD.PAYMENT_DETAIL_ID = PD.PAYMENT_DETAIL_ID                                                                                              
                                 AND RD.RECEIVABLE_ID = al_receivable_id                                                                                                      
                                 AND RD.RECEIVABLE_STATUS_CD IN ('19','22')                                                                                                   
                                 AND ((RD.MANUAL_SW = 'N') OR (RD.MANUAL_SW = 'Y' AND RD.APPROVAL_STATUS_CD = '3047'))                                                        
                                 AND RD.DELETE_SW = 'N'                                                                                                                       
                                 AND RCS.DELETE_SW = 'N'                                                                                                                      
                                 AND PD.DELETE_SW = 'N'                                                                                                                       
                                 AND RCS.ACTIVE_SW = 'Y'                                                                                                                      
                                 AND RCS.COLLECTION_STATUS_CD <> '775'                                                                                                        
                                 AND PD.SUBSIDY_AGREEMENT_ID IS NULL  ; -- A/R excluding GAP & Adoption Subsidy payments                                                      
                                                                                                                                                                              
                         IF vdc_recv_bal_exl_sub is NULL THEN                                                                                                                 
                                  vdc_recv_bal_exl_sub = 0;--                                                                                                                 
                         END IF;         --                                                                                                                                   
                         -- Identify Receivable balance for Foster Care Payments - END                                                                                        
                                                                                                                                                                              
                         -- Identify Receivable balance for GAP & Adoption Subsidy payments - START                                                                           
                         SELECT SUM(RD.RECEIVABLE_BALANCE_NO)                                                                                                                 
                                         INTO vdc_recv_bal_sub                                                                                                                
                                 FROM public.tb_RECEIVABLE_DETAIL RD,                                                                                                         
                                         public.tb_RECEIVABLE_COLLECTION_STATUS RCS,                                                                                          
                                         public.tb_PAYMENT_DETAIL PD                                                                                                          
                         WHERE RCS.RECEIVABLE_DETAIL_ID = RD.RECEIVABLE_DETAIL_ID                                                                                             
                                 AND RD.PAYMENT_DETAIL_ID = PD.PAYMENT_DETAIL_ID                                                                                              
                                 AND RD.RECEIVABLE_ID = al_receivable_id                                                                                                      
                                 AND RD.RECEIVABLE_STATUS_CD IN ('19','22')                                                                                                   
                                 AND ((RD.MANUAL_SW = 'N') OR (RD.MANUAL_SW = 'Y' AND RD.APPROVAL_STATUS_CD = '3047'))                                                        
                                 AND RD.DELETE_SW = 'N'                                                                                                                       
                                 AND RCS.DELETE_SW = 'N'                                                                                                                      
                                 AND PD.DELETE_SW = 'N'                                                                                                                       
                                 AND RCS.ACTIVE_SW = 'Y'                                                                                                                      
                                 AND RCS.COLLECTION_STATUS_CD <> '775'                                                                                                        
                                 AND PD.SUBSIDY_AGREEMENT_ID IS NOT NULL ; -- A/R for GAP & Adoption Subsidy payments only                                                    
                                                                                                                                                                              
                         IF vdc_recv_bal_sub is NULL THEN                                                                                                                     
                                  vdc_recv_bal_sub = 0;--                                                                                                                     
                         END IF;         --                                                                                                                                   
                         -- Identify Receivable balance for GAP & Adoption Subsidy payments - END                                                                             
                                                                                                                                                                              
                         IF vdc_recv_bal_exl_sub = 0 AND vdc_recv_bal_sub > 0 THEN                                                                                            
                                 -- Update Existing Payment Plan                                                                                                              
                                 IF vd_old_plan_start_dt is NOT NULL AND vd_old_plan_start_dt = CURRENT DATE THEN                                                             
                                          vd_old_plan_end_dt = CURRENT DATE;--                                                                                                
                                 ELSE                                                                                                                                         
                                          vd_old_plan_end_dt = CURRENT_DATE - 1 ;--                                                                                           
                                 END IF;--                                                                                                                                    
                                                                                                                                                                              
                                 UPDATE public.tb_PAYMENT_PLAN set                                                                                                            
                                  END_DT = vd_old_plan_end_dt,                                                                                                                
                                         UPDATE_TS = CURRENT_TIMESTAMP,                                                                                                       
                                         UPDATE_USER_ID = 'finance'                                                                                                           
                                 WHERE PAYMENT_PLAN_ID = vl_payment_plan_id                                                                                                   
                                         AND DELETE_SW = 'N' ;--                                                                                                              
                                                                                                                                                                              
                                                                                                                                                                              
                                 -- Create New Payment Plan with 100% Recovery                                                                                                
                                  vs_new_off_sw = NULL;--                                                                                                                     
                                  vs_new_off_option = NULL;--                                                                                                                 
                                  vdc_new_payment_percentage = 100.00;--                                                                                                      
                                  vs_new_payment_option = 'A';--                                                                                                              
                                                                                                                                                                              
                                 --SELECT  sp_nextid (vs_payment_plan_id, vl_new_payment_plan_id);--                                                                          
                                 SELECT public.SP_nextid(vs_payment_plan_id::character varying) into vl_new_payment_plan_id;                                                  
                                                                                                                                                                              
                                 INSERT INTO public.tb_PAYMENT_PLAN (                                                                                                         
                                         PAYMENT_PLAN_ID, PLAN_DT, RECEIVABLE_ID, AMOUNT_NO,                                                                                  
                                         PERCENTAGE_NO, MONTHS_NO, START_DT, END_DT,                                                                                          
                                         OFFSET_SW, PAYMENT_OPTION_SW, OFFSET_OPTION_SW, MANUAL_SW,                                                                           
                                         CREATE_TS, CREATE_USER_ID, UPDATE_TS, UPDATE_USER_ID, DELETE_SW,                                                                     
                                         CURRENT_RECEIVABLE_AMOUNT )                                                                                                          
                                 VALUES (                                                                                                                                     
                                         vl_new_payment_plan_id, CURRENT_DATE, al_receivable_id, vdc_recv_bal_sub,                                                            
                                         vdc_new_payment_percentage,     NULL, CURRENT_DATE, NULL,                                                                            
                                         vs_new_off_sw, vs_new_payment_option, vs_new_off_option, 'N',                                                                        
                                         CURRENT_TIMESTAMP, 'finance', CURRENT_TIMESTAMP, 'finance', 'N',                                                                     
                                         vdc_recv_bal_sub );--                                                                                                                
                                                                                                                                                                              
                         END IF;--                                                                                                                                            
                 END IF;--                                                                                                                                                    
         END IF; --                                                                                                                                                           
         -- PRJ-05327 - Update Payment Plan when Foster Care Receivables are PIF and remaining balance is only for Subsidies - END                                            
                                                                                                                                                                              
  --todo:   COMMIT;--                                                                                                                                                         
 END IF;--                                                                                                                                                                    
                                                                                                                                                                              
                                                                                                                                                                              
 END                                                                                                                                                                          
 ;                                                                                                                                                                            
                                                                                           $function$                                                                         


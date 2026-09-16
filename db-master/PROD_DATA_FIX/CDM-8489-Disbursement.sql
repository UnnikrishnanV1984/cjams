 /*  Issue Description: CDM-8489 -- other distribution client 1459143
   Category/ Module  :  Child account disbursement
   Root cause: User exit and re-routing to another user as user requested
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update routing set tosecurityusersid='80ae9162-45de-48a1-9110-62e6036e5035',updatedby='CDM-8489',updatedon=now() where objectid=1005945 and eventcode='FINALDIS' and routingid='1268d57c-6faf-464f-93d4-477d62f5151f' and routingstatustypeid=57
and activeflag=1;

update tb_child_account_disbursement set adr_street_no=null,payee_nm='Marshall Ruff (C/O KASSANDRA GRIFFITH)',update_user_id='CDM-8489',update_ts=now()  where disbursement_id=1005945
and client_account_id=13464;
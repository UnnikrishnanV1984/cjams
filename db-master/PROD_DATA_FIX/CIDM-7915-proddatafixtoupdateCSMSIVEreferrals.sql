/*
   Issue Description: CIDM-7915
   Category/ Module  : Prod data fix to update IVE Referrals Data
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


--785-85-8382
update person set ssnno = '785858382', updatedby = 'CIDM-7915', updatedon = now()
where cjamspid ='200022605' and activeflag = 1;


update ivecsesoutbounddata  set csmsreferralid = '768927',outputjson = '{
    "messageCode": "4000",
    "message": "Successfully Created Referral",
    "referralId": "768927"
}',updatedon = now() where clientid in ('200022605') and activeflag = 1;


update ivecsesoutbounddata  set csmsreferralid = '761028' where clientid in ('201198104') and activeflag = 1;

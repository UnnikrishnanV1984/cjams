/* 
    Issue Description: CDM-38080
   Category/ Module  : Timer Still Counting
   Root cause:To modify the answer for the below question in the person card for Client ID # 202832646 (Aamari Holt)
      "Was this child an active member of the household at the start of the case but not included on the referral?*" - From No to Yes
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    void the rejected provider placement from backend
*/

select initialresponse, * 
    from personrole 
    where intakeserviceid = '41b410ea-14fe-48bd-96fe-cfb74e271025' 
        and personid = '5a24eee2-b748-4399-ba3e-7f5b935d1380';

update personrole 
    set initialresponse = 1,
        updatedby='CDM-38080',
        updatedon=now() 
    where personroleid='436fd869-456e-46ec-9a5d-04dcca3839ea';
    
-- To Stop the timer
-- Before 
select responsetimer, responsetimerdetails, updatedby, updatedon 
    from intakeservicerequest 
where servicerequestnumber = '241021927526'
    and activeflag = 1 ;
    
select * 
from cjams.cpsresponsetimerupdate( '41b410ea-14fe-48bd-96fe-cfb74e271025'::uuid, 'CDM-38080'::character varying ) ;


-- After 
select responsetimer, responsetimerdetails, updatedby, updatedon 
    from intakeservicerequest 
where servicerequestnumber = '241021927526'
    and activeflag = 1 ;
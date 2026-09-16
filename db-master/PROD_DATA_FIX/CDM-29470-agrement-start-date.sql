/*
 Issue Description:CDM-29470
 Category/ Module:nable to edit agreement start date for Sidney Fowlkes-2511705 which is preventing subsidy payments from generating.
 Root cause: update
 Pull request# N/A
 Reason why no related code fix: N/A
 Status of the code fix if already submitted and expected prod fix date: N/A
 */

select gapagreementid, startdate, enddate, paymentamout, updatedby, updatedon, activeflag 
	from gapagreementrate 
where gapagreementrateid = 'b6550861-8a86-4dc5-8f75-eaa84fcd3150'
	and activeflag = 1;

update gapagreementrate 
set startdate = '2019-01-30 15:00:00',
    updatedon=now(), updatedby='CDM-29470'
where gapagreementrateid = 'b6550861-8a86-4dc5-8f75-eaa84fcd3150'
and activeflag = 1;

update gapagreementrate
set updatedon=now(), 
    updatedby='CDM-29470'
where gapagreementrateid 
in (
'0c1f3b4c-f497-4228-b43c-8218f57d0868',
'f996f3f0-ce2f-4f41-978b-8999693bf07a',
'09a98019-997b-4425-b732-dee989c0c821',
'93cd7706-95f8-4178-acbe-f7025e053bf3',
'0ee9a3cf-c003-42ab-8d3a-8b44671c41a0'
);


select approvalstatustypekey, approvaldate, ratestartdate, rateenddate, paymentamt, activeflag, updatedby, updatedon 
from gapratesrevision 
where gaprateid = 'b6550861-8a86-4dc5-8f75-eaa84fcd3150' and activeflag = 1 ;


update gapratesrevision 
set ratestartdate = '2019-01-30 15:00:00',
approvaldate = now(),
updatedon=now(), updatedby='CDM-29470'	
where gaprateid = 'b6550861-8a86-4dc5-8f75-eaa84fcd3150' and activeflag = 1 ;

update gapratesrevision 
set approvaldate = now(),
    updatedon=now(), 
    updatedby='CDM-29470'
where activeflag = 1 
and gaprateid in (
'0c1f3b4c-f497-4228-b43c-8218f57d0868',
'f996f3f0-ce2f-4f41-978b-8999693bf07a',
'09a98019-997b-4425-b732-dee989c0c821',
'93cd7706-95f8-4178-acbe-f7025e053bf3',
'0ee9a3cf-c003-42ab-8d3a-8b44671c41a0'
)
and approvaldate is not null;

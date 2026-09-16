/*
Issue: CJAMS-66584
Category/Module: GAP
Root cause: End date is displayed for as rejected record
Fix provided: Data fix has been done by deleting the rejected record and trigger the gap rates
Data/Code fix ticket#: CJAMS-66584
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
*/


update gapsuspension
set activeflag = 0,
    updatedby = 'CJAMS-66584', 
    updatedon = now() 
where gapsuspensionid = '043c89dd-6c76-4a77-8fe7-2ff2cd0ef577'
    and activeflag = 1 ;

   
update gapsuspensionrevision
set activeflag = 0,
    updatedby = 'CJAMS-66584', 
    updatedon = now() 
where suspensionid = '043c89dd-6c76-4a77-8fe7-2ff2cd0ef577' and gapsuspensionrevisionid='b26f8cec-21da-4c76-958b-caab19bb7837'
    and activeflag = 1 ;

   
update routing
set activeflag = 0,
    updatedby = 'CJAMS-66584', 
    updatedon = now() 
where objectid = '043c89dd-6c76-4a77-8fe7-2ff2cd0ef577'
	and routingid='01a77d36-7c77-478b-8f59-6e6b1165c533'
    and eventcode = 'GASR'
    and activeflag = 1 ;


update gapagreementrevision
set approvaldate=now(), updatedby='CJAMS-66584', updatedon =now()
where gapid = '7ac5422c-085e-47c0-942a-25e5ed124d8c' and activeflag = 1;
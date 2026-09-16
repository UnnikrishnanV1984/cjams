/*
   Issue Description: CDM-19525
   Category/ Module  : Data fix for GAP Agreement Provider Info
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update permanencyplan set activeflag = 0, updatedby = 'CDM-19525', updatedon = now() where permanencyplanid = 'f90136e3-5ce1-488c-91c0-74228c52a840';
update guardianship set activeflag = 0, updatedby = 'CDM-19525', updatedon = now() WHERE permanencyplanid = 'f90136e3-5ce1-488c-91c0-74228c52a840';
update gapagreement set activeflag = 0, updatedby = 'CDM-19525', updatedon = now() where gapagreementid = '82b01a8d-b3e9-456b-bb0c-c74ea290a63a';
update gapagreementrate set activeflag= 0, updatedby = 'CDM-19525', updatedon = now() where gapagreementrateid = '29cb698c-4047-4ad1-a38e-d0126bd3a569';
update gapratesrevision set activeflag = 0,approvaldate = now(), updatedby = 'CDM-19525', updatedon = now() where gaprateid = '29cb698c-4047-4ad1-a38e-d0126bd3a569';


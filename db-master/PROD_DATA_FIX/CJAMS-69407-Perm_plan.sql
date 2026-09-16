/*
-- Issue Description: 
    Case#: 2110300008935, CJAMS PID: 200776134  Abias Crosell, CJAMS PID: 200776133 Ava Crosell
    Please carry out data fix to remove the marked Permanency Plan records.  
    Note: The ones that DO NOT have "active GAP" next to them - need to be deleted


-- Category/ Module: Accounts Payable (Finance Management)
-- Root cause: Data issue, Inactive actor id in the permanencyplan table. (Exception scenario)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/


update permanencyplan
set updatedon = now(), updatedby='CJAMS-69407', activeflag = 0
where permanencyplanid='7d2fdacb-b971-4198-addf-337e802c4095' and activeflag = 1;

update permanencyplan_history
set updatedon = now(), updatedby='CJAMS-69407', activeflag = 0
where permanencyplanid='7d2fdacb-b971-4198-addf-337e802c4095' and activeflag = 1;

update routing
set updatedon = now(), updatedby='CJAMS-69407', activeflag = 0
where objectid='7d2fdacb-b971-4198-addf-337e802c4095' and eventcode= 'PPLR' and activeflag = 1;

---------

update permanencyplan
set updatedon = now(), updatedby='CJAMS-69407', activeflag = 0
where permanencyplanid='664c929a-6159-41f3-ac71-c3f6d52a65eb' and activeflag = 1;

update permanencyplan_history
set updatedon = now(), updatedby='CJAMS-69407', activeflag = 0
where permanencyplanid='664c929a-6159-41f3-ac71-c3f6d52a65eb' and activeflag = 1;

update routing
set updatedon = now(), updatedby='CJAMS-69407', activeflag = 0
where objectid='664c929a-6159-41f3-ac71-c3f6d52a65eb'  and activeflag = 1;

update guardianship
set updatedon = now(), updatedby='CJAMS-69407', activeflag = 0
where permanencyplanid='664c929a-6159-41f3-ac71-c3f6d52a65eb' and activeflag = 1;

update gapagreement
set updatedon = now(), updatedby='CJAMS-69407', activeflag = 0
where gapid='a5ba3d17-deed-431b-b56e-7e8f1765d464' and activeflag = 1;

update routing
set updatedon = now(), updatedby='CJAMS-69407', activeflag = 0
where  objectid='6f587377-b24b-41ec-a62f-0b22df2987cb' and activeflag = 1;

-------------------------------------
--Abias Crosell

update permanencyplan
set updatedon = now(), updatedby='CJAMS-69407', activeflag = 0
where permanencyplanid='e9d192b9-a7c1-47c1-8201-dee99f68e4c5' and activeflag = 1;

update permanencyplan_history
set updatedon = now(), updatedby='CJAMS-69407', activeflag = 0
where permanencyplanid='e9d192b9-a7c1-47c1-8201-dee99f68e4c5' and activeflag = 1;

update routing
set updatedon = now(), updatedby='CJAMS-69407', activeflag = 0
where objectid='e9d192b9-a7c1-47c1-8201-dee99f68e4c5' and eventcode= 'PPLR' and activeflag = 1;

--------------------------

update permanencyplan
set updatedon = now(), updatedby='CJAMS-69407', activeflag = 0
where permanencyplanid='8ad7ab0f-4e0a-45a9-a105-d06f6812afae' and activeflag = 1;

update permanencyplan_history
set updatedon = now(), updatedby='CJAMS-69407', activeflag = 0
where permanencyplanid='8ad7ab0f-4e0a-45a9-a105-d06f6812afae' and activeflag = 1;

update routing
set updatedon = now(), updatedby='CJAMS-69407', activeflag = 0
where objectid='8ad7ab0f-4e0a-45a9-a105-d06f6812afae'  and activeflag = 1;

-----------------------------------------------------------------

update permanencyplan
set updatedon = now(), updatedby='CJAMS-69407', activeflag = 0
where permanencyplanid='f7651085-cf10-429e-93f9-5cdd26cf4399' and activeflag = 1;

update permanencyplan_history
set updatedon = now(), updatedby='CJAMS-69407', activeflag = 0
where permanencyplanid='f7651085-cf10-429e-93f9-5cdd26cf4399' and activeflag = 1;

update routing
set updatedon = now(), updatedby='CJAMS-69407', activeflag = 0
where objectid='f7651085-cf10-429e-93f9-5cdd26cf4399'  and activeflag = 1;

update guardianship
set updatedon = now(), updatedby='CJAMS-69407', activeflag = 0
where permanencyplanid='f7651085-cf10-429e-93f9-5cdd26cf4399' and activeflag = 1;

update gapagreement
set updatedon = now(), updatedby='CJAMS-69407', activeflag = 0
where gapid='a5ba3d17-deed-431b-b56e-7e8f1765d464' and activeflag = 1;

update routing
set updatedon = now(), updatedby='CJAMS-69407', activeflag = 0
where  objectid='6f587377-b24b-41ec-a62f-0b22df2987cb' and activeflag = 1;


----------------------------------------------------------------------------


update permanencyplan
set updatedon = now(), updatedby='CJAMS-69407', activeflag = 0
where permanencyplanid='d1c300c5-d52a-4726-92b8-4919ea6c541e' and activeflag = 1;

update permanencyplan_history
set updatedon = now(), updatedby='CJAMS-69407', activeflag = 0
where permanencyplanid='d1c300c5-d52a-4726-92b8-4919ea6c541e' and activeflag = 1;

update routing
set updatedon = now(), updatedby='CJAMS-69407', activeflag = 0
where objectid='d1c300c5-d52a-4726-92b8-4919ea6c541e'  and activeflag = 1;

update guardianship
set updatedon = now(), updatedby='CJAMS-69407', activeflag = 0
where permanencyplanid='d1c300c5-d52a-4726-92b8-4919ea6c541e' and activeflag = 1;





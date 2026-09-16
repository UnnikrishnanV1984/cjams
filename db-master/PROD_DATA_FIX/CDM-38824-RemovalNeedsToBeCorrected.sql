/*
Issue Description: 231030157236:Placement/removal was closed in CJAMS but child's counsel filed exceptions so case remains open.
We need removal end date and placement end date deleted as we still need to work in service case.
 Category/ Module  : Placement and Person tables
Root cause:Data fix to upadted the dates.
Fix provided :yes,write db query
Code fix ticket#:CDM-38824
Reason why no related code fix: Status of the code fix already submitted
Status of the code fix if already submitted and expected prod fix date: N/A
Backup before update/ delete:
*/
--Person
update
 personprogramarea
set
enddate = null,
updatedby = 'CDM-38824',
updatedon = now()
where personprogramid = '161b06f7-9099-4a6f-8ec8-875527d2ac98' and activeflag = 1;

--Placement
update
 placement
set
enddatetime = null,
endtime = null,
updatedby = 'CDM-38824',
updatedon = now()
where placementid = 'ace416a3-ee83-42b5-bc46-13429e0a74ae' and activeflag = 1;

update
 placement
set
enddatetime = null,
endtime = null,
updatedby = 'CDM-38824',
updatedon = now()
where placementid = '62f6d1f7-b23f-47c8-a5d2-2c89894d234a' and activeflag = 1;


--child removal
update intakeservreqchildremoval
set
exitdate = null,
updatedby = 'CDM-38824',
updatedon = now()
where intakeservreqchildremovalid = '81cf9e3a-790e-42bf-b95e-9fac2211f265' and activeflag = 1;

--updated fix
update tb_client_eligibility
set
end_dt = null,
update_user_id = 'CDM-38824',
update_ts = now()
where removal_id = 281886 and delete_sw = 'N';
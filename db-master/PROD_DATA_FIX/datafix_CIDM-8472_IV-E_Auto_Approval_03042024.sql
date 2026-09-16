-- CIDM-8472 - IV-E Auto Approval Batch
-- Datafix To Auto Approve the identified IV-E Determinations by the IV-E Team

-- *****  Dependency ******
/*
@Devops:

This fix is having new Stored Procedure (DDL), Data Load Sccript (DML) and a datafix script 

So, the order of deployment is 
1) Create Table: CIDM-8472_IV-E_Auto_Approval_DDL.sql
2) Load the data: CIDM-8472_IV-E_Auto_Approval_DML.sql
3  Deploy SP: sp_ive_auto_approval.sql
2) Datafix Script run: datafix_CIDM-8472_IV-E_Auto_Approval_03042024
															  )
*/

select a.al_sqlcode, a.as_mess
from cjams.sp_ive_auto_approval('CIDM-8472'::character varying) a ;


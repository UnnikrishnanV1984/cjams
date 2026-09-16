/*
   Issue Description: CDM-24281
   Category/ Module  : Restricted Access
 
   Data fix: restricted access given to the user donna.duvall
*/

delete from restricteditems
where   objectid = 'ffc8459e-24a9-4ab3-bfae-9248d043a187' 
        and accessuserid = 'dffeeac8-06ad-4124-8f8d-8660da1c6262'
        and activeflag = 1;

insert into restricteditems(objecttypekey, objectid, accessuserid, insertedby, insertedon, updatedby, updatedon, activeflag, roletypekey)
values('SERVICE', 'ffc8459e-24a9-4ab3-bfae-9248d043a187', 'dffeeac8-06ad-4124-8f8d-8660da1c6262', 'CDM-24281', now(), 'CDM-24281', now(), 1, 'CWCW' );

/*
   Issue Description: CDM-32201
   Category/ Module  : Personprogramarea 
   Root cause: user created by mistake 
   Fix Provided: Did data fix to remove mentioned  personprogramarea's
*/



update cjams.personprogramarea set activeflag=0 ,updatedon = now(), updatedby = 'CDM-32201' where personprogramid='7d086269-ba31-43b5-856f-9675af28bf23';


update cjams.personprogramarea set activeflag=0 ,updatedon = now(), updatedby = 'CDM-32201' where personprogramid='a9730e70-406d-47a6-9a01-e14bd1d351ee';


update cjams.personprogramarea set activeflag=0 ,updatedon = now(), updatedby = 'CDM-32201' where personprogramid='575c619f-fece-41b5-9334-8eea71279d6c';


update cjams.personprogramarea set activeflag=0 ,updatedon = now(), updatedby = 'CDM-32201' where personprogramid='df287f0f-0d21-4959-a83c-1f35321b1790';
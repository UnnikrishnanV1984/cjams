update eneoutboundtrigger
set statusflag = 'X'
where eneoutboundtriggerid
in (
select eneoutboundtriggerid
from eneoutboundtrigger ene,
person pr
where ene.fk_id = pr.cjamspid
and pr.cisclientid is null
    )
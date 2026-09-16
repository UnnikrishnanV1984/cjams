drop trigger IF EXISTS  tr_placmnt_ins on cjams.placement ;

create trigger tr_placmnt_ins after insert
     on
    cjams.placement for each row execute procedure fn_placmnt_upd();
    




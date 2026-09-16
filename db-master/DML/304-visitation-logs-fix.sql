--PLEASE MAKE SURE THIS IS ONLY RUN ONCE
update visitationlog set activeflag = case when activeflag = 0 then 1
                                           when activeflag = 1 then 0
                                           end
                                           where old_id is not null;
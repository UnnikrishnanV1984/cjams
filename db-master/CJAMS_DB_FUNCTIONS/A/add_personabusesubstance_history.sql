-- B-130716 changes:
-- Adding trigger on personabusesubstance to populate history.

create trigger add_personabusesubstance_history after
insert
    or
update
    on
    cjams.personabusesubstance for each row execute procedure add_trigger_personabusesubstance_history();
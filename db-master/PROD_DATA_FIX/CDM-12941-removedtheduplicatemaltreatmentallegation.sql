update investigationmaltreatment set activeflag = 0, updatedon = now(), updatedby = 'CDM-12941' where maltreatmentid in ('92970f7e-c895-485a-bdf7-6b7e293c9cdd',
'fef38133-1a2e-41da-9233-02cd6a5f9e05','02b07a1c-ea81-4c9b-ad48-544fc740274e') and activeflag = 1;

update Investigationmaltreatmentactor set activeflag = 0, updatedon = now(), updatedby = 'CDM-12941' where maltreatmentid in ('92970f7e-c895-485a-bdf7-6b7e293c9cdd',
'fef38133-1a2e-41da-9233-02cd6a5f9e05','02b07a1c-ea81-4c9b-ad48-544fc740274e') and activeflag = 1;
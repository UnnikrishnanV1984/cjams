-- Default supervisor(b0177f51-d7ac-4739-be6f-5853d05032f5 ) has been inactive and updating to re-routing supervisor - CDM-9810 
update routing set tosecurityusersid = '13991714-046a-47ff-a1ed-81cafaf1997b' where objectid in ('fec43467-39ff-4d90-bea0-48774c8213d6',
'1760024', 'c262fdb5-0ec3-4952-9532-61e3e5b504fd','b22227ea-50a4-4f09-8039-c128e5d1f963') and activeflag = 1 and tosecurityusersid = 'b0177f51-d7ac-4739-be6f-5853d05032f5';

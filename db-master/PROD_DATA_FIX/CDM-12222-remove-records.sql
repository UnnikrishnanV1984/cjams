update routing set activeflag = 0, updatedby = 'CDM-12222', updatedon = now() where 
routingid in ('2f547591-f8fd-4f3d-a543-1fa1639f91e4',
'298d44d5-6787-4f0f-98d1-78fbb267e340',
'31b2eb00-7fb0-46b1-97a1-00867f0ca44b',
'3b747fc4-773c-4e1f-9a08-ea6da88428a6',
'70b793a8-99b9-4513-b803-326444b70606',
'b4191719-0efd-4993-858a-9cbb8a116d63',
'e891f46c-34d2-46ab-9507-aa353ce5fb96');
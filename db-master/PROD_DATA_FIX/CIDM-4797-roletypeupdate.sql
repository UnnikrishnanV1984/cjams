/*
  Issue Description: CIDM-4797 - Ref: CDM-23021 - Placement Approval Issue
   Category/ Module  :  user management
   Root cause: In correct roletypekey in the teammember table
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: CWDIR1KAPR
*/

 Update teammember 
set roletypekey = 'CWSP',
	updatedon = now(),
	updatedby = 'CIDM-4797'
where teammemberid in ('eba94409-2ed7-4f93-951f-c8b58b7c6ae7',
'ac8eb628-cef5-48d1-9c97-20fbaf897af7',
'955b4bfc-2c68-4128-9015-dbf0c152c82d',
'aaf4e813-2554-4df8-ba93-75f6999ae728',
'89ddc9d0-67fa-4419-8c74-20024f5f8ed9',
'b0f2a629-1937-40aa-a75b-35c0a4f186a9',
'51036a97-d3e8-4fe2-9336-9eb94edab843',
'fd8d1d22-5100-4a6e-b1f3-3dde1e584db3',
'83b11db5-243e-494f-9d17-64221e6dc3e8',
'27d16872-5015-4985-89bb-72a314111618',
'8987c397-09ae-42cf-948f-213e3ccecff9'
)
and activeflag  = 1 ;
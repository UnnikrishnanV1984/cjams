-- CDM-13897
-- Removed pending approvals from list
UPDATE routing 
SET activeflag = 0,
    updatedby = 'CDM-13897', 
    updatedon = now()
WHERE activeflag = 1 and objectid in ('4287ff24-5e8f-441b-8fba-4b6bd5d86182', '49759167-e08a-4ccf-a2ef-1e0649a1a730', 'b840c9c2-4898-4e36-b561-b695c424bb95', '55a8b72d-d963-42aa-b1db-90b6fe7ec46c', '16195f7c-ce78-4e5c-920c-39ae6e25caee', 'fd887c17-4a07-4083-a08c-0f323f679cef', '05c6abb2-10cb-4b1e-bfe4-7f5ec99d8d4f', '90d00881-f6b8-40cf-8f79-c420ecb70479', 'd668bc56-d301-4ce0-9340-53a3b03442a7')

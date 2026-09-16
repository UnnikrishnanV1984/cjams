-- 20200310050333 (AR),CW2955278, CW2954338
update routing set activeflag = 0, updatedon = now(),updatedby = 'CDM-12543' where routingid in (
'796c99bb-20bf-4f66-8837-b8e4408137d0','e4de8e50-0179-4def-bbea-a43573d0f3d2', '9b7ccac7-1c48-4a09-bbc0-5dfaf7ce8d88',
'4b3b87bb-a660-43a3-b7f4-316fe5214fd3','f6d15f71-f2e9-4ebe-8c8f-46328aa72f6a');
-- 03/20 Manual run
select * from cjams.SP_BATCH_PROV_CHECKLIST('U','2026-03-20'::date);
select * from cjams.SP_UNDER_OVER_ADOPTION('2026-03-20'::date);
select * from cjams.SP_UNDER_OVER_GAP('2026-03-20'::date);
select * from cjams.SP_UNDER_OVER_PVT('2026-03-20'::date);
select * from cjams.SP_UNDER_OVER_PUB('2026-03-20'::date);

-- 03/21 Manual run
select * from cjams.SP_BATCH_PROV_CHECKLIST('U','2026-03-21'::date);
select * from cjams.SP_UNDER_OVER_ADOPTION('2026-03-21'::date);
select * from cjams.SP_UNDER_OVER_GAP('2026-03-21'::date);
select * from cjams.SP_UNDER_OVER_PVT('2026-03-21'::date);
select * from cjams.SP_UNDER_OVER_PUB('2026-03-21'::date);

-- All 
select * from cjams.SP_IVE_INSERT_RS_STATUS();
select * from cjams.sp_placement_validation_Datafix( '2026-03-20'::date, '2026-03-21'::date, 'financeFx' );
delete
from
	tb_ticklers
where
	tickler_id in (
	select
		tk.tickler_id
	from
		tb_ticklers tk
	where
		tk.system_tickler_id = 439
		and tk.delete_sw = 'N'
		and (
		select
			count(1)
		from
			tb_placement pl
		where
			pl.provider_id = tk.entity_key_id
			and coalesce(void_sw, '') = 'Y'
			and void_approval_dt::date >= tk.create_ts::date ) = 0 );
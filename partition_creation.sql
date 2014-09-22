with part_create as (
	select table_owner, table_name, partition_name from dba_tab_partitions tp
	where tp.table_name in 
	('F_CPA_BRK_IN_SPLY', 'F_CPA_ORD_ADJ', 'F_CPA_STK_OUT', 'F_CPA_TOYS_RPT', 'F_GENDER_USAGE_HIST', 'F_POST_PROMO_REST_RPT',
	'F_POST_PROMO_SUMRY_RPT', 'F_PPO_PROMO_FCST', 'F_RET_BRK_IN_SPLY', 'F_RET_RUN_OUTS', 'F_RET_SPCL')
	and partition_position = 26
	minus
	select table_owner, table_name, partition_name from dba_tab_partitions tp
	where tp.table_name in 
	('F_CPA_BRK_IN_SPLY', 'F_CPA_ORD_ADJ', 'F_CPA_STK_OUT', 'F_CPA_TOYS_RPT', 'F_GENDER_USAGE_HIST', 'F_POST_PROMO_REST_RPT',
	'F_POST_PROMO_SUMRY_RPT', 'F_PPO_PROMO_FCST', 'F_RET_BRK_IN_SPLY', 'F_RET_RUN_OUTS', 'F_RET_SPCL')
	and partition_position = 25
	order by table_name)
select 'alter table ' ||table_owner ||'.' ||table_name|| ' add partition '  ||partition_name|| ' values less than (2600);'
from part_create;
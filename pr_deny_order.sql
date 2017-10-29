set term ^ ;
create procedure pr_deny_order
       (
       v_id_order integer
       )
as
declare variable v_ts timestamp;
begin
	if (exists (select 1 from ta_orders where id_order=:v_id_order and required=1))
	   then exit;
	insert into ta_order_feat
		(id_order,id_feat,feat_val_ts,ts_start)
		values
		(:v_id_order,4,:v_ts,:v_ts);
	update ta_orders
	set
		execution=3
	where
		id_order=:v_id_order;
end ^
set term ; ^

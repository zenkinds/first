set term ^ ;
create procedure pr_make_order
       (
       v_id_debtor integer,
       v_id_creditor integer,
       v_claimed_amnt decimal(18,2),
       v_required smallint
       )
as
begin
	insert into ta_orders
	       (id_order,id_debtor,id_creditor,claimed_amnt,required,execution,ts_create)
	       values
	       (next value for se_id_order,:v_id_debtor,:v_id_creditor,:v_claimed_amnt,:v_required,1,current_timestamp);
end ^
set term ; ^

-- Drop table

-- DROP TABLE public.revenue_analysis;

CREATE TABLE public.revenue_analysis (
	activity_date date NOT NULL,
	member_id int4 NOT NULL,
	game_id int2 NOT NULL,
	wager_amount float4 NOT NULL,
	number_of_wagers int4 NOT NULL,
	win_amount float4 NOT NULL,
	activity_year_month int4 NOT NULL,
	bank_type_id int2 NOT NULL DEFAULT 0
);
CREATE INDEX activity_month_idx ON public.revenue_analysis USING btree (activity_year_month);
CREATE INDEX game_id_idx ON public.revenue_analysis USING btree (game_id);
CREATE INDEX member_id_idx ON public.revenue_analysis USING btree (member_id);

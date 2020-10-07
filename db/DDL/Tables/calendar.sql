-- Drop table

-- DROP TABLE public.calendar;

CREATE TABLE public.calendar (
	calendar_date date NOT NULL,
	calendar_year int4 NOT NULL,
	calendar_month_number int4 NOT NULL,
	calendar_month_name varchar(100) NULL,
	calendar_day_of_month int4 NOT NULL,
	calendar_day_of_week int4 NOT NULL,
	calendar_day_name varchar(100) NULL,
	calendar_year_month int4 NOT NULL
);
CREATE INDEX calendar_date_idx ON public.calendar USING btree (calendar_date);

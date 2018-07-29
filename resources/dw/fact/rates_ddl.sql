begin;
  create table dw.rates (
    date      date,
    currency  text,
    rate      decimal(10,2)
  );
commit;


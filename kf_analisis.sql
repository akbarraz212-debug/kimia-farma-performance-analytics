  CREATE TABLE `rakamin-kf-analytics-507611.kimia_farma.kf_analisa` AS 

  SELECT
    ft.transaction_id,
    ft.date,
    ft.branch_id,
    kc.branch_name,
    kc.kota,
    kc.provinsi,
    kc.rating AS rating_cabang,
    ft.customer_name,
    ft.product_id,
    p.product_name,
    p.price AS actual_price,
    ft.discount_percentage,

    -- Persentase gross laba
    CASE
      WHEN p.price <= 50000 THEN 0.10
      WHEN p.price <= 100000 THEN 0.15
      WHEN p.price <= 300000 THEN 0.20
      WHEN p.price <= 500000 THEN 0.25
      ELSE 0.30
    END AS persentase_gross_laba,

    -- Nett sales
    p.price * (1 - ft.discount_percentage / 100) AS nett_sales,

    -- Nett profit
    p.price * (1 - ft.discount_percentage / 100)
      * CASE
          WHEN p.price <= 50000 THEN 0.10
          WHEN p.price <= 100000 THEN 0.15
          WHEN p.price <= 300000 THEN 0.20
          WHEN p.price <= 500000 THEN 0.25
          ELSE 0.30
        END AS nett_profit,

    ft.rating AS rating_transaksi

  FROM `rakamin-kf-analytics-507611.kimia_farma.kf_final_transaction` ft

  LEFT JOIN `rakamin-kf-analytics-507611.kimia_farma.kf_kantor_cabang` kc
    ON ft.branch_id = kc.branch_id

  LEFT JOIN `rakamin-kf-analytics-507611.kimia_farma.kf_product` p
    ON ft.product_id = p.product_id;


  
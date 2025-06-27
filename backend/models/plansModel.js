import pool from "../config/config.js";

const Plans = async () => {
  const query = `
    
  SELECT
  p.plan_id,
  pt.name AS plan_type,
  p.price,
  p.duration_months,
  GROUP_CONCAT(pf.feature SEPARATOR ', ') AS features
FROM plans p
JOIN plan_types pt ON p.type_id = pt.type_id
LEFT JOIN plan_features pf ON p.plan_id = pf.plan_id
GROUP BY p.plan_id, pt.name, p.price, p.duration_months
ORDER BY
  FIELD(p.duration_months, '12 months', '24 months', '36 months'),
  FIELD(pt.name, 'Basic', 'Pro', 'Premium')

`;
  const [rows] = await pool.query(query);
  return rows;
};

export { Plans };

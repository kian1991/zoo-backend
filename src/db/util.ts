import { getPool } from './db.js';

export async function getRowCount(tableName: string) {
  const result = await getPool().query(
    `SELECT n_live_tup as count FROM pg_stat_all_tables WHERE relname = $1;`,
    [tableName]
  );
  return Number(result.rows[0].count);
}

console.log(await getRowCount('tier'));

import { getPool } from '../db/db.js';

export class CompoundModel {
  static async findAll() {
    const result = await getPool().query(`SELECT * FROM "Gehege"`);
    return result.rows;
  }
}

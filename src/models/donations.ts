import { HTTPException } from 'hono/http-exception';
import { getPool } from '../db/db.js';
import type { Animal, Donation } from '../types.js';

export class DonationModel {
  static async findAll() {
    const result = await getPool().query(`SELECT * FROM spenden`);
    if (result.rowCount === 0)
      throw new HTTPException(404, { message: 'no animals found' });
    return result.rows;
  }

  static async findById(id: number) {
    const result = await getPool().query(`SELECT * FROM spende WHERE id = $1`, [
      id,
    ]);
    if (result.rowCount === 0)
      throw new HTTPException(404, { message: 'no animal found' });
    return result.rows[0];
  }

  static async create(donation: Donation) {
    const result = await getPool().query(
      `INSERT INTO spende (spender_name, datum, betrag, beleg_url) VALUES ($1, $2, $3, $4) RETURNING *`,
      Object.values(donation)
    );
    return result.rows[0];
  }
}

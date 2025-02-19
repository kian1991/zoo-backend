import { HTTPException } from 'hono/http-exception';
import { getPool } from '../db/db.js';

export class StaffModel {
  static async findAll() {
    const result = await getPool().query(
      `SELECT p.id, b.bezeichnung FROM personal p JOIN beruf b ON p.beruf_id = b.id`
    );
    if (result.rowCount === 0)
      throw new HTTPException(404, { message: 'no animals found' });
    return result.rows;
  }

  static async findById(id: number) {
    const result = await getPool().query(
      `SELECT p.id, b.bezeichnung FROM personal p JOIN beruf b ON p.beruf_id = b.id WHERE p.id = $1`,
      [id]
    );

    console.log('result.rows', result.rows);
    return result.rows; // can be empty arr
  }

  static async getFreeVets() {
    const freeVets = await getPool().query(`
                SELECT p.id, COUNT(*) FROM personal p 
                JOIN beruf b ON p.beruf_id = b.id 
                JOIN tier t ON t.tierarzt_id = p.id
                WHERE b.bezeichnung = 'Tierarzt'
                GROUP BY p.id;`);

    if (freeVets.rowCount === 0)
      throw new HTTPException(404, { message: 'no animals found' });
    return freeVets.rows;
  }
}

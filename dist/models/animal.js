import { HTTPException } from 'hono/http-exception';
import { getPool } from '../db/db.js';
export class AnimalModel {
    static async findAll() {
        const result = await getPool().query(`SELECT * FROM tier`);
        if (result.rowCount === 0)
            throw new HTTPException(404, { message: 'no animals found' });
        return result.rows;
    }
    static async findById(id) {
        const result = await getPool().query(`SELECT * FROM tier WHERE id = $1`, [
            id,
        ]);
        if (result.rowCount === 0)
            throw new HTTPException(404, { message: 'no animal found' });
        return result.rows[0];
    }
    static async create(animal) {
        // Constraints
        // 1. Tier darf niemals ohne Tierarzt
        // 2. Tierarzt max 25 Tiere
        // 3. Tier muss in Gehege passen (Kapazität)
    }
}

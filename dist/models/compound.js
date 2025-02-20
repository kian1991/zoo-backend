import { getPool } from '../db/db.js';
import { HTTPException } from 'hono/http-exception';
export class CompoundModel {
    static async findAll() {
        const result = await getPool().query(`SELECT * FROM "Gehege"`);
        return result.rows;
    }
    static async update(compound) {
        // get id from gehege
        if (!compound.id)
            throw new Error('No id provided');
        const queryConfig = {
            text: `UPDATE "Gehege" SET groesse = $1, instandhaltungskosten = $2, name = $3 WHERE id = $4 RETURNING *`,
            values: [
                compound.groesse,
                compound.instandhaltungskosten,
                compound.name,
                compound.id,
            ],
        };
        // update in DB
        const result = await getPool().query(queryConfig);
        return result.rows;
    }
    static async partialUpdate(id, patch) {
        // in prod: input validation with zod
        // --> data would be safe from here on to prevent sql injection etc.
        // check if exist by id and handle error
        let result = await getPool().query('SELECT FROM "GEHEGE" WHERE id = $1', [
            id,
        ]);
        // Guard Clause
        if (result.rowCount === 0)
            throw new HTTPException(404, { message: 'No compound found.' });
        const [keys, values] = Object.entries(patch);
        let queryStringArray = keys
            .map((key, i) => `${key} = $${i + 2}` // + 2 bc $1 is reserved for id
        )
            .join(', ');
        // Dynamic queryconfig
        const queryConfig = {
            text: `UPDATE "Gehege" SET ${queryStringArray} WHERE id = $1 RETURNING *`,
            values: [id, ...values],
        };
        // update in DB
        result = await getPool().query(queryConfig);
        return result.rows;
    }
}

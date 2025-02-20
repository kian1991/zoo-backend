import { Hono } from 'hono';
import { AnimalModel } from '../models/animal.js';
import { AnimalSchema } from '../types.js';

export const animalRouter = new Hono();

animalRouter.get('/', async (c) => {
  try {
    const animals = await AnimalModel.findAll();
    return c.json({ data: animals });
  } catch (error) {
    console.error(error);
    return c.json({ error: 'Something wrong. :(' });
  }
});

animalRouter.post('/', async (c) => {
  try {
    // DATA VALIDATION
    const body = await c.req.json();
    const result = await AnimalSchema.safeParseAsync(body);

    // ERROR RESPONSE
    if (!result.success)
      return c.json(
        {
          error: result.error,
        },
        400
      );

    // Here is data safe, parsed, and validated
    //...
    return c.json(result.data);
  } catch (error) {
    if (error instanceof SyntaxError) {
      return c.json({ error: 'Error Parsing JSON.' });
    }

    console.error(error);
    return c.json({ error: 'Something wrong. :(' });
  }
});

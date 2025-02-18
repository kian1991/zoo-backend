import { Hono } from 'hono';
import { CompoundModel } from '../models/compound.js';

export const compoundRouter = new Hono();

compoundRouter.get('/', async (c) => {
  try {
    // Logik
    const compounds = await CompoundModel.findAll();
    return c.json({
      data: compounds,
    });
  } catch (error) {
    // Error handling
    console.error(error);
    c.json({
      error: 'Oh Snap! Something went wrong.',
    });
  }
});

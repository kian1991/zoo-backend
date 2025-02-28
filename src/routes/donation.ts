import { Hono } from 'hono';
import { DonationSchema } from '../types.js';
import { error } from 'console';
import { DonationModel } from '../models/donations.js';

export const donationRouter = new Hono();

donationRouter.get('/', async (c) => {
  try {
    const donations = await DonationModel.findAll();
    return c.json({ data: donations });
  } catch (error) {
    console.error(error);
    return c.json({ error: 'Something wrong. :(' });
  }
});

donationRouter.post('/', async (c) => {
  try {
    // Parse data with schema
    const body = await c.req.json();
    const result = DonationSchema.safeParse(body);

    if (result.success === false) {
      return c.json({
        error: result.error.flatten().fieldErrors,
      });
    }

    // Data is valid here
    const insertedDonation = await DonationModel.create(result.data);

    return c.json({
      data: insertedDonation,
    });
  } catch (error) {
    console.error(error);
    c.json({
      error: 'Internal Server Error',
    });
  }
});

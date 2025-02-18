import 'dotenv/config';
import { serve } from '@hono/node-server';
import { Hono } from 'hono';
import { compoundRouter } from './routes/compound.js';
import { cors } from 'hono/cors';

const app = new Hono();

// cors
app.use(cors());

// Connecting routes
app.route('/compounds', compoundRouter);

app.get('/', async (c) => {
  return c.text('Hello Kian! 🔥');
});

serve(
  {
    fetch: app.fetch,
    port: 3000,
  },
  (info) => {
    console.log(`Server is running on http://${info.address}:${info.port}`);
  }
);

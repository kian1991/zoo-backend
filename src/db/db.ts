import pg, { type Client, type Pool } from 'pg';

let client: null | Client = null;
let pool: null | Pool = null;

// Singleton implementation
export function getClient() {
  if (client) {
    return client;
  }
  client = new pg.Client();
  return client;
}

export function getPool() {
  if (pool) {
    return pool;
  }
  pool = new pg.Pool();

  return pool;
}

import { CompoundModel } from './models/compound.js';
import 'dotenv/config';

async function main() {
  await CompoundModel.partialUpdate(1, {
    groesse: 200,
    instandhaltungskosten: 220,
  });
}

main();

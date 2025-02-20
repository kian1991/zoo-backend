import { z } from 'zod';
import { AnimalModel } from './models/animal.js';
import { StaffModel } from './models/staff.js';

export const GehegeSchema = z.object({
  id: z.number().optional(),
  groesse: z.number(),
  instandhaltungskosten: z.number(),
  name: z.string(),
});

export type Gehege = z.infer<typeof GehegeSchema>;

export const AnimalSchema = z.object({
  id: z.number().optional(),
  name: z.string(),
  gehege_id: z.number(),
  tierarzt_id: z.number().refine(async (id) => await StaffModel.isVet(id), {
    message: `There is no vet with the id you provided.`,
  }),
});

export type Animal = z.infer<typeof AnimalSchema>;

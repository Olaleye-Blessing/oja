import { z } from "zod";

export const UpdatePasswordSchema = z.object({
  current_password: z.string(),
  new_password: z.string().superRefine((val, ctx) => {
    let message = "";

    if (val.length < 5) {
      message += `Must be at least 5 characters long.--`;
    }

    if (!/[a-z]/.test(val)) {
      message += `Must contain at least one lowercase letter.--`;
    }

    if (!/[A-Z]/.test(val)) {
      message += `Must contain at least one uppercase letter.--`;
    }

    if (!/[0-9]/.test(val)) {
      message += `Must contain at least one number.--`;
    }

    if (!/[!?@#$%^&*_]/.test(val)) {
      message += `Must contain at least one symbol: !?@#$%^&*_--`;
    }

    if (message) {
      ctx.addIssue({
        code: z.ZodIssueCode.custom,
        message,
      });
    }
  }),
});

export type UpdatePasswordData = z.infer<typeof UpdatePasswordSchema>;

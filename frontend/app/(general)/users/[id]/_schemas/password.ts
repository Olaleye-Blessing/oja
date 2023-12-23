import { z } from "zod";
import { validatePassword } from "@/utils/validate-password";

export const UpdatePasswordSchema = z.object({
  current_password: z.string(),
  new_password: z.string().superRefine((val, ctx) => {
    let message = validatePassword(val);

    if (message) {
      ctx.addIssue({
        code: z.ZodIssueCode.custom,
        message,
      });
    }
  }),
});

export type UpdatePasswordData = z.infer<typeof UpdatePasswordSchema>;

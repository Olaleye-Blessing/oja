import { z } from "zod";
import { validatePassword } from "@/utils/validate-password";

export const SignUpSchema = z.object({
  username: z
    .string()
    .min(3, { message: "Must be at least 3 characters long." }),
  email: z.string().email(),
  password: z.string().superRefine((val, ctx) => {
    let message = validatePassword(val);

    if (message) {
      ctx.addIssue({
        code: z.ZodIssueCode.custom,
        message,
      });
    }
  }),
});

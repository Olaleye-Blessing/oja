"use client";

import { redirect } from "next/navigation";
import axios from "axios";
import toast from "react-hot-toast";
import { Button } from "@/components/ui/button";
import { API_URL } from "@/utils/constant";
import { TokenType, UserType, useAuthStore } from "@/store/useAuth";
import { getError } from "@/utils/get-error";
import { useZodForm } from "@/hooks/useZodForm";
import Input from "./input";
import { SignUpSchema } from "../_schema/schema";
import Link from "next/link";

interface IFormData {
  username: string;
  email: string;
  password: string;
}

const Form = () => {
  const login = useAuthStore((store) => store.login);

  const {
    register,
    handleSubmit,
    setError,
    formState: { errors, isValid },
  } = useZodForm({
    schema: SignUpSchema,
    mode: "onSubmit",
    defaultValues: {
      username: "",
      email: "",
      password: "",
    },
  });

  const onSubmit = handleSubmit(async (data) => {
    try {
      const { data: result } = await axios.post<{
        user: UserType;
        tokens: TokenType;
      }>(`${API_URL}/auth/signup`, data);

      toast.success("Sign up successfully");

      login(result.user, result.tokens);

      redirect("/");
    } catch (error) {
      let messages = getError(error);

      Object.entries(messages).forEach(([key, value]) => {
        setError(key as keyof IFormData, {
          type: "manual",
          message: (value as unknown as []).join("--"),
        });
      });
    }
  });

  return (
    <form onSubmit={onSubmit} className="w-full max-w-lg mx-auto p-4 cardboard">
      <header>
        <h1 className="text-xl text-center font-semibold mb-3">
          Create an Account
        </h1>
      </header>
      <Input
        label="Username"
        type="text"
        {...register("username")}
        error={errors.username}
      />
      <Input
        label="Email"
        type="email"
        {...register("email")}
        error={errors.email}
      />
      <Input
        label="Password"
        type="password"
        {...register("password")}
        error={errors.password}
      />

      <div className=" flex items-center justify-center">
        <Button type="submit" aria-disabled={isValid} className="w-full mt-6">
          Sign up
        </Button>
      </div>

      <p>
        Have an account?{" "}
        <Button asChild variant="link" className="px-0">
          <Link href="/login">Login</Link>
        </Button>
      </p>
    </form>
  );
};

export default Form;

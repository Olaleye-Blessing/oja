"use client";

import axios from "axios";
import Link from "next/link";
import { FormEvent, useState } from "react";
import HomeLogo from "@/components/home-logo";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { API_URL } from "@/utils/constant";
import { getError } from "@/utils/get-error";
import toast from "react-hot-toast";
import { useAuthStore } from "@/store/useAuth";
import { useRouter, useSearchParams } from "next/navigation";
import { InputPassword } from "@/components/ui/input-password";

const Login = () => {
  const login = useAuthStore((store) => store.login);
  const router = useRouter();
  const searchParams = useSearchParams();
  const [isSubmitting, setIsSubmitting] = useState(false);

  const handleLogin = async (e: FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    if (isSubmitting) return;

    const data = new FormData(e.currentTarget);
    const email = data.get("email");
    const password = data.get("password");

    try {
      setIsSubmitting(true);
      toast.loading("Logging in...", { id: "login" });
      const { data } = await axios.post(
        `${API_URL}/auth/login`,
        { email, password },
        { withCredentials: true },
      );

      toast.success("Logged in successfully", { id: "login" });
      login(data.user, data.tokens);

      const redirectUrl = decodeURIComponent(
        searchParams?.get("redirect") || "/",
      );

      router.replace(redirectUrl);
    } catch (error) {
      toast.error(getError(error), { id: "login" });
    } finally {
      setIsSubmitting(false);
    }
  };

  return (
    <main>
      <header className="my-8">
        <p className="flex items-center justify-center text-center">
          <HomeLogo className=" text-3xl text-primary font-bold" />
        </p>
      </header>
      <form
        onSubmit={handleLogin}
        className="w-full max-w-lg mx-auto p-4 cardboard"
      >
        <header>
          <h1 className="text-xl text-center font-semibold mb-3">
            Log in to your account
          </h1>
        </header>

        <div className="mb-4">
          <Label htmlFor="email">Email</Label>
          <Input
            type="email"
            id="email"
            name="email"
            placeholder="Johndoe@gmail.com"
            required
            autoComplete="email"
          />
        </div>

        <div>
          <Label htmlFor="password">Password</Label>
          <InputPassword
            id="password"
            name="password"
            placeholder="*********"
            required
            autoComplete="current-password"
          />
        </div>

        <div className=" flex items-center justify-center">
          <Button
            type="submit"
            className="w-full mt-6"
            aria-disabled={isSubmitting}
            loading={isSubmitting}
          >
            Log in
          </Button>
        </div>

        <p>
          No account?{" "}
          <Button asChild variant="link" className="px-0">
            <Link href="/signup">Sign up</Link>
          </Button>
        </p>
      </form>
    </main>
  );
};

export default Login;

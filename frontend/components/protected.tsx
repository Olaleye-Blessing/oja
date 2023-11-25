"use client";

import { ReactNode, useEffect, useState } from "react";
import { redirect, usePathname, useSearchParams } from "next/navigation";
import { useAuthStore } from "@/store/useAuth";
import Loading from "@/app/(general)/loading";

interface ProtectedProps {
  children: ReactNode;
}

export default function Protected({ children }: ProtectedProps) {
  const user = useAuthStore((state) => state.user);
  const pathname = usePathname();
  const searchParams = useSearchParams();

  const [authenticating, setAuthenticating] = useState(true);

  useEffect(() => {
    const redirectPath = pathname?.split("/").slice(1).join("/");
    const redirectParams = searchParams?.toString();

    const redirectUrl =
      redirectPath +
      (redirectParams ? `?${encodeURIComponent(redirectParams)}` : "");

    if (!user) redirect(`/login?redirect=${redirectUrl}`);

    setAuthenticating(false);
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [user]);

  if (authenticating)
    return (
      <div className="mt-4">
        <Loading />
      </div>
    );

  if (!user) return null;

  return <>{children}</>;
}

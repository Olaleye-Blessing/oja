import React from "react";
import { Button, buttonVariants } from "../ui/button";
import Link from "next/link";

const AuthPages = () => {
  return (
    <div>
      <Button asChild>
        <Link
          href="/login"
          className={buttonVariants({
            variant: "default",
          })}
        >
          Login
        </Link>
      </Button>
    </div>
  );
};

export default AuthPages;

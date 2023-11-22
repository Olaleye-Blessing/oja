import React from "react";
import HomeLogo from "../home-logo";
import { Button } from "../ui/button";
import Link from "next/link";

const Navbar = () => {
  return (
    <nav className="flex items-center justify-between py-2 px-4">
      <div>
        <HomeLogo />
      </div>

      <div>
        <Button asChild>
          <Link href="/login">Login</Link>
        </Button>
      </div>
    </nav>
  );
};

export default Navbar;

"use client";

import { useEffect, useRef } from "react";
import HomeLogo from "../home-logo";
import { useAuthStore } from "@/store/useAuth";
import Pages from "./pages";
import { useStore } from "@/store/useStore";
import { usePathname } from "next/navigation";
import { MenuIcon } from "lucide-react";
import Profile from "./profile";
import AuthPages from "./auth-pages";
import Search from "./search";
import Cart from "./cart";

const Navbar = () => {
  const user = useStore(useAuthStore, (state) => state.user);
  const pathname = usePathname();
  const contRef = useRef<HTMLDivElement>(null);

  const toggleMenu = (type?: "close" | "toggle") => {
    // the height value is gotten by inspecting the navbar element in the browser
    // if (type === "close")
    //   return contRef.current?.classList.remove("!h-[calc(100vh-52.15px)]");
    // contRef.current?.classList.toggle("!h-[calc(100vh-52.15px)]");

    if (type === "close") return contRef.current?.classList.remove("!left-0");

    contRef.current?.classList.toggle("!left-0");
  };

  useEffect(() => {
    toggleMenu("close");
  }, [pathname]);

  return (
    <div className="cardboard rounded-none flex items-center justify-between py-2 px-4 mb-6 sticky top-0 left-0 right-0">
      <div>
        <HomeLogo />
      </div>

      <div
        ref={contRef}
        className="bg-white absolute -left-full h-screen w-full top-11 transition-all duration-300 z-10 p-4 flex flex-col space-y-2 md:static md:h-auto md:p-0 md:flex-row md:space-y-0 md:space-x-4 md:items-center md:justify-between"
      >
        <Pages />
        <Search />
        <Cart />
        {user ? <Profile user={user} /> : <AuthPages />}
      </div>

      <button onClick={() => toggleMenu()} className="md:hidden">
        <MenuIcon size={24} />
      </button>
    </div>
  );
};

export default Navbar;

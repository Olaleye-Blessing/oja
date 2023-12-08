import {
  NavigationMenu,
  NavigationMenuItem,
  NavigationMenuLink,
  NavigationMenuList,
  navigationMenuTriggerStyle,
} from "@/components/ui/navigation-menu";
import Link from "next/link";

const pages = [
  {
    name: "Products",
    href: "/products",
  },
  {
    name: "List a product",
    href: "/products/new",
  },
  {
    name: "Help & Contact",
    href: "/help",
  },
];

const Pages = () => {
  return (
    <NavigationMenu className="flex-grow-0 md:flex-grow md:mx-auto">
      <NavigationMenuList className="flex flex-col space-y-4 md:flex-row md:space-y-0 md:space-x-4">
        {pages.map((page) => {
          return (
            <NavigationMenuItem key={page.href}>
              <Link href={page.href} legacyBehavior passHref>
                <NavigationMenuLink className={navigationMenuTriggerStyle()}>
                  {page.name}
                </NavigationMenuLink>
              </Link>
            </NavigationMenuItem>
          );
        })}
      </NavigationMenuList>
    </NavigationMenu>
  );
};

export default Pages;

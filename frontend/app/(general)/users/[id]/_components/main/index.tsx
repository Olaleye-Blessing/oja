import { Tabs } from "@/components/ui/tabs";
import TabHeader from "./tab-header";
import Shop, { ShopProps } from "./shop";
import About from "./about";
import type { UserPageProps } from "../../page";

interface MainProps extends ShopProps, Pick<UserPageProps, "searchParams"> {}

const Main = ({ user, searchParams }: MainProps) => {
  return (
    <main>
      <Tabs defaultValue={searchParams.tab || "shop"} className="">
        <TabHeader />

        {/* tabs contents */}
        <Shop user={user} />
        <About />
      </Tabs>
    </main>
  );
};

export default Main;

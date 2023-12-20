import { Tabs } from "@/components/ui/tabs";
import TabHeader from "./tab-header";
import Shop, { ShopProps } from "./shop";
import About from "./about";
import type { UserPageProps } from "../../page";
import CurrentUserContents from "./current-user/contents";

interface MainProps extends ShopProps, Pick<UserPageProps, "searchParams"> {}

const Main = ({ user, searchParams }: MainProps) => {
  return (
    <main>
      <Tabs defaultValue={searchParams.tab || "shop"} className="">
        <TabHeader />

        {/* tabs contents */}
        <Shop user={user} />
        <About user={user} />
        <CurrentUserContents />
      </Tabs>
    </main>
  );
};

export default Main;

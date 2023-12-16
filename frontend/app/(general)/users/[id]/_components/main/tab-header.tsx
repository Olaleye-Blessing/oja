import { TabsList } from "@/components/ui/tabs";
import { BookOpen, Store } from "lucide-react";
import TabTrigger from "./tab-trigger";
import CurrentUserTabsHeader from "./current-user/tabs-header";

const tabs = [
  {
    value: "shop",
    Icon: Store,
  },
  {
    value: "about",
    Icon: BookOpen,
  },
];

const TabHeader = () => {
  return (
    <TabsList>
      {tabs.map((tab) => (
        <TabTrigger key={tab.value} {...tab} />
      ))}
      <CurrentUserTabsHeader />
    </TabsList>
  );
};

export default TabHeader;

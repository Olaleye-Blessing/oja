import { TabsList, TabsTrigger } from "@/components/ui/tabs";
import { BookOpen, Store } from "lucide-react";

const tabs = [
  {
    value: "shop",
    icon: Store,
  },
  {
    value: "about",
    icon: BookOpen,
  },
];

const TabHeader = () => {
  return (
    <TabsList>
      {tabs.map((tab) => (
        <TabsTrigger
          key={tab.value}
          value={tab.value}
          className="data-[state=active]:text-primary capitalize"
        >
          <span>
            <tab.icon size={16} />
          </span>
          <span>{tab.value}</span>
        </TabsTrigger>
      ))}
    </TabsList>
  );
};

export default TabHeader;

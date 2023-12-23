"use client";

import { usePathname, useRouter, useSearchParams } from "next/navigation";
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
  const searchParams = useSearchParams()!;
  const pathname = usePathname();
  const router = useRouter();

  const updateTabUrl = (tab: string) => {
    const current = new URLSearchParams(Array.from(searchParams.entries()));
    current.set("tab", tab);

    router.push(`${pathname}?${current.toString()}`);
  };

  return (
    <TabsList>
      {tabs.map((tab) => (
        <TabTrigger key={tab.value} {...tab} updateTabUrl={updateTabUrl} />
      ))}
      <CurrentUserTabsHeader updateTabUrl={updateTabUrl} />
    </TabsList>
  );
};

export default TabHeader;

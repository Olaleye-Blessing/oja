"use client";

import { useParams } from "next/navigation";
import { useAuthStore } from "@/store/useAuth";
import { Eye, Settings } from "lucide-react";
import TabTrigger from "../tab-trigger";
import { useStore } from "@/store/useStore";

const CurrentUserTabsHeader = () => {
  const user = useStore(useAuthStore, (state) => state.user);
  const params = useParams<{ id: string }>();

  if (user?.id !== +params.id) return null;

  const tabs = [
    {
      value: "watched_products",
      Icon: Eye,
      label: "Watched Products",
    },
    {
      value: "settings",
      Icon: Settings,
    },
  ];

  return (
    <>
      {tabs.map((tab) => (
        <TabTrigger key={tab.value} {...tab} />
      ))}
    </>
  );
};

export default CurrentUserTabsHeader;

import type { LucideIcon } from "lucide-react";
import { TabsTrigger } from "@/components/ui/tabs";

interface TabTriggerProps {
  value: string;
  label?: string;
  Icon: LucideIcon;
}

const TabTrigger = ({ value, label, Icon }: TabTriggerProps) => {
  return (
    <TabsTrigger
      value={value}
      className="data-[state=active]:text-primary capitalize"
    >
      <span className="mr-1">
        <Icon size={16} />
      </span>
      <span>{label || value}</span>
    </TabsTrigger>
  );
};

export default TabTrigger;

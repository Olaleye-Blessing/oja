"use client";

import { copyToClipboard } from "@/utils/copy-to-clipboard";
import ActionItem from "./action-item";
import { Share, Heart } from "lucide-react";

const ListActions = () => {
  return (
    <ul className="flex items-center justify-start">
      <ActionItem
        Icon={Share}
        label="Share"
        button={{
          onClick: async () => await copyToClipboard(window.location.href),
        }}
      />
      <ActionItem
        Icon={Heart}
        label="Save Seller"
        button={{ disabled: true }}
      />
    </ul>
  );
};

export default ListActions;

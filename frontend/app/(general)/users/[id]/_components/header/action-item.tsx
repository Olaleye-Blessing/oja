"use client";

import { LucideIcon } from "lucide-react";
import { ButtonHTMLAttributes } from "react";

interface ActionItemProps {
  Icon: LucideIcon;
  label: string;
  // onClick: MouseEventHandler<HTMLButtonElement>;
  button?: ButtonHTMLAttributes<HTMLButtonElement>;
}

const ActionItem = ({ Icon, label, button = {} }: ActionItemProps) => {
  return (
    <li className="mr-2 last:mr-0">
      <button
        type="button"
        className="flex items-center justify-start"
        {...button}
      >
        <span className="mr-0.5">
          <Icon size={16} />
        </span>
        <span>{label}</span>
      </button>
    </li>
  );
};

export default ActionItem;

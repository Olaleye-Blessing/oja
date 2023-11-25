import * as React from "react";

import { cn } from "@/lib/utils";
import { Eye, EyeOff } from "lucide-react";
import { Button } from "./button";

export interface InputProps
  extends React.InputHTMLAttributes<HTMLInputElement> {}

const Input = React.forwardRef<HTMLInputElement, InputProps>(
  ({ className, type: _type, ...props }, ref) => {
    const [type, setType] = React.useState(_type);

    const toggleType = () =>
      setType((prev) => (prev === "password" ? "text" : "password"));

    return (
      <div className="relative">
        <input
          type={type}
          className={cn(
            "flex w-full rounded-md border border-input bg-background px-3 py-2 text-sm ring-offset-background file:border-0 file:bg-transparent file:text-sm file:font-medium placeholder:text-muted-foreground focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-1 disabled:cursor-not-allowed disabled:opacity-50",
            className,
          )}
          ref={ref}
          {...props}
        />
        {_type === "password" && (
          <>
            <Button
              onClick={() => toggleType()}
              size={"icon"}
              variant={"ghost"}
              type="button"
              className="absolute top-0 right-0 h-full"
            >
              {type === "password" ? <Eye /> : <EyeOff />}
            </Button>
          </>
        )}
      </div>
    );
  },
);
Input.displayName = "Input";

export { Input };

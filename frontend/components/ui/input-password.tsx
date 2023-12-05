"use client";

import { forwardRef, useState } from "react";
import { Input, InputProps } from "./input";
import { Button } from "./button";
import { Eye, EyeOff } from "lucide-react";

const InputPassword = forwardRef<HTMLInputElement, InputProps>((props, ref) => {
  const [type, setType] = useState("password");

  const toggleType = () =>
    setType((prev) => (prev === "password" ? "text" : "password"));

  return (
    <Input type={type} ref={ref} {...props}>
      <Button
        onClick={() => toggleType()}
        size={"icon"}
        variant={"ghost"}
        type="button"
        className="absolute top-0 right-0 h-full"
      >
        {type === "password" ? <Eye /> : <EyeOff />}
      </Button>
    </Input>
  );
});
InputPassword.displayName = "InputPassword";

export { InputPassword };

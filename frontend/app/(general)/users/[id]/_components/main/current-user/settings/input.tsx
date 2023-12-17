import { Label } from "@/components/ui/label";
import { Input as InputComp } from "@/components/ui/input";
import { InputHTMLAttributes } from "react";

interface InputProps extends InputHTMLAttributes<HTMLInputElement> {
  label: string;
}

const Input = ({ label, ...input }: InputProps) => {
  return (
    <div className="mb-4">
      <Label htmlFor={input.name}>{label}</Label>
      <InputComp
        id={input.name}
        name={input.name}
        placeholder={input.placeholder}
        type={input.type || "text"}
      />
    </div>
  );
};

export default Input;

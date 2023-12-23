import { Label } from "@/components/ui/label";
import { Input as InputComp } from "@/components/ui/input";
import { InputHTMLAttributes } from "react";
import { useAuthStore } from "@/store/useAuth";

interface InputProps extends InputHTMLAttributes<HTMLInputElement> {
  label: string;
}

const Input = ({ label, ...input }: InputProps) => {
  const logged_in_user = useAuthStore((state) => state.user);

  return (
    <div className="mb-4">
      <Label htmlFor={input.name}>{label}</Label>
      <InputComp
        id={input.name}
        name={input.name}
        placeholder={input.placeholder}
        type={input.type || "text"}
        defaultValue={
          logged_in_user?.[input.name as keyof typeof logged_in_user] || ""
        }
      />
    </div>
  );
};

export default Input;

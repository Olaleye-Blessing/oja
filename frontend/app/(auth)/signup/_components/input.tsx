import {
  Input as InputComp,
  InputProps as InputCompProps,
} from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { forwardRef } from "react";
import { FieldError } from "react-hook-form";

interface InputProps extends InputCompProps {
  label: string;
  error?: FieldError;
}

const Input = forwardRef<HTMLInputElement, InputProps>(
  ({ label, name, error, ...input }, ref) => {
    let err_msg =
      error?.type === "required"
        ? "This field is required"
        : error?.message?.split("--");

    return (
      <div className="mb-2">
        <Label htmlFor={name}>{label}</Label>
        <InputComp
          ref={ref}
          id={name}
          type={input.type}
          name={name}
          className={error ? "border-red-700" : ""}
          {...input}
        />
        {error && (
          <div
            role="alert"
            className="text-red-700 text-sm first-letter:capitalize"
          >
            {typeof err_msg === "string" ? (
              <p>{err_msg}</p>
            ) : (
              <ul>
                {err_msg?.map((msg, index) => (
                  <li key={index} className="first-letter:capitalize">
                    {msg}
                  </li>
                ))}
              </ul>
            )}
          </div>
        )}
      </div>
    );
  },
);

Input.displayName = "Input";

export default Input;

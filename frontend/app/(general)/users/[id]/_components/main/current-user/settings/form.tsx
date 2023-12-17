import { PropsWithChildren } from "react";
import { useForm } from "../../../../_hooks/useForm";
import { Button } from "@/components/ui/button";

interface FormProps extends PropsWithChildren {
  id: string;
}

const Form = ({ id, children }: FormProps) => {
  const { submit, submitRef } = useForm();

  return (
    <form id={id} onSubmit={submit}>
      {children}
      <div>
        <Button type="submit" ref={submitRef}>
          Update
        </Button>
      </div>
    </form>
  );
};

export default Form;

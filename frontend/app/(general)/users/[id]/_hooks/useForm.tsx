import { useOjaDB } from "@/hooks/useOjaDB";
import { useAuthStore } from "@/store/useAuth";
import { FormEvent, createRef } from "react";
import toast from "react-hot-toast";

export const useForm = () => {
  const { ojaInstance } = useOjaDB();
  const user = useAuthStore((state) => state.user);
  const submitRef = createRef<HTMLButtonElement>();

  const submit = async (e: FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    const form = e.currentTarget;
    const formId = form.id;

    const data = Object.fromEntries(new FormData(form).entries());

    try {
      toast.loading(`Updating ${formId}`, { id: formId });
      submitRef.current?.disabled;

      await ojaInstance.patch(`/profiles/${user!.id}`, data);
    } catch (error) {
      console.log(error);
    } finally {
      submitRef.current?.disabled;
      toast.dismiss(formId);
    }
  };

  return { submit, submitRef };
};

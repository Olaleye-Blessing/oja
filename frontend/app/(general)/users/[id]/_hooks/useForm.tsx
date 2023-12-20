import { useOjaDB } from "@/hooks/useOjaDB";
import { useAuthStore } from "@/store/useAuth";
import { FormEvent, createRef } from "react";
import toast from "react-hot-toast";

export const useForm = () => {
  const { ojaInstance } = useOjaDB();
  const user = useAuthStore((state) => state.user);
  const updateUser = useAuthStore((state) => state.update);
  const submitRef = createRef<HTMLButtonElement>();

  const submit = async (e: FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    const form = e.currentTarget;
    const formId = form.id;

    const data = Object.fromEntries(new FormData(form).entries());

    try {
      toast.loading(`Updating ${formId}`, { id: formId });
      submitRef.current?.disabled;

      const { data: updated_user } = await ojaInstance.patch(
        `/profiles/${user!.id}`,
        data,
      );

      updateUser(updated_user);
    } catch (error) {
      console.log(error);
    } finally {
      submitRef.current?.disabled;
      toast.dismiss(formId);
    }
  };

  return { submit, submitRef };
};

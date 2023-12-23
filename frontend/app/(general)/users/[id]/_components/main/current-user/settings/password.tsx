"use client";
import toast from "react-hot-toast";
import { InputPassword } from "@/components/ui/input-password";
import Container from "../container";
import { Button } from "@/components/ui/button";
import { useOjaDB } from "@/hooks/useOjaDB";
import { useZodForm } from "@/hooks/useZodForm";
import {
  UpdatePasswordData,
  UpdatePasswordSchema,
} from "../../../../_schemas/password";
import { getError } from "@/utils/get-error";

const Password = () => {
  const { ojaInstance } = useOjaDB();
  const {
    register,
    handleSubmit,
    formState: { isSubmitting },
    reset,
  } = useZodForm({
    schema: UpdatePasswordSchema,
    mode: "all",
    defaultValues: {
      current_password: "",
      new_password: "",
    },
  });

  const handleUpdatePassword = async (data: UpdatePasswordData) => {
    try {
      toast.loading("Updating password", { id: "pswd-update" });

      await ojaInstance.patch("/auth/update-password", data);

      toast.success("Password Updated successfully!", { id: "pswd-update" });

      reset();
    } catch (error) {
      let msg = Object.values(getError(error)).join("\n");
      toast.error(msg, { id: "pswd-update" });
    }
  };
  return (
    <Container className="cardboard" title="Change Password">
      <form onSubmit={handleSubmit(handleUpdatePassword)}>
        <div className="mb-4">
          <label htmlFor="current-password">Current Password</label>
          <InputPassword
            {...(register("current_password"), { required: true })}
            id="current-password"
          />
        </div>
        <div className="mb-4">
          <label htmlFor="new-password">New Password</label>
          <InputPassword {...register("new_password")} id="new-password" />
        </div>
        <div className="">
          <Button type="submit" loading={isSubmitting}>
            Update
          </Button>
        </div>
      </form>
    </Container>
  );
};

export default Password;

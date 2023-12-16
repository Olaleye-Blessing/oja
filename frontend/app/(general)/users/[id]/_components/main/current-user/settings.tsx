"use client";
import { InputPassword } from "@/components/ui/input-password";
import { TabsContent } from "@/components/ui/tabs";
import React from "react";
import Container from "./container";
import { Button } from "@/components/ui/button";
import {
  UpdatePasswordData,
  UpdatePasswordSchema,
} from "../../../_schemas/password";
import { useZodForm } from "@/hooks/useZodForm";
import { useOjaDB } from "@/hooks/useOjaDB";
import toast from "react-hot-toast";
import { getError } from "@/utils/get-error";

const Settings = () => {
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
    <TabsContent value="settings">
      <Container className="cardboard" title="Change Password">
        <form onSubmit={handleSubmit(handleUpdatePassword)}>
          <div className="mb-4">
            <label htmlFor="current-password">Current Password</label>
            <InputPassword
              {...register("current_password")}
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
    </TabsContent>
  );
};

export default Settings;

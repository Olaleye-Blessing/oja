import { SetStateAction } from "react";
import toast from "react-hot-toast";
import { UseMutateAsyncFunction } from "@tanstack/react-query";
import { IProduct } from "@/interfaces/product";
import { getError } from "@/utils/get-error";

export const createProduct = async ({
  form,
  mutateAsync,
  setSubmitting,
}: {
  form: EventTarget & HTMLFormElement;
  mutateAsync: UseMutateAsyncFunction<any, Error, IProduct, unknown>;
  setSubmitting: (value: SetStateAction<boolean>) => void;
}) => {
  const formData = new FormData(form);
  const product = Object.fromEntries(formData.entries()) as unknown as IProduct;

  toast.loading("Creating product...", { id: "create-product" });

  try {
    await mutateAsync(product);

    toast.success("Product created successfully", { id: "create-product" });

    form.reset();
  } catch (error) {
    const messages = getError(error) as any;
    const message = Object.keys(messages)
      .map((key) => {
        return `${key}: ${messages[key].join(", ")}`;
      })
      .join("\n");

    toast.error(message, { id: "create-product", duration: 10_000 });
  } finally {
    setSubmitting(false);
  }
};

export const uploadImages = async () => {};

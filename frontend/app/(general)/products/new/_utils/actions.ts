import { Dispatch, SetStateAction } from "react";
import toast from "react-hot-toast";
import { UseMutateAsyncFunction } from "@tanstack/react-query";
import { IProduct } from "@/interfaces/product";
import { getError } from "@/utils/get-error";
import { ProductImageType } from "../_components/product-image";
import { uploadImage } from "@/lib/firebase/storage";

export const createProduct = async ({
  form,
  mutateAsync,
  setSubmitting,
  images,
  setImages,
}: {
  form: EventTarget & HTMLFormElement;
  mutateAsync: UseMutateAsyncFunction<any, Error, IProduct, unknown>;
  setSubmitting: (value: SetStateAction<boolean>) => void;
  images: ProductImageType[];
  setImages: Dispatch<SetStateAction<ProductImageType[]>>;
}) => {
  const formData = new FormData(form);
  const product = Object.fromEntries(formData.entries()) as unknown as IProduct;

  toast.loading("Creating product...", { id: "create-product" });

  try {
    const imgUrls = await Promise.all(
      images.map((image) => uploadImage(image.file, "products")),
    );

    await mutateAsync({ ...product, images: imgUrls });

    toast.success("Product created successfully", { id: "create-product" });

    form.reset();
    setImages([]);
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

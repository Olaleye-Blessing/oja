import { v4 as uuidv4 } from "uuid";
import { useOjaDB } from "@/hooks/useOjaDB";
import { IProduct } from "@/interfaces/product";
import { API_URL } from "@/utils/constant";
import { useMutation } from "@tanstack/react-query";
import { FormEvent, useState } from "react";
import { createProduct } from "./actions";
import { ProductImageType } from "../_components/product-image";

export const useProductForm = () => {
  const { ojaInstance } = useOjaDB();
  const { mutateAsync } = useMutation({
    mutationFn: async (product: IProduct) => {
      const { data } = await ojaInstance.post(`${API_URL}/products`, product);

      return data;
    },
  });

  const [submitting, setSubmitting] = useState(false);
  const [images, setImages] = useState<ProductImageType[]>([]);

  const handleRemoveImage = (id: string) => {
    setImages((prev) => prev.filter((image) => image.id !== id));
  };

  const handleImageChange = async (e: FormEvent<HTMLInputElement>) => {
    const { files } = e.currentTarget;

    if (!files) return;

    const images = Array.from(files).map((file) => {
      return {
        id: uuidv4(),
        previewUrl: URL.createObjectURL(file),
        file,
      };
    });

    setImages((prev) => [...prev, ...images]);
  };

  const handleCreateProduct = async (e: FormEvent<HTMLFormElement>) => {
    e.preventDefault();

    if (submitting) return;

    setSubmitting(true);

    const form = e.currentTarget;

    await createProduct({
      form,
      mutateAsync,
      setSubmitting,
      images,
      setImages,
    });
  };

  return {
    submitting,
    images,
    handleCreateProduct,
    handleRemoveImage,
    handleImageChange,
  };
};

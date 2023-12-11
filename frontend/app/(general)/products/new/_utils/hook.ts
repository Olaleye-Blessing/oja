import { useOjaDB } from "@/hooks/useOjaDB";
import { IProduct } from "@/interfaces/product";
import { API_URL } from "@/utils/constant";
import { useMutation } from "@tanstack/react-query";
import { FormEvent, useState } from "react";
import { createProduct } from "./actions";

export const useProductForm = () => {
  const { ojaInstance } = useOjaDB();
  const { mutateAsync } = useMutation({
    mutationFn: async (product: IProduct) => {
      const { data } = await ojaInstance.post(`${API_URL}/products`, product);

      return data;
    },
  });
  const [submitting, setSubmitting] = useState(false);

  const handleCreateProduct = async (e: FormEvent<HTMLFormElement>) => {
    e.preventDefault();

    if (submitting) return;

    setSubmitting(true);

    const form = e.currentTarget;

    await createProduct({ form, mutateAsync, setSubmitting });
  };

  return { handleCreateProduct, submitting };
};

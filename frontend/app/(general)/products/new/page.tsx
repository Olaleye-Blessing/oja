"use client";

import { FormEvent, useState } from "react";
import toast from "react-hot-toast";
import { useMutation } from "@tanstack/react-query";
import Protected from "@/components/protected";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { IProduct } from "@/interfaces/product";
import { useOjaDB } from "@/hooks/useOjaDB";
import { API_URL } from "@/utils/constant";
import { getError } from "@/utils/get-error";
import { fields } from "./_utils/fields";

const Page = () => {
  const { ojaInstance } = useOjaDB();
  const { mutateAsync } = useMutation({
    mutationFn: async (product: IProduct) => {
      const { data } = await ojaInstance.post(`${API_URL}/products`, product);

      return data;
    },
  });
  const [submitting, setSubmitting] = useState(false);

  const createProduct = async (e: FormEvent<HTMLFormElement>) => {
    e.preventDefault();

    if (submitting) return;

    setSubmitting(true);

    const form = e.currentTarget;
    const formData = new FormData(form);
    const product = Object.fromEntries(
      formData.entries(),
    ) as unknown as IProduct;

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

  return (
    <Protected>
      <div className="px-4">
        <header>
          <h1 className="text-center text-3xl mb-4">Sell a product</h1>
        </header>
        <main>
          <form
            onSubmit={createProduct}
            className="cardboard w-full max-w-lg mx-auto rounded-md p-4"
          >
            {fields.map(({ label, ...field }) => {
              return (
                <div key={field.name} className="mb-4">
                  <Label htmlFor={field.name}>{label}</Label>
                  <Input {...field} />
                </div>
              );
            })}
            <Button
              className="w-full mx-auto mt-6"
              type="submit"
              loading={submitting}
              aria-disabled={submitting}
            >
              Create market
            </Button>
          </form>
        </main>
      </div>
    </Protected>
  );
};

export default Page;

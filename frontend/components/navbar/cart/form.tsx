import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { useAuthStore } from "@/store/useAuth";
import React, { FormEvent, useState } from "react";
import { useCartStore } from "./store";
import toast from "react-hot-toast";
import { CheckoutData, useCartDB } from "./hook";
import { fields } from "./utils";

const Form = () => {
  const { checkout } = useCartDB();
  const user = useAuthStore((state) => state.user) || {};
  const products = useCartStore((state) => state.products) || [];
  const clearCart = useCartStore((state) => state.clearCart);
  const [submitting, setSubmitting] = useState(false);

  const handleCheckout = async (e: FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    if (submitting) return;

    if (products.length === 0)
      return toast.error(
        "Your cart is empty. Add some products to see them here.",
      );

    setSubmitting(true);

    const shipping_address = Object.fromEntries(
      new FormData(e.currentTarget),
    ) as CheckoutData["shipping_address"];

    const body = {
      shipping_address,
      products: products.map(({ product, quantity }) => ({
        product_id: product.id,
        quantity,
      })),
    };

    toast.loading("Processing your order...", { id: "checkout" });

    try {
      let res = await checkout.mutateAsync(body);

      toast.success(res, { id: "checkout-res", duration: 6_000 });

      toast.success(`Order placed successfully!`, {
        id: "checkout",
        duration: 6_000,
      });
      clearCart();
    } catch (error) {
      // Display normal error message
      toast.error("Something went wrong. Please try again later.", {
        id: "checkout",
      });
    } finally {
      setSubmitting(false);
    }
  };

  return (
    <form
      className="mt-2 flex-shrink-0 grid grid-cols-2 gap-x-2 gap-y-1"
      id="cart-form"
      onSubmit={handleCheckout}
    >
      {fields.map((field) => {
        return (
          <div key={field.name} className="">
            <Label htmlFor={field.name} className=" capitalize">
              {field.label || field.name}
            </Label>
            <Input
              {...field}
              id={field.name}
              defaultValue={user[field.name as keyof typeof user] || ""}
              className="px-2"
            />
          </div>
        );
      })}
    </form>
  );
};

export default Form;

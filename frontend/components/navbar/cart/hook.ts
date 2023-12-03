import { useOjaDB } from "@/hooks/useOjaDB";
import { getError } from "@/utils/get-error";
import { useMutation } from "@tanstack/react-query";

export interface CheckoutData {
  shipping_address: {
    full_name: string;
    email: string;
    address: string;
    city: string;
    state: string;
    country: string;
    zip_code: string;
  };
  products: {
    product_id: number;
    quantity: number;
  }[];
}

export const useCartDB = () => {
  const { ojaInstance } = useOjaDB();

  const checkout = useMutation({
    mutationFn: async (data: CheckoutData) => {
      try {
        const { data: res } = await ojaInstance.post<string>(
          "/purchases",
          data,
        );

        return res;
      } catch (error) {
        throw getError(error);
      }
    },
  });

  return { checkout };
};

import { IProduct } from "@/interfaces/product";
import { create } from "zustand";
import { devtools, persist } from "zustand/middleware";
import { immer } from "zustand/middleware/immer";

interface State {
  products: {
    product: IProduct;
    quantity: number;
  }[];
}

interface Actions {
  // addProduct: (product: IProduct, quantity: number, replace?: boolean) => void;
  addProduct: (props: {
    product: IProduct;
    quantity: number;
    replace?: boolean;
  }) => void;
  removeProduct: (product: IProduct) => void;
  clearCart: () => void;
}

export type ICartStore = State & Actions;

export const useCartStore = create<ICartStore>()(
  devtools(
    immer(
      persist(
        (set) => ({
          products: [],
          addProduct: ({ product, quantity, replace }) => {
            set((state) => {
              const _product = state.products.find(
                (p) => p.product.id === product.id,
              );

              if (!_product) {
                state.products.push({ product, quantity });
              } else {
                let _quantity = replace
                  ? quantity
                  : _product.quantity + quantity;
                if (_quantity < 1) _quantity = 1;

                _product.quantity = Math.min(_quantity, product.stock_quantity);
              }
            });
          },
          removeProduct: (product) => {
            set((state) => {
              state.products = state.products.filter(
                (p) => p.product.id !== product.id,
              );
            });
          },
          clearCart: () => {
            set((state) => {
              state.products = [];
            });
          },
        }),
        { name: "cart" },
      ),
    ),
  ),
);

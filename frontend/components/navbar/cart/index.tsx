import { Button } from "@/components/ui/button";
import {
  Sheet,
  SheetClose,
  SheetContent,
  SheetFooter,
  SheetHeader,
  SheetTitle,
  SheetTrigger,
} from "@/components/ui/sheet";
import { ShoppingCart } from "lucide-react";
import { useCartStore } from "./store";
import Product from "./product";
import { useStore } from "@/store/useStore";
import Form from "./form";

const Cart = () => {
  const products = useStore(useCartStore, (state) => state.products) || [];
  const addProductToCart = useCartStore((state) => state.addProduct);
  const removeProductFromCart = useCartStore((state) => state.removeProduct);
  const clearCart = useCartStore((state) => state.clearCart);

  const totalPrice = products.reduce(
    (acc, { product, quantity }) => acc + product.price * quantity,
    0,
  );

  return (
    <Sheet>
      <SheetTrigger asChild>
        <Button variant="outline" size={"icon"} className="relative">
          <ShoppingCart size={16} />
          <span className="absolute -right-2 -top-2 h-4 w-4 rounded bg-primary text-[11px] font-medium text-white flex items-center justify-center">
            {products.length}
          </span>
        </Button>
      </SheetTrigger>
      <SheetContent className="flex flex-col py-2 px-4">
        <SheetHeader>
          <SheetTitle>My Cart</SheetTitle>
        </SheetHeader>

        <>
          {products.length === 0 ? (
            <p>Your cart is empty. Add some products to see them here.</p>
          ) : (
            <div className="h-full flex flex-col justify-between overflow-y-hidden">
              <ul className="overflow-y-auto">
                {products.map(({ product, quantity }) => (
                  <Product
                    key={product.id}
                    product={product}
                    quantity={quantity}
                    addProductToCart={addProductToCart}
                    removeProduct={removeProductFromCart}
                  />
                ))}
              </ul>
              <Form />
            </div>
          )}
        </>

        <SheetFooter className="mt-auto justify-start flex-shrink-0">
          <p className="flex items-center justify-start text-lg font-light mr-auto">
            <span className="text-3xl font-bold mr-0.5">$</span>
            <span>
              {new Intl.NumberFormat("en-US", {
                style: "currency",
                currency: "USD",
              })
                .format(totalPrice)
                .replace(/^(\D+)/, (match) => {
                  return match.replace("$", "");
                })}
            </span>
          </p>
          <SheetClose asChild>
            <Button
              type="button"
              variant={"destructive"}
              onClick={() => clearCart()}
              className="px-2"
            >
              Clear
            </Button>
          </SheetClose>
          <SheetClose asChild>
            <Button type="button" variant={"outline"} className="px-2">
              Save
            </Button>
          </SheetClose>
          <Button
            type="submit"
            form="cart-form"
            aria-disabled={products.length === 0}
            className="px-2"
          >
            Checkout
          </Button>
        </SheetFooter>
      </SheetContent>
    </Sheet>
  );
};

export default Cart;

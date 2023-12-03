import { useState } from "react";
import { Button } from "@/components/ui/button";
import { IFullProduct } from "@/interfaces/product";
import { ShoppingCart } from "lucide-react";
import CartInput from "@/components/navbar/cart/input";
import { useCartStore } from "@/components/navbar/cart/store";

interface AddToCartProps {
  product: IFullProduct;
}

const AddToCart = ({ product }: AddToCartProps) => {
  const addProductToCart = useCartStore((state) => state.addProduct);
  const { stock_quantity, price } = product;

  const [quantity, setQuantity] = useState(1);

  const handleSetQuantity = (_quantity: number, direct?: boolean) => {
    setQuantity((prev) => {
      let newQuantity = direct ? _quantity : prev + _quantity;

      if (newQuantity > stock_quantity) {
        newQuantity = stock_quantity;
      }

      if (newQuantity < 1) {
        newQuantity = 1;
      }

      return newQuantity;
    });
  };

  return (
    <>
      <div className="max-w-max my-2">
        <CartInput
          stock_quantity={stock_quantity}
          quantity={quantity}
          handleSetQuantity={({ quantity, replace }) => {
            handleSetQuantity(quantity, replace);
            addProductToCart({ product, quantity, replace });
          }}
        />
      </div>
      <div>
        <Button
          type="button"
          onClick={() => {
            addProductToCart({ product, quantity, replace: true });
          }}
        >
          <span>
            <ShoppingCart size={16} />
          </span>
          <span className="mx-2">Add to cart • </span>
          <span>${+price * quantity}</span>
        </Button>
      </div>
    </>
  );
};

export default AddToCart;

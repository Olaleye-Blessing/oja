import { useState } from "react";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { IFullProduct } from "@/interfaces/product";
import { ShoppingCart } from "lucide-react";

type AddToCartProps = Pick<IFullProduct, "price" | "stock_quantity">;

const AddToCart = ({ price, stock_quantity }: AddToCartProps) => {
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
      <div className="flex items-center justify-start w-full mt-1 mb-3">
        <button
          className="flex items-center justify-center text-center p-3 text-green-800 bg-green-300 rounded-full w-4 h-4 mr-2"
          type="button"
          onClick={() => handleSetQuantity(1)}
        >
          +
        </button>
        <Input
          type="number"
          min={1}
          max={stock_quantity}
          step={1}
          className=" w-20 text-center"
          value={quantity}
          onChange={(e) => handleSetQuantity(+e.target.value, true)}
        />
        <button
          className="flex items-center justify-center text-center p-3 text-red-800 bg-red-300 rounded-full w-4 h-4 ml-2"
          type="button"
          onClick={() => handleSetQuantity(-1)}
        >
          -
        </button>
      </div>
      <div>
        <Button>
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

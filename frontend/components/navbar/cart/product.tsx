import Image from "next/image";
import { IProduct } from "@/interfaces/product";
import AddToCartInput from "@/components/navbar/cart/input";
import { ICartStore } from "./store";

interface ProductProps {
  product: IProduct;
  quantity: number;
  addProductToCart: ICartStore["addProduct"];
  removeProduct: ICartStore["removeProduct"];
}

const Product = ({
  product,
  quantity,
  addProductToCart,
  removeProduct,
}: ProductProps) => {
  const { name, image, price, stock_quantity } = product;

  return (
    <li className="flex py-3 first:pt-1 border-b">
      <div className="relative mr-3">
        <figure className="relative h-16 w-16 cursor-pointer overflow-hidden rounded-md border cardboard">
          <Image
            src={image}
            alt={name}
            width={64}
            height={64}
            className="h-full w-full object-cover"
          />
        </figure>
        <button
          className="ease flex w-4 h-4 items-center justify-center rounded-full text-red-700 cardboard transition-all duration-200 absolute -top-1 -right-1 text-sm p-2"
          type="button"
          onClick={() => removeProduct(product)}
        >
          X
        </button>
      </div>
      <p className="truncate">{name}</p>
      <div className="flex items-center flex-col ml-auto">
        <p>
          <span className="font-bold">$</span>
          <span>{+price * +quantity}</span>
        </p>
        <AddToCartInput
          stock_quantity={stock_quantity}
          quantity={quantity}
          handleSetQuantity={({ quantity, replace }) => {
            addProductToCart({ product, quantity, replace });
          }}
        />
      </div>
    </li>
  );
};

export default Product;

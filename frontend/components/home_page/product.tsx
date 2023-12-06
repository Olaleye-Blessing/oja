import Image from "next/image";
import Link from "next/link";
import { Button } from "../ui/button";
import toast from "react-hot-toast";
import { ShoppingCart } from "lucide-react";
import { IProduct } from "@/interfaces/product";
import { useAuthStore } from "@/store/useAuth";
import { useCartStore } from "../navbar/cart/store";

const Product = ({ product }: { product: IProduct }) => {
  const user = useAuthStore((state) => state.user);
  const cartProducts = useCartStore((state) => state.products);
  const addProductToCart = useCartStore((state) => state.addProduct);

  return (
    <li className="sm:max-w-sm">
      <Link
        href={`/products/${product.id}`}
        className="h-full flex flex-col rounded-md cardboard"
      >
        <figure className="bg-blue-500 flex items-center justify-center overflow-hidden mb-3 rounded-md rounded-b-none">
          <Image
            className="w-full h-[20rem] object-cover rounded-md"
            src={product.image}
            alt={product.name}
            width={200}
            height={200}
          />
        </figure>
        <div className="flex flex-col p-2 flex-grow">
          <p className="font-semibold">{product.name}</p>
          <p className="line-clamp-3 mb-8">{product.description}</p>
          <div className="flex items-center justify-between mt-auto">
            <div className="flex items-center justify-between flex-wrap w-full">
              <p className="flex items-center justify-center">
                <span className="text-2xl">$</span>
                <span>{product.price}</span>
              </p>
              <p
                className={`text-sm px-3 pt-[0.125rem] pb-[0.18rem] mb-1 rounded-md bg-black bg-opacity-90 ${
                  product.condition === "new"
                    ? "text-green-500"
                    : "text-red-300"
                }`}
              >
                {product.condition}
              </p>
              <p>
                <span
                  className={`font-semibold ${
                    product.stock_quantity < 4 ? " text-red-600" : ""
                  }`}
                >
                  {product.stock_quantity}
                </span>{" "}
                <span>left</span>
              </p>
            </div>
            <Button
              variant={"outline"}
              size={"icon"}
              type="button"
              className="p-0 text-primary ml-4"
              onClick={(e) => {
                e.stopPropagation();
                e.preventDefault();

                if (!user) return toast.error("Please login to add to cart");

                const cartItem = cartProducts.find(
                  (item) => item.product.id === product.id,
                );

                if (cartItem)
                  return toast.error("Product already in cart", {
                    id: String(product.id),
                  });

                addProductToCart({ product, quantity: 1 });
              }}
            >
              <ShoppingCart size={20} />
            </Button>
          </div>
        </div>
      </Link>
    </li>
  );
};

export default Product;

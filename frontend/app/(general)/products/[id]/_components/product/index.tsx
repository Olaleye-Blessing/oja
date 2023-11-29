import { IFullProduct } from "@/interfaces/product";
import { Radius, Sailboat } from "lucide-react";
import Image from "next/image";
import Link from "next/link";
import React from "react";
import AddToCart from "./add-to-cart";

const Product = ({
  product: { stock_quantity, ...product },
}: {
  product: IFullProduct;
}) => {
  return (
    <div className="sm:grid grid-cols-[2fr_2fr] gap-4 lg:grid-cols-[2fr_5fr] lg:gap-8">
      <section className="">
        <figure className="flex items-center justify-center overflow-hidden mb-3 rounded-md cardboard p-8 sm:h-full">
          <Image
            className="w-full object-contain rounded-md overflow-hidden"
            src={product.image}
            alt={product.name}
            width={200}
            height={200}
          />
        </figure>
      </section>
      <section>
        <header className="mb-3">
          <h1 className="text-2xl">
            <span>{product.name}</span>
            <div className="text-base -mt-1">
              <span>from</span>{" "}
              <Link
                href={`/users/${product.user.id}`}
                className="text-primary underline font-semibold"
              >
                {product.user.username}
              </Link>
            </div>
          </h1>
        </header>
        <p className="text-gray-700">{product.description}</p>
        <div className="flex items-center justify-start my-1">
          <p className="flex items-center justify-start text-4xl mr-4">
            <span className="mr-1">$</span>
            <span className="text-[47%]">{product.price}</span>
          </p>
          <p className="flex items-center justify-start text-primary mr-4">
            <span className="mr-1">
              <Sailboat size={16} />
            </span>
            <span>Free shipping</span>
          </p>
          <p className="flex items-center justify-start text-primary">
            <span className="mr-1">
              <Radius size={16} />
            </span>
            <span>Free returns</span>
          </p>
        </div>
        <p
          className={`font-semibold ${
            stock_quantity < 4 ? " text-red-600" : "text-green-600"
          }`}
        >
          <span>{stock_quantity}</span> left in stock
        </p>
        <AddToCart stock_quantity={stock_quantity} price={product.price} />
      </section>
    </div>
  );
};

export default Product;

"use client";

import { IFullProduct } from "@/interfaces/product";
import { Egg, Radius, Sailboat, Users } from "lucide-react";
import Image from "next/image";
import Link from "next/link";
import { useState } from "react";
import AddToCart from "./add-to-cart";
import { Button } from "@/components/ui/button";
import toast from "react-hot-toast";
import { useOjaDB } from "@/hooks/useOjaDB";
import { useAuthStore } from "@/store/useAuth";

const Product = ({ product }: { product: IFullProduct }) => {
  const { user } = useAuthStore();
  const { ojaInstance } = useOjaDB();
  const { stock_quantity } = product;

  const [watchlist, setWatchlist] = useState({
    total: product.watchers.length,
    isUserWatching: product.watchers.some((w) => w.id === user?.id),
  });

  const addOrRemoveFromWatchList = async () => {
    const { isUserWatching } = watchlist;
    try {
      toast.loading(
        isUserWatching ? "Removing from watchlist" : "Adding to watchlist",
        {
          id: "updating-user-watchlist",
        },
      );

      await ojaInstance[watchlist.isUserWatching ? "delete" : "post"](
        `/products/${product.id}/watchlist`,
      );

      toast.success(
        `${
          watchlist.isUserWatching ? "Removed from" : "Added to"
        } watchlist...`,
        {
          id: "updating-user-watchlist",
        },
      );

      setWatchlist((prev) => {
        return {
          total: prev.total + (prev.isUserWatching ? -1 : 1),
          isUserWatching: !prev.isUserWatching,
        };
      });
    } catch (error) {
      toast.error("Something went wrong", {
        id: "updating-user-watchlist",
      });
    }
  };

  return (
    <div className="sm:grid grid-cols-[2fr_2fr] gap-4 lg:grid-cols-[2fr_5fr] lg:gap-8">
      <section className="">
        <figure className="flex items-center justify-center overflow-hidden mb-3 rounded-md cardboard p-8 sm:h-full">
          <Image
            className="w-full object-contain rounded-md overflow-hidden"
            src={product.images[0]}
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
        <div className="flex items-center justify-start">
          <p
            className={`font-semibold mr-4 ${
              stock_quantity < 4 ? " text-red-600" : "text-green-600"
            }`}
          >
            <span>{stock_quantity}</span> left in stock
          </p>
          <p className="flex items-center justify-start text-primary">
            <Users size={16} className="mr-2" />
            <span>
              {watchlist.total} {watchlist.total === 1 ? "user" : "users"}{" "}
              watching
            </span>
          </p>
        </div>
        <AddToCart product={product} />
        {/* TODO: CONVERT TO SERVER ACTION */}
        <Button
          type="button"
          className="mt-4 w-full max-w-max flex items-center justify-start"
          variant="secondary"
          onClick={() =>
            user
              ? addOrRemoveFromWatchList()
              : toast.error("Please login to add to watch product", {
                  id: `add-to-watchlist-${product.id}`,
                })
          }
        >
          <Egg size={16} className="mr-2" />
          <span>
            {watchlist.isUserWatching
              ? "Remove from watchlist"
              : "Add to watchlist"}
          </span>
        </Button>
      </section>
    </div>
  );
};

export default Product;

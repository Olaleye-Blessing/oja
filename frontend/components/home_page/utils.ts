import { IProduct } from "@/interfaces/product";
import { API_URL } from "@/utils/constant";
import { getError } from "@/utils/get-error";
import axios from "axios";
import { ProductsFilter } from "./types";

export const getProducts = async (search: ProductsFilter) => {
  try {
    const { data: products } = await axios.get<IProduct[]>(
      `${API_URL}/products?${new URLSearchParams(search as any).toString()}`,
    );

    return products;
  } catch (error) {
    throw getError(error);
  }
};

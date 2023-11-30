import { IProduct } from "@/interfaces/product";
import { API_URL } from "@/utils/constant";
import { getError } from "@/utils/get-error";
import axios from "axios";

export const getProducts = async () => {
  try {
    const { data: products } = await axios.get<IProduct[]>(
      `${API_URL}/products`,
    );

    return products;
  } catch (error) {
    throw getError(error);
  }
};

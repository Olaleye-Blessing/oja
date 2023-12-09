import axios from "axios";
import { API_URL } from "@/utils/constant";

export const useOjaDB = () => {
  let ojaInstance = axios.create({
    baseURL: API_URL,
    headers: {
      "Content-Type": "application/json",
      Accept: "application/json",
    },
    withCredentials: true,
  });

  return { ojaInstance };
};

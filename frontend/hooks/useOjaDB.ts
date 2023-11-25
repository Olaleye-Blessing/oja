import axios from "axios";
import { useAuthStore } from "@/store/useAuth";
import { API_URL } from "@/utils/constant";

export const useOjaDB = () => {
  const token = useAuthStore((state) => state.token);

  let ojaInstance = axios.create({
    baseURL: API_URL,
    headers: {
      "Content-Type": "application/json",
      Accept: "application/json",
    },
  });

  if (!token) return { ojaInstance };

  const { access_token } = token;

  ojaInstance.defaults.headers.common["Authorization"] =
    `Bearer ${access_token}`;

  return { ojaInstance };
};

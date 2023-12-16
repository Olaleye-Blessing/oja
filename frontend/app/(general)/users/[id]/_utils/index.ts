import { AxiosInstance } from "axios";
import { API_URL } from "@/utils/constant";
import { getError } from "@/utils/get-error";
import { IProfile } from "@/interfaces/profile";

export const getUser = async (ojaInstance: AxiosInstance, id: string) => {
  try {
    const { data: user } = await ojaInstance.get<IProfile>(
      `${API_URL}/profiles/${id}`,
    );

    return user;
  } catch (error) {
    let message = getError(error);

    throw message;
  }
};

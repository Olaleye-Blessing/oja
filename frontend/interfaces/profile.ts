import { UserType } from "@/store/useAuth";
import { IProduct } from "./product";

export interface IProfile extends UserType {
  products: IProduct[];
  watched_products?: IProduct[];
}

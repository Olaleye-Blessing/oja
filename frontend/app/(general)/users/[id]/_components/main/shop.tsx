import { TabsContent } from "@/components/ui/tabs";
import { IProfile } from "@/interfaces/profile";
import ShopProduct from "./shop-product";

export interface ShopProps {
  user: IProfile;
}

const Shop = ({ user: { products } }: ShopProps) => {
  return (
    <TabsContent value="shop">
      {products.length === 0 ? (
        <p>No products available</p>
      ) : (
        <ul className="grid grid-cols-1 gap-4 sm:grid-cols-[repeat(auto-fit,minmax(18rem,1fr))]">
          {products.map((product) => (
            <ShopProduct key={product.id} {...product} />
          ))}
        </ul>
      )}
    </TabsContent>
  );
};

export default Shop;

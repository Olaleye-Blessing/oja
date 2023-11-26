import { useOjaQuery } from "@/hooks/useOjaQuery";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import { API_URL } from "@/utils/constant";
import { SelectProps } from "@radix-ui/react-select";
import { sortObjectArray } from "@/utils/sort";

interface Category {
  id: number;
  name: string;
}

interface CategoriesProps extends SelectProps {}

const Categories = ({ ...select }: CategoriesProps) => {
  const { data, isLoading, error, refetch } = useOjaQuery<Category[]>({
    url: `${API_URL}/products/categories`,
    options: {
      queryKey: ["products", "categories"],
    },
  });

  let categories: Category[] | undefined;

  if (data) {
    categories = sortObjectArray<Category>(data, "name");
  }

  return (
    <Select {...select}>
      <SelectTrigger className="w-full" disabled={isLoading}>
        <SelectValue placeholder={isLoading ? "Loading..." : "Categories"} />
      </SelectTrigger>
      {!isLoading && (
        <SelectContent>
          {categories ? (
            <>
              {categories.map((category) => {
                return (
                  <SelectItem key={category.id} value={String(category.id)}>
                    {category.name}
                  </SelectItem>
                );
              })}
            </>
          ) : (
            <SelectItem value="null">{error}</SelectItem>
          )}
        </SelectContent>
      )}
      {error && (
        <button
          type="button"
          className="text-primary text-sm"
          onClick={() => refetch()}
        >
          Refetch
        </button>
      )}
    </Select>
  );
};

export default Categories;

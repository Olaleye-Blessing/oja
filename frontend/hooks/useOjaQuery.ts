import { UseQueryOptions, useQuery } from "@tanstack/react-query";
import { useOjaDB } from "./useOjaDB";
import { getError } from "@/utils/get-error";

export function useOjaQuery<TData = any, TError = any>({
  url,
  options,
}: {
  url: string;
  options: UseQueryOptions<TData, TError>;
}) {
  const { ojaInstance } = useOjaDB();

  return useQuery({
    ...options,
    queryFn:
      // this is useful for testing
      options.queryFn ??
      (async ({ signal }) => {
        try {
          let { data } = await ojaInstance.get(url, { signal });

          return data;
        } catch (error) {
          throw getError(error);
        }
      }),
  });
}

export interface PageProps<Search = {}> {
  params: { id: string };
  searchParams: Search;
}

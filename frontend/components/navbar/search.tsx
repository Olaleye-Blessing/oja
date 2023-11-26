import React from "react";
import { Input } from "../ui/input";

const Search = () => {
  return (
    <form aria-label="search">
      <Input name="search" placeholder="Search" type="search" />
    </form>
  );
};

export default Search;

import Image from "next/image";
import React from "react";
import ListItem from "./list-item";

import ListActions from "./list-actions";
import { IProfile } from "@/interfaces/profile";

const bgUrl = "https://i.ebayimg.com/images/g/KVMAAOSwZetXOa3L/s-l1600.webp";
const avatarImgUrl =
  "https://i.ebayimg.com/images/g/2rMAAOSwvhtXOa3b/s-l140.webp";

interface HeaderProps {
  user: IProfile;
}

const Header = ({ user }: HeaderProps) => {
  return (
    <header className="w-full">
      <figure
        className="w-full h-56 flex items-center justify-center mx-auto bg-orange-700 bg-no-repeat bg-center bg-cover"
        style={{
          backgroundImage: `url(${bgUrl})`,
        }}
      />

      <section className="grid cardboard grid-cols-[auto_3fr] p-4 my-4">
        <div className="flex items-center justify-center col-start-1 col-end-2 row-start-1 row-end-3 mr-1">
          <figure className="flex items-center justify-center rounded-full w-[96px] h-[96px] overflow-hidden cardboard">
            <Image
              src={avatarImgUrl}
              alt=""
              width={200}
              height={50}
              className="w-full"
            />
          </figure>
        </div>
        <div className="flex items-end justify-start">
          <h1 className="col-start-2 row-start-1 row-end-2 text-2xl mb-0">
            {user.username}
          </h1>
        </div>
        <div className="col-start-2 row-start-2 row-end-3 md:flex md:items-center md:justify-between">
          <ul>
            <ListItem value="187k" label="items sold" />
          </ul>
          <ListActions />
        </div>
      </section>
    </header>
  );
};

export default Header;

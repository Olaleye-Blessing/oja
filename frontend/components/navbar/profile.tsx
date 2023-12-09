import { LogOut } from "lucide-react";
import Link from "next/link";
import { UserType } from "@/store/useAuth";
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuLabel,
  DropdownMenuSeparator,
  DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu";

interface ProfileProps {
  user: UserType;
}

const Profile = ({ user }: ProfileProps) => {
  return (
    <DropdownMenu>
      <DropdownMenuTrigger className="uppercase flex items-center justify-center rounded-full w-8 h-8 border font-semibold">
        {user.username[0]}
      </DropdownMenuTrigger>
      <DropdownMenuContent className="mr-4 mt-1">
        <DropdownMenuLabel>My Account</DropdownMenuLabel>
        <DropdownMenuSeparator />
        <DropdownMenuItem>
          <Link href={`/users/${user.id}`}>Profile</Link>
        </DropdownMenuItem>
        <DropdownMenuSeparator />
        <DropdownMenuItem asChild>
          <button className="flex items-center justify-start w-full">
            <LogOut size={16} />
            <span className="ml-2">Logout</span>
          </button>
        </DropdownMenuItem>
      </DropdownMenuContent>
    </DropdownMenu>
  );
};

export default Profile;

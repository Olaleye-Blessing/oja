import { useRouter } from "next/navigation";
import { LogOut } from "lucide-react";
import Link from "next/link";
import { UserType, useAuthStore } from "@/store/useAuth";
import axios from "axios";
import toast from "react-hot-toast";
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuLabel,
  DropdownMenuSeparator,
  DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu";
import { API_URL } from "@/utils/constant";
import { getError } from "@/utils/get-error";

interface ProfileProps {
  user: UserType;
}

const Profile = ({ user }: ProfileProps) => {
  const router = useRouter();
  const logout = useAuthStore((state) => state.logout);

  const handleLogout = async () => {
    try {
      toast.loading("Logging out...", {
        id: "logout",
        position: "top-right",
      });
      await axios.delete(`${API_URL}/auth/logout`, {
        withCredentials: true,
      });

      logout();
      router.refresh();
    } catch (error) {
      toast.error(getError(error), { id: "logout" });
    }
  };

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
          <button
            className="flex items-center justify-start w-full"
            type="button"
            onClick={handleLogout}
          >
            <LogOut size={16} />
            <span className="ml-2">Logout</span>
          </button>
        </DropdownMenuItem>
      </DropdownMenuContent>
    </DropdownMenu>
  );
};

export default Profile;

import { create } from "zustand";
import { devtools, persist } from "zustand/middleware";
import { immer } from "zustand/middleware/immer";

export interface UserType {
  id: number;
  username: string;
  inserted_at: string;
  updated_at: string;
  email: string;
}

export interface TokenType {
  access_token: string;
  refresh_token: string;
}

interface State {
  user: UserType | null;
}

interface Actions {
  login: (user: UserType) => void;
  logout: () => void;
}

type Store = State & Actions;

export const useAuthStore = create<Store>()(
  devtools(
    immer(
      persist(
        (set) => ({
          user: null,
          token: null,
          login: (user) => {
            set(() => ({ user }));
          },
          logout: () => {
            set(() => ({ user: null }));
          },
        }),
        { name: "auth" },
      ),
    ),
  ),
);

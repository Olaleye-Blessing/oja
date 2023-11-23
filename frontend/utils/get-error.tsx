import { AxiosError, isAxiosError } from "axios";

export const getError = (error: unknown) => {
  const _error = error as Error | AxiosError;
  let message = "Something went wrong";
  console.log(error);

  if (isAxiosError(_error)) {
    message = _error.response?.data.message || _error.message;
  } else if (_error instanceof Error) {
    message = _error.message;
  }

  return message;
};

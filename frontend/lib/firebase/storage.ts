import { ref, uploadBytesResumable, getDownloadURL } from "firebase/storage";
import { storage } from "./firebase";

export const uploadImage = async (file: File, folder: string) => {
  const filePath = `images/${folder}/${file.name}`;
  const storageRef = ref(storage, filePath);

  const uploadTask = await uploadBytesResumable(storageRef, file);
  const downloadURL = await getDownloadURL(uploadTask.ref);

  return downloadURL;
};

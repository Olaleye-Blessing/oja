import { TabsContent } from "@/components/ui/tabs";
import Password from "./password";
import Contact from "./contact";
import Location from "./location";
import Socials from "./socials";

const Settings = () => {
  return (
    <TabsContent value="settings" className="grid gap-6 sm:grid-cols-2">
      <Password />
      <Contact />
      <Location />
      <Socials />
    </TabsContent>
  );
};

export default Settings;

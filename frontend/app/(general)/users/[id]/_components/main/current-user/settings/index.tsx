import { TabsContent } from "@/components/ui/tabs";
import Password from "./password";

const Settings = () => {
  return (
    <TabsContent value="settings">
      <Password />
    </TabsContent>
  );
};

export default Settings;

import { Label } from "@/components/ui/label";
import Container from "../container";
import { Input } from "@/components/ui/input";
import Form from "./form";

const Socials = () => {
  return (
    <Container className="cardboard" title="Socials">
      <Form id="socials">
        <div className="mb-4">
          <Label htmlFor="tiktok">TikTok</Label>
          <Input
            id="tiktok"
            name="tiktok"
            placeholder="https://www.tiktok.com/@_jongbo"
            type="url"
          />
        </div>
        <div className="mb-4">
          <Label htmlFor="twitter">Twitter</Label>
          <Input
            id="twitter"
            name="twitter"
            placeholder="https://twitter.com/_jongbo"
            type="url"
          />
        </div>
        <div className="mb-4">
          <Label htmlFor="instagram">Instagram</Label>
          <Input
            id="instagram"
            name="instagram"
            placeholder="https://www.instagram.com/__jongbo"
            type="url"
          />
        </div>
      </Form>
    </Container>
  );
};

export default Socials;

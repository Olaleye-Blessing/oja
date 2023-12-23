"use client";

import { TabsContent } from "@/components/ui/tabs";
import { IProfile } from "@/interfaces/profile";
import Container from "./current-user/container";
import { ReactNode } from "react";
import { useAuthStore } from "@/store/useAuth";

export interface AboutProps {
  user: IProfile;
}

const About = ({ user }: AboutProps) => {
  const loggedInUser = useAuthStore((state) => state.user);
  const _user = loggedInUser?.id === user.id ? loggedInUser : user;

  return (
    <TabsContent value="about" className="space-y-4">
      <Container title="About Us">
        <Paragraph label="Member Since" value={_user.inserted_at} />
        <Paragraph label="Bio" value={_user.bio} />
      </Container>
      <Container title="Location">
        <Paragraph label="Country" value={_user.country} />
        <Paragraph label="State" value={_user.state} />
        <Paragraph label="City" value={_user.city} />
      </Container>
      <Container title="Contact">
        <Paragraph
          label="Website"
          value={<ParaLink href={_user.website} className="text-primary" />}
        />
        <Paragraph label="Phone number" value={_user.phone_number} />
      </Container>
      <Container title="Socials">
        <Paragraph
          label="TikTok"
          value={<ParaLink href={_user.tiktok} className="text-[#ff0050]" />}
        />
        <Paragraph
          label="Twitter"
          value={<ParaLink href={_user.twitter} className="text-[#1da1f2]" />}
        />
        <Paragraph
          label="Instagram"
          value={
            <ParaLink
              href={_user.instagram}
              className="text-[#405de6] hover:text-[#833ab4]"
            />
          }
        />
      </Container>
    </TabsContent>
  );
};

interface ParagraphProps {
  label: ReactNode;
  value: ReactNode;
}

const Paragraph = ({ label, value }: ParagraphProps) => {
  return (
    <p>
      <span className="font-semibold mr-2">{label}:</span>
      <span>{value || "-"}</span>
    </p>
  );
};

interface ParaLinkProps {
  href: string;
  className?: string;
}

const ParaLink = ({ href, className }: ParaLinkProps) => {
  if (!href) return <>-</>;

  return (
    <a
      href={href}
      target="_blank"
      rel="noopener"
      className={`${className} hover:text-opacity-80`}
    >
      {href}
    </a>
  );
};

export default About;

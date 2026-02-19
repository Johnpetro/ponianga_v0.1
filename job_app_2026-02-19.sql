--
-- PostgreSQL database dump
--

\restrict 0jyC5N6C9V0iPJfVhDP64aIstRRPnygJX31sK0dA5f1LOYXkmhT2pvFtiSplhE5

-- Dumped from database version 17.7 (Ubuntu 17.7-0ubuntu0.25.04.1)
-- Dumped by pg_dump version 17.7 (Ubuntu 17.7-0ubuntu0.25.04.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO postgres;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS '';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: _prisma_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public._prisma_migrations (
    id character varying(36) NOT NULL,
    checksum character varying(64) NOT NULL,
    finished_at timestamp with time zone,
    migration_name character varying(255) NOT NULL,
    logs text,
    rolled_back_at timestamp with time zone,
    started_at timestamp with time zone DEFAULT now() NOT NULL,
    applied_steps_count integer DEFAULT 0 NOT NULL
);


ALTER TABLE public._prisma_migrations OWNER TO postgres;

--
-- Name: admins; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.admins (
    id integer NOT NULL,
    full_name character varying(100) NOT NULL,
    email character varying(100) NOT NULL,
    password character varying(255) NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    bio text DEFAULT ''::text NOT NULL,
    phone character varying(20) DEFAULT ''::character varying NOT NULL,
    profile character varying(500) DEFAULT ''::character varying NOT NULL,
    "updatedAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.admins OWNER TO postgres;

--
-- Name: admins_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.admins_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.admins_id_seq OWNER TO postgres;

--
-- Name: admins_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.admins_id_seq OWNED BY public.admins.id;


--
-- Name: applications; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.applications (
    id integer NOT NULL,
    "jobId" integer NOT NULL,
    "firstName" character varying(100) NOT NULL,
    "lastName" character varying(100) NOT NULL,
    email character varying(255) NOT NULL,
    phone character varying(20) NOT NULL,
    address character varying(500) NOT NULL,
    "currentPosition" character varying(255) NOT NULL,
    experience character varying(50) NOT NULL,
    "expectedSalary" character varying(100) NOT NULL,
    "availableFrom" timestamp(3) without time zone NOT NULL,
    degree character varying(255) NOT NULL,
    university character varying(255) NOT NULL,
    "graduationYear" character varying(4) NOT NULL,
    gpa character varying(10) NOT NULL,
    skills text NOT NULL,
    "coverLetter" text NOT NULL,
    resume character varying(500) NOT NULL,
    portfolio character varying(500) NOT NULL,
    agreement boolean DEFAULT false NOT NULL,
    status character varying(50) DEFAULT 'Pending'::character varying NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public.applications OWNER TO postgres;

--
-- Name: applications_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.applications_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.applications_id_seq OWNER TO postgres;

--
-- Name: applications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.applications_id_seq OWNED BY public.applications.id;


--
-- Name: contacts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.contacts (
    id integer NOT NULL,
    inquiry_type character varying(100) NOT NULL,
    full_name character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    phone character varying(20) NOT NULL,
    subject character varying(255) NOT NULL,
    message text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.contacts OWNER TO postgres;

--
-- Name: contacts_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.contacts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.contacts_id_seq OWNER TO postgres;

--
-- Name: contacts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.contacts_id_seq OWNED BY public.contacts.id;


--
-- Name: jobs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.jobs (
    id integer NOT NULL,
    "jobTitle" character varying(255) NOT NULL,
    employer character varying(255) NOT NULL,
    "jobType" character varying(100) NOT NULL,
    location character varying(255) NOT NULL,
    deadline timestamp(3) without time zone NOT NULL,
    applicants integer DEFAULT 0 NOT NULL,
    salary character varying(100) NOT NULL,
    skills text NOT NULL,
    description text NOT NULL,
    status character varying(50) DEFAULT 'Active'::character varying NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    image character varying(500)
);


ALTER TABLE public.jobs OWNER TO postgres;

--
-- Name: jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.jobs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.jobs_id_seq OWNER TO postgres;

--
-- Name: jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.jobs_id_seq OWNED BY public.jobs.id;


--
-- Name: scholarship_applications; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.scholarship_applications (
    id integer NOT NULL,
    "scholarshipId" integer NOT NULL,
    "firstName" character varying(100) NOT NULL,
    "lastName" character varying(100) NOT NULL,
    email character varying(255) NOT NULL,
    phone character varying(20) NOT NULL,
    address character varying(500) NOT NULL,
    passport character varying(500) NOT NULL,
    status character varying(50) DEFAULT 'Pending'::character varying NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public.scholarship_applications OWNER TO postgres;

--
-- Name: scholarship_applications_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.scholarship_applications_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.scholarship_applications_id_seq OWNER TO postgres;

--
-- Name: scholarship_applications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.scholarship_applications_id_seq OWNED BY public.scholarship_applications.id;


--
-- Name: scholarships; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.scholarships (
    id integer NOT NULL,
    vacancy character varying(255) NOT NULL,
    "collegeName" character varying(255) NOT NULL,
    "programName" character varying(255) NOT NULL,
    sponsorship character varying(100) NOT NULL,
    deadline timestamp(3) without time zone NOT NULL,
    description text NOT NULL,
    requirements text NOT NULL,
    status character varying(50) DEFAULT 'Active'::character varying NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    image character varying(500)
);


ALTER TABLE public.scholarships OWNER TO postgres;

--
-- Name: scholarships_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.scholarships_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.scholarships_id_seq OWNER TO postgres;

--
-- Name: scholarships_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.scholarships_id_seq OWNED BY public.scholarships.id;


--
-- Name: team_members; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.team_members (
    id integer NOT NULL,
    full_name character varying(255) NOT NULL,
    bio text NOT NULL,
    "position" character varying(255) NOT NULL,
    profile character varying(500) NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public.team_members OWNER TO postgres;

--
-- Name: team_members_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.team_members_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.team_members_id_seq OWNER TO postgres;

--
-- Name: team_members_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.team_members_id_seq OWNED BY public.team_members.id;


--
-- Name: visitors; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.visitors (
    id integer NOT NULL,
    "ipAddress" character varying(45) NOT NULL,
    "userAgent" character varying(500),
    page character varying(255) NOT NULL,
    referrer character varying(500),
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.visitors OWNER TO postgres;

--
-- Name: visitors_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.visitors_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.visitors_id_seq OWNER TO postgres;

--
-- Name: visitors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.visitors_id_seq OWNED BY public.visitors.id;


--
-- Name: admins id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admins ALTER COLUMN id SET DEFAULT nextval('public.admins_id_seq'::regclass);


--
-- Name: applications id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.applications ALTER COLUMN id SET DEFAULT nextval('public.applications_id_seq'::regclass);


--
-- Name: contacts id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contacts ALTER COLUMN id SET DEFAULT nextval('public.contacts_id_seq'::regclass);


--
-- Name: jobs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jobs ALTER COLUMN id SET DEFAULT nextval('public.jobs_id_seq'::regclass);


--
-- Name: scholarship_applications id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scholarship_applications ALTER COLUMN id SET DEFAULT nextval('public.scholarship_applications_id_seq'::regclass);


--
-- Name: scholarships id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scholarships ALTER COLUMN id SET DEFAULT nextval('public.scholarships_id_seq'::regclass);


--
-- Name: team_members id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.team_members ALTER COLUMN id SET DEFAULT nextval('public.team_members_id_seq'::regclass);


--
-- Name: visitors id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.visitors ALTER COLUMN id SET DEFAULT nextval('public.visitors_id_seq'::regclass);


--
-- Data for Name: _prisma_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) FROM stdin;
8a0db176-6c8e-4cdd-a540-03f915c6feb2	52bbe51c29975f4b3a4a2752fc211d8dbab5cce8763bd7824d4fd04d26c71dad	2025-11-16 19:15:16.509489+00	20251116100817_add_scholarship_applications	\N	\N	2025-11-16 19:15:16.475467+00	1
81be91a1-ead9-4505-9ac5-d9999aeef9e6	dfe3d42bbf048ce85b4ca78c34253e78aa05a2ee77504cca8b647bb18372662a	2025-11-16 19:15:16.523894+00	20251116124851_add_admin_profile	\N	\N	2025-11-16 19:15:16.511802+00	1
8337b1b8-f01e-4758-85bb-ad1af75caf78	12d31e186cc4f3810e0debc2ba9ac61307cbb8e68db78ff3c55aa63a0e17953e	2025-11-22 23:22:27.153849+00	20251121194159_add_job_image_field	\N	\N	2025-11-22 23:22:27.14383+00	1
89d12fe7-b5f5-4b65-b9c3-d3499ff9aa88	02dc0a0bcaf9a0489751d8f608eda59442ae1f1f0be79b385e0b85f5135a44a9	2025-11-22 23:22:27.163418+00	20251121200134_add_scholarship_image_field	\N	\N	2025-11-22 23:22:27.155722+00	1
f8fc2029-3277-4c2b-a225-3d80573e880a	06e2988449a2fa70a6df8b905af49c671f773876f1ba0e98d290bb98ecfe4d82	2025-11-22 23:22:27.180331+00	20251121205515_add_visitor_tracking	\N	\N	2025-11-22 23:22:27.165783+00	1
\.


--
-- Data for Name: admins; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.admins (id, full_name, email, password, "createdAt", bio, phone, profile, "updatedAt") FROM stdin;
1	Admin User	admin@example.com	$2b$10$s7tlUuT0V5IzxIaWNHHlIO7D3c/WtXMlo/EJKnVoArNvMIQF762a.	2025-11-16 19:16:37.245			/uploads/admin-profiles/admin-1763854666639-595747133.png	2025-11-22 23:37:46.647
\.


--
-- Data for Name: applications; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.applications (id, "jobId", "firstName", "lastName", email, phone, address, "currentPosition", experience, "expectedSalary", "availableFrom", degree, university, "graduationYear", gpa, skills, "coverLetter", resume, portfolio, agreement, status, "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: contacts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.contacts (id, inquiry_type, full_name, email, phone, subject, message, "createdAt") FROM stdin;
30	partnership	Joanna Riggs	joannariggs278@gmail.com	911548010	Video Promotion for your website	Hi,\r\n\r\nI just visited poniaganetworking.com and wondered if you've ever considered an impactful video to advertise your business? Our videos can generate impressive results on both your website and across social media.\r\n\r\nOur videos cost just $195 (USD) for a 30 second video ($239 for 60 seconds) and include a full script, voice-over and video.\r\n\r\nI can show you some previous videos we've done if you want me to send some over. Let me know if you're interested in seeing samples of our previous work.\r\n\r\nRegards,\r\nJoanna\r\n\r\nUnsubscribe: https://unsubscribe.video/unsubscribe.php?d=poniaganetworking.com	2025-12-14 13:03:51.395
31	partnership	Joanna Riggs	joannariggs278@gmail.com	8286975880	Explainer Video for your website	Hi,\r\n\r\nI just visited poniaganetworking.com and wondered if you'd ever thought about having an engaging video to explain what you do?\r\n\r\nOur prices start from just $195 (USD).\r\n\r\nLet me know if you're interested in seeing samples of our previous work.\r\n\r\nRegards,\r\nJoanna\r\n\r\nUnsubscribe: https://unsubscribe.video/unsubscribe.php?d=poniaganetworking.com	2025-12-14 15:16:50.478
32	general	Lucy Johnson	lucyjohnson.web@gmail.com	1201201200	Re: Improve your website traffic and SEO	Hi,\r\n\r\nponiaganetworking.com\r\n\r\nI visited your website online and discovered that it was not showing up in any search results for the majority of keywords related to your company on Google, Yahoo, or Bing.\r\n\r\nDo you want more targeted visitors on your website? We can place your website on Google’s 1st Page. yahoo, AOL, Bing. Etc.\r\n\r\nIf interested, kindly provide me your name, phone number, and email.\r\n\r\nRegards,\r\nLucy Johnson\r\n\r\n\r\n\r\nNote: Web platform expertise across Squarespace, Shopify, Wix, WordPress, GoDaddy etc.	2025-12-16 10:56:08.775
33	application_support	Lucy Johnson	lucyjohnson.web@gmail.com	1201201200	Re: Improve your website traffic and SEO	Hi,\r\n\r\nponiaganetworking.com\r\n\r\nI visited your website online and discovered that it was not showing up in any search results for the majority of keywords related to your company on Google, Yahoo, or Bing.\r\n\r\nDo you want more targeted visitors on your website? We can place your website on Google’s 1st Page. yahoo, AOL, Bing. Etc.\r\n\r\nIf interested, kindly provide me your name, phone number, and email.\r\n\r\nRegards,\r\nLucy Johnson\r\n\r\n\r\n\r\nNote: Skilled across major platforms including Squarespace, Shopify, Wix, WordPress, GoDaddy etc.	2025-12-16 11:07:23.867
34	job_inquiry	Kate Armstrong	katearmstrong1976@gmail.com	7034499068	YouTube Promotion: 400+ new subscribers each month	Hi there,\r\n\r\nWe run a Youtube growth service, where we can increase your subscriber count safely and practically. \r\n\r\n- Guaranteed: We guarantee to gain you 400+ new subscribers each month.\r\n- Real, human subscribers who subscribe because they are interested in your channel/videos.\r\n- Safe: All actions are done, without using any automated tasks / bots.\r\n\r\nIf you are interested then we can discuss further.\r\n\r\nKind Regards,\r\nKate	2025-12-20 12:39:40.054
35	partnership	Gemma Marshall	gemma.marshall112@gmail.com	7707113846	Scaling poniaganetworking.com IG	Hi,\r\n\r\nWe run a hands-on agency that helps clients' Instagram accounts build authority and reach new audiences. Rather than just "adding numbers," we focus on tangible benefits:\r\n\r\n1. Cheaper than Ads: We deliver targeted eyes on your profile for a fraction of the cost of running Instagram Ads.\r\n2. Real Community: We target users genuinely interested in your niche, leading to higher engagement and potential sales.\r\n3. 100% Account Safety: We don't use bots. Our team performs every action manually on actual smartphones, keeping your account secure.\r\n4. Consistent Results: Expect 300+ new, high-quality followers every month who actually stick around.\r\n\r\nI'd be happy to forward you some further information if that would be of interest?\r\n\r\nKind Regards,\r\nGemma\r\n\r\nP.S. If you don't have a profile yet, we can handle the full setup and optimization for you.\r\n\r\nhttps://unsubscribe.social/unsubscribe.php?d=poniaganetworking.com	2025-12-22 05:38:12.454
36	general	Raymondinnow	no.reply.EdwardVisser@gmail.com	85538115133	An innovative method of email distribution.	Good day! poniaganetworking.com \r\n \r\nDid you know that it is possible to send commercial offer legally and completely? \r\nWhen such requests are sent, no personal data is used and messages are securely routed to forms designed to receive them and any subsequent appeals. Contact Forms messages are usually considered to be important, so they don't tend to be sent to spam. \r\nWe offer you to try our service for free. \r\nYou can benefit from our service of sending up to 50,000 messages. \r\n \r\nThe cost of sending one million messages is $59. \r\n \r\nThis message was automatically generated. \r\n \r\nContact us. \r\nTelegram - https://t.me/FeedbackFormEU \r\nWhatsApp - +375259112693 \r\nWhatsApp  https://wa.me/+375259112693 \r\nWe only use chat for communication.	2025-12-23 00:14:47.268
37	application_support	Kristeen Cuming	cuming.kristeen@googlemail.com	422874880	To the poniaganetworking.com Webmaster.	We improve MOZ  Domain authority 30+ in 25 Days its help to improve google rank, improve your website SEO, and you get traffic from google \r\n\r\nDA - 0 to 30 - (Only $29) -\r\nDA - 0 to 40 - (Only $35) -\r\nDA - 0 to 30 - (Only $99) -\r\nDA - 0 to 30 - (Only $129) -\r\n\r\n\r\n Yes, Limited time !!\r\n\r\n>> 100% Guarantee \r\n>> Improve Ranking \r\n>> White Hat Process \r\n>> Permanent Work\r\n>> 100% Manual Work \r\n>> 0% Spam score increase \r\n\r\n\r\n⚡ From our work your website keyword get rank on google and get organic traffic from google through keywords\r\n\r\nContact now: intrug@gmail.com	2025-12-27 16:31:10.544
59	scholarship_inquiry	Ab Y	letsgetuoptimize@gmail.com	(949) 508-0277	Re: Increase google organic ranking & SEO	Hey team poniaganetworking.com,\r\n\r\nI would like to discuss SEO!\r\n\r\nI can help your website to get on first page of Google and increase the number of leads and sales you are getting from your website.\r\n\r\nMay I send you a quote & price list?\r\n\r\nBests Regards,\r\nAby\r\nBest AI SEO Company\r\nAccounts Manager\r\nwww.letsgetoptimize.com\r\nPhone No: +1 (949) 508-0277	2026-02-18 18:07:28.424
40	general	Mike Jozef Robertson\r\n	info@speed-seo.net	88517613252	Find poniaganetworking.com SEO Issues totally free	Hi, \r\nWorried about hidden SEO issues on your website? Let us help — completely free. \r\nRun a 100% free SEO check and discover the exact problems holding your site back from ranking higher on Google. \r\n \r\nRun Your Free SEO Check Now \r\nhttps://www.speed-seo.net/check-site-seo-score/ \r\n \r\nOr chat with us and our agent will run the report for you: https://www.speed-seo.net/whatsapp-with-us/ \r\n \r\nBest regards, \r\n \r\n \r\nMike Jozef Robertson\r\n \r\nSpeed SEO Digital \r\nEmail: info@speed-seo.net \r\nPhone/WhatsApp: +1 (833) 454-8622	2026-01-03 04:22:01.291
41	general	Mike Oscar Durand\r\n	info@professionalseocleanup.com	87978382979	Fix August Google Spam update ranking problems for free	Hi, \r\nWhile reviewing poniaganetworking.com, we spotted toxic backlinks that could put your site at risk of a Google penalty. Especially that this Google SPAM update had a high impact in ranks. This is an easy and quick fix for you. Totally free of charge. No obligations. \r\n \r\nFix it now: \r\nhttps://www.professionalseocleanup.com/ \r\n \r\nNeed help or questions? Chat here: \r\nhttps://www.professionalseocleanup.com/whatsapp/ \r\n \r\nBest, \r\nMike Oscar Durand\r\n \r\n+1 (855) 221-7591 \r\ninfo@professionalseocleanup.com	2026-01-09 18:23:59.564
42	partnership	Joanna Riggs	joannariggs211@gmail.com	3304378863	Video Promotion for poniaganetworking.com?	Hi,\r\n\r\nI just visited poniaganetworking.com and wondered if you've ever considered an impactful video to advertise your business? Our videos can generate impressive results on both your website and across social media.\r\n\r\nOur prices start from just $195 (USD).\r\n\r\nLet me know if you're interested in seeing samples of our previous work.\r\n\r\nRegards,\r\nJoanna\r\n\r\nUnsubscribe: https://unsubscribe.video/unsubscribe.php?d=poniaganetworking.com	2026-01-12 14:47:58.914
43	general	AndrewTob	no.reply.BerntBertrand@gmail.com	84779419123	Are you searching for a value-for-money and imaginative advertising option?	Good morning! poniaganetworking.com \r\n \r\nDid you know that it is possible to send commercial offer judiciously and legally? \r\nWhen such messages are sent, no personal data is used, and messages are sent to forms specifically designed to receive and process messages and appeals. The significance of messages sent through Communication Forms ensures that they do not end up in spam folders. \r\nGive our service a go – it won’t cost you a thing! \r\nWe shall forward up to 50,000 messages to you. \r\n \r\nThe cost of sending one million messages is $59. \r\n \r\nThis letter is automatically generated. \r\n \r\nContact us. \r\nTelegram - https://t.me/FeedbackFormEU \r\nWhatsApp - +375259112693 \r\nWhatsApp  https://wa.me/+375259112693 \r\nWe only use chat for communication.	2026-01-14 20:55:23.856
44	technical_support	Joanna Riggs	joannariggs211@gmail.com	604412801	Explainer Video for poniaganetworking.com	Hi,\r\n\r\nI just visited poniaganetworking.com and wondered if you'd ever thought about having an engaging video to explain what you do?\r\n\r\nOur prices start from just $195 (USD).\r\n\r\nLet me know if you're interested in seeing samples of our previous work.\r\n\r\nRegards,\r\nJoanna	2026-01-14 23:23:07.553
45	general	Mike Nils Wilson\r\n	info@digital-x-press.com	86815769984	Add AEO to your SEO strategies today !	Hi, \r\nI understand that most website owners have difficulties recognizing that organic ranking growth is a long-term game and a carefully organized regular commitment. \r\n \r\nThe reality is, very few marketers have the dedication to observe the progressive yet significant benefits that can completely boost their search performance. \r\n \r\nWith constant algorithm changes, a stable, long-term strategy including Answer Engine Optimization (AEO) is critical for getting a profitable outcome. \r\n \r\nIf you see this as the best method, work with us! \r\n \r\nExplore Our Monthly SEO Services https://www.digital-x-press.com/unbeatable-seo/ \r\n \r\nTalk to Us on Instant Messaging https://www.digital-x-press.com/whatsapp-us/ \r\n \r\nWe deliver remarkable outcomes for your resources, and you will value choosing us as your growth partner. \r\n \r\nWarm regards, \r\nDigital X SEO Experts \r\nPhone/WhatsApp: +1 (844) 754-1148	2026-01-17 17:01:02.198
46	general	Olivier Gabriel Balzac	duckmenoffice11@gmail.com	87558869241	Please response to this email	Good day, \r\n \r\nMy name is Olivier Gabriel Balzac, a practicing lawyer from France. I previously contacted you regarding a transaction involving 13.5 million Euros, which was left by my late client before his unexpected demise. \r\n \r\nI am reaching out to you once more because, after examining your profile, I am thoroughly convinced that you are capable of managing this transaction effectively alongside me. \r\nIf you are interested, I would like to emphasize that after the transaction, 5% of the funds will be allocated to charitable organizations, while the remaining 95% will be divided equally between us, resulting in 47.5% for each party. \r\nThis transaction is entirely risk-free. Please respond to me at your earliest convenience to receive further details regarding the transaction. \r\nMy email: info@balzacavocate.com Sincerely, I look forward to your prompt response. \r\nBest regards. \r\nOlivier Gabriel Balzac, \r\nAttorney. \r\nPhone: +33 756 850 084 \r\nEmail: info@balzacavocate.com	2026-01-22 23:57:57.183
47	general	Mike Laurent Martinez\r\n	mike@monkeydigital.co	81298836921	Grow Your Website Traffic with Geo-Targeted Social Ads – Only $10 for 10K Visits!	Hi there, \r\n \r\nI wanted to connect with something that could seriously boost your website’s reach. We work with a trusted ad network that allows us to deliver real, country-targeted social ads traffic for just $10 per 10,000 visits. \r\n \r\nThis isn't bot traffic—it’s engaged traffic, tailored to your chosen market and niche. \r\n \r\nWhat you get: \r\n \r\n10,000+ real visitors for just $10 \r\nCountry-specific traffic for any country \r\nScalability available based on your needs \r\nProven to work—we even use this for our SEO clients! \r\n \r\nWant to give it a try? Check out the details here: \r\nhttps://www.monkeydigital.co/product/country-targeted-traffic/ \r\n \r\nOr ask any questions on WhatsApp: \r\nhttps://monkeydigital.co/whatsapp-us/ \r\n \r\nLet's get started today! \r\n \r\nBest, \r\nMike Laurent Martinez\r\n \r\nPhone/whatsapp: +1 (775) 314-7914	2026-01-24 01:25:59.099
48	general	Mike Matheus David\r\n	info@strictlydigital.net	88571442845	Semrush links for poniaganetworking.com	Hi there, \r\n \r\nGetting some bunch of links pointing to poniaganetworking.com might bring no value or harmful results for your business. \r\n \r\nIt really makes no difference the total backlinks you have, what is crucial is the total of search terms those websites are optimized for. \r\n \r\nThat is the critical thing. \r\nNot the fake Moz DA or Domain Rating. \r\nAnyone can manipulate those. \r\nBUT the amount of Google-ranked terms the domains that send backlinks to you have. \r\nThat’s the bottom line. \r\n \r\nGet these quality links point to your website and you will ROCK! \r\n \r\nWe are offering this special offer here: \r\nhttps://www.strictlydigital.net/product/semrush-backlinks/ \r\n \r\nNeed more details, or want to know more, reach out here: \r\nhttps://www.strictlydigital.net/whatsapp-us/ \r\n \r\nBest regards, \r\nMike Matheus David\r\n \r\nstrictlydigital.net \r\nPhone/WhatsApp: +1 (877) 566-3738	2026-01-24 15:31:23.354
60	application_support	Ab Y	letsgetuoptimize@gmail.com	(949) 508-0277	Re: Increase google organic ranking & SEO	Hey team poniaganetworking.com,\r\n\r\nI would like to discuss SEO!\r\n\r\nI can help your website to get on first page of Google and increase the number of leads and sales you are getting from your website.\r\n\r\nMay I send you a quote & price list?\r\n\r\nBests Regards,\r\nAby\r\nBest AI SEO Company\r\nAccounts Manager\r\nwww.letsgetoptimize.com\r\nPhone No: +1 (949) 508-0277	2026-02-18 21:25:56.916
49	technical_support	Joanna Riggs	joannariggs211@gmail.com	6221515046	Explainer Video for poniaganetworking.com?	Hi,\r\n\r\nI just visited poniaganetworking.com and wondered if you'd ever thought about having an engaging video to explain what you do?\r\n\r\nOur videos cost just $195 (USD) for a 30 second video ($239 for 60 seconds) and include a full script, voice-over and video.\r\n\r\nI can show you some previous videos we've done if you want me to send some over. Let me know if you're interested in seeing samples of our previous work.\r\n\r\nRegards,\r\nJoanna\r\n\r\nUnsubscribe: https://unsubscribe.video/unsubscribe.php?d=poniaganetworking.com	2026-01-26 07:26:58.859
50	general	Mike Espen Robertson\r\n	mike@monkeydigital.co	87963817766	Monkey Digital - visibility for AI search & discovery platforms	Hi, \r\n \r\nSearch is changing faster than most businesses realize. \r\n \r\nMore buyers are now discovering products and services through AI-driven platforms — not only traditional search results. This is why we created the AI Rankings SEO Plan at Monkey Digital. \r\n \r\nIt’s designed to help websites become clear, trusted, and discoverable by AI systems that increasingly influence how people find and choose businesses. \r\n \r\nYou can view the plan here: \r\nhttps://www.monkeydigital.co/ai-rankings/ \r\n \r\nIf you’d like to see whether this approach makes sense for your site, feel free to reach out directly — even a quick question is fine. Whatsapp: https://wa.link/b87jor \r\n \r\n \r\n \r\nBest regards, \r\nMike Espen Robertson\r\n \r\nMonkey Digital \r\nmike@monkeydigital.co \r\nPhone/Whatsapp: +1 (775) 314-7914	2026-01-28 21:45:33.835
51	general	RobertCak	mariajesusmateo79@gmail.com	84529418314	Even illness cannot stop a good deed	Through death, the family is not destroyed, it is transformed; a part of it passes into the unseen. We believe that death is an absence, when in fact it is a discreet presence. \r\nI am suffering from a serious illness that will lead to my certain death. \r\nI have €512,000 in my bank account, which I would like to donate. \r\nPlease contact me if you are interested. \r\n \r\nEmail: mariajesusgarciaa86@gmail.com	2026-01-30 23:23:30.351
52	general	Mike Michel Petitson\r\n	info@speed-seo.net	89157941968	Find poniaganetworking.com SEO Issues totally free	Hi, \r\nWorried about hidden SEO issues on your website? Let us help — completely free. \r\nRun a 100% free SEO check and discover the exact problems holding your site back from ranking higher on Google. \r\n \r\nRun Your Free SEO Check Now \r\nhttps://www.speed-seo.net/check-site-seo-score/ \r\n \r\nOr chat with us and our agent will run the report for you: https://www.speed-seo.net/whatsapp-with-us/ \r\n \r\nBest regards, \r\n \r\n \r\nMike Michel Petitson\r\n \r\nSpeed SEO Digital \r\nEmail: info@speed-seo.net \r\nPhone/WhatsApp: +1 (833) 454-8622	2026-01-31 08:44:32.601
53	partnership	Joanna Riggs	joannariggs211@gmail.com	492960723	Video Promotion for your website	Hi,\r\n\r\nI just visited poniaganetworking.com and wondered if you've ever considered an impactful video to advertise your business? Our videos can generate impressive results on both your website and across social media.\r\n\r\nOur videos cost just $195 (USD) for a 30 second video ($239 for 60 seconds) and include a full script, voice-over and video.\r\n\r\nI can show you some previous videos we've done if you want me to send some over. Let me know if you're interested in seeing samples of our previous work.\r\n\r\nRegards,\r\nJoanna\r\n\r\nUnsubscribe: https://unsubscribe.video/unsubscribe.php?d=poniaganetworking.com	2026-01-31 15:35:44.825
54	general	Mike - AI Search Upgrade	upgrade@mail.nomissedlead.com	89629322139	Is your business ready for AI discovery?	The way customers are finding businesses is changing fast. More and more customers are finding businesses directly through AI platforms like ChatGPT. \r\n \r\nIf your website isn't optimized for AI discovery, you will be missing out on consistent new customers. \r\n \r\nWe build a customized upgrade plan built for your business and website that optimizes your discovery and get more customers. \r\n \r\n- Simply email back "YES", and we'll help you. \r\n \r\n- If you aren't interested in upgrading your business for AI search, reply "NO", and we won't reach out to your business. \r\n \r\nMike	2026-02-04 11:59:36.268
55	general	Michalak Aleksandra	aleksandramichalakalek51@gmail.com	82514969564	Loan proposal. Do you need a business loan please contact me	Good day. \r\nMy name is Michalak Aleksandra, a Poland based business consultant. \r\nRunning a business means juggling a million things, and getting the funding you need shouldn't be another hurdle. We've helped businesses to secure debt financing for growth, inventory, or operations, without the typical bank delays. \r\nTogether with our partners (investors), we offer a straightforward, transparent process with clear terms, designed to get you funded quickly so you can focus on your business. \r\nReady to explore our services? Please feel free to contact me directly by michalak.aleksandra@mail.com Let's make your business goals a reality, together. \r\nRegards, \r\nMichalak Aleksandra. \r\nEmail: michalak.aleksandra@mail.com	2026-02-04 20:51:08.798
56	general	Mike Walter Lefevre\r\n	info@professionalseocleanup.com	86358654611	Fix August Google Spam update ranking problems for free	Hi, \r\nWhile reviewing poniaganetworking.com, we spotted toxic backlinks that could put your site at risk of a Google penalty. Especially that this Google SPAM update had a high impact in ranks. This is an easy and quick fix for you. Totally free of charge. No obligations. \r\n \r\nFix it now: \r\nhttps://www.professionalseocleanup.com/ \r\n \r\nNeed help or questions? Chat here: \r\nhttps://www.professionalseocleanup.com/whatsapp/ \r\n \r\nBest, \r\nMike Walter Lefevre\r\n \r\n+1 (855) 221-7591 \r\ninfo@professionalseocleanup.com	2026-02-05 04:06:10.899
57	general	Mike Maximilian Svensson\r\n	info@professionalseocleanup.com	82135546646	Fix August Google Spam update ranking problems for free	Hi, \r\nWhile reviewing poniaganetworking.com, we spotted toxic backlinks that could put your site at risk of a Google penalty. Especially that this Google SPAM update had a high impact in ranks. This is an easy and quick fix for you. Totally free of charge. No obligations. \r\n \r\nFix it now: \r\nhttps://www.professionalseocleanup.com/ \r\n \r\nNeed help or questions? Chat here: \r\nhttps://www.professionalseocleanup.com/whatsapp/ \r\n \r\nBest, \r\nMike Maximilian Svensson\r\n \r\n+1 (855) 221-7591 \r\ninfo@professionalseocleanup.com	2026-02-06 17:33:26.006
58	general	Mike Stian Martinez\r\n	info@digital-x-press.com	89387457594	Add AEO to your SEO strategies today !	Hi, \r\nI recognize that some companies find it challenging grasping that SEO is a long-term game and a carefully organized monthly initiative. \r\n \r\nUnfortunately, very few website owners have the patience to wait for the gradual yet meaningful improvements that can completely change their digital visibility. \r\n \r\nWith regular search engine updates, a stable, long-term strategy including Answer Engine Optimization (AEO) is essential for achieving a profitable outcome. \r\n \r\nIf you agree this as the ideal method, collaborate with us! \r\n \r\nExplore Our Monthly SEO Services https://www.digital-x-press.com/unbeatable-seo/ \r\n \r\nReach Out on Instant Messaging https://www.digital-x-press.com/whatsapp-us/ \r\n \r\nWe offer unbeatable outcomes for your investment, and you will enjoy choosing us as your growth partner. \r\n \r\nKind regards, \r\nDigital X SEO Experts \r\nPhone/WhatsApp: +1 (844) 754-1148	2026-02-13 19:47:00.099
\.


--
-- Data for Name: jobs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.jobs (id, "jobTitle", employer, "jobType", location, deadline, applicants, salary, skills, description, status, "createdAt", "updatedAt", image) FROM stdin;
14	Labour - Construction	Male	Full-time	Doha, Qatar	2025-12-01 00:00:00	10	1800QAR	Physical strength and endurance - Ability to follow instructions - Skilled in using basic hand and power tools - Knowledge of construction safety regulations - Ability to work in a team - Basic mathematical skills for measuring and calculations - Problem-solving skills - Good communication skills	Summary:\r\nWe are looking for a hardworking and skilled Labourer to join our construction team. The Labourer will be responsible for assisting with various tasks on the construction site to ensure projects are completed efficiently and safely.\r\n\r\nJob Responsibility:\r\n1. Assist with loading and unloading construction materials.\r\n2. Operate hand and power tools under supervision.\r\n3. Clean and prepare construction sites by removing debris and hazards.\r\n4. Erect and disassemble temporary structures as needed.\r\n5. Follow instructions from supervisors to perform other duties as assigned.\r\n6. Adhere to all safety regulations and report any unsafe conditions.\r\n\r\nCandidate Requirements:\r\n1. Proven experience as a Labourer in the construction industry.\r\n2. Ability to lift and carry heavy loads.\r\n3. Knowledge of basic construction tools and equipment.\r\n4. Strong work ethic and willingness to learn.\r\n5. Physical stamina and endurance to work in various weather conditions.\r\n6. Valid driver's license may be required.\r\n\r\n\r\n	Active	2025-11-27 20:49:11.438	2025-11-27 20:50:03.999	/uploads/job-images/job-1764276551433-435013635.png
15	MALE FACTORY HELPERS 	Poniaga Networking Enterprices	Full-time	DUBAI	2026-01-30 00:00:00	10	800UAE	Mahitaji:  Elimu ya msingi au sekondari. 2. Uzoefu: Uzoefu wa kazi za viwandani ni plus, lakini si lazima. 3. Umri: Kati ya miaka 18-45. 4. Afya: Uwe na afya njema.  Ujuzi: 1. Ustadi wa Kufanya Kazi kwa Timu: Kufanya kazi na wengine kwa ushirikiano. 2. Ustadi wa Kufata Maelekezo: Kufata na kufuata maagizo kwa ufanisi. 3. Ustadi wa Kufanya Kazi kwa Mkono: Uwezo wa kufanya kazi za mikono kwa ufanisi. 4. Ustadi wa Kutatua Matatizo: Kupata suluhu za haraka na za ufanisi. 5. Usalama Kazini: Kufahamu na kufuata taratibu za usalama.  Ujuzi wa Ziada (Optional): - Uzoefu wa kuendesha mashine za viwandani. - Ujuzi wa kompyuta (kwa baadhi ya majukumu).	- Kufanya kazi za usafi na mpangilio wa vifaa\r\n\r\n- Kusaidia katika utengenezaji na ufungaji wa bidhaa\r\n\r\n- Kudhibiti na kuandaa vifaa au malighafi\r\n\r\n- Kufanya ukaguzi wa ubora wa bidhaa\r\n\r\n- Kusaidia katika matengenezo ya vifaa vya kiwanda\r\n	Active	2026-01-09 13:42:56.468	2026-01-09 13:52:54.465	
16	MALE CLEANERS 	Poniaga Networking Enterprices	Full-time	DUBAI	2026-01-30 00:00:00	7	1200UAE	- Elimu ya msingi. - Uzoefu wa kazi za usafi ni plus. - Uwezo wa kufanya kazi kwa nguvu na kwa muda mrefu. - Ufahamu wa taratibu za usalama na usafi.	- Kusafisha na kuweka safi maeneo ya kazi, vyumba, na vifaa.\r\n- Kuondoa takwaji na kuzitupa kwa njia inayofaa.\r\n- Kufanya kazi za usafi kama vile kufagia, kupiga mswaki, na kufuta vumbi.\r\n- Kusaidia katika kuandaa vifaa na vifaa vya kusafishia.\r\n- Kufanya kazi kwa ushirikiano na timu ya usafi.	Active	2026-01-09 14:07:47.078	2026-01-09 14:07:47.078	
\.


--
-- Data for Name: scholarship_applications; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.scholarship_applications (id, "scholarshipId", "firstName", "lastName", email, phone, address, passport, status, "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: scholarships; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.scholarships (id, vacancy, "collegeName", "programName", sponsorship, deadline, description, requirements, status, "createdAt", "updatedAt", image) FROM stdin;
\.


--
-- Data for Name: team_members; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.team_members (id, full_name, bio, "position", profile, "createdAt", "updatedAt") FROM stdin;
2	Aneth Ally Ngenga	\r\nAneth Ngenga is an  administrator with over three years of experience in office management and coordinating company operations. She is known for her strong organization, reliability, and leadership.	Administrator	/uploads/team-members/member-1764226611030-380465597.jpg	2025-11-27 06:56:51.038	2025-11-27 06:56:51.038
1	Ashley Ally Waziri	She is a manager with over five years of experience in leading teams, supervising operations, and ensuring smooth company performance. She is known for her leadership, problem-solving skills, and commitment to achieving results.	Manager	/uploads/team-members/member-1764227225803-720701847.jpg	2025-11-17 05:26:53.893	2025-11-27 07:07:05.859
3	Joseph Lusako Mwafungo	He is a CEO who leads organizations with a strong strategic vision, effective decision-making, and a commitment to achieving impactful results. She is recognized for her leadership, innovation, and ability to guide teams toward success.	Chief Executive Officer	/uploads/team-members/member-1764228252222-621204302.jpg	2025-11-27 07:24:12.246	2025-11-27 08:09:40.955
\.


--
-- Data for Name: visitors; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.visitors (id, "ipAddress", "userAgent", page, referrer, "createdAt") FROM stdin;
1	::ffff:127.0.0.1	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36	/	\N	2025-11-22 23:24:04.099
2	::ffff:127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.4 Safari/605.1.15 (Applebot/0.1; +http://www.apple.com/go/applebot)	/blog	\N	2025-11-23 00:01:31.22
3	::ffff:139.144.52.241	unknown	/	\N	2025-11-23 00:54:10.987
4	::ffff:3.143.33.63	cypex.ai/scanning Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) Chrome/126.0.0.0 Safari/537.36	/	\N	2025-11-23 02:15:23.07
5	::ffff:66.132.153.127	unknown	/	\N	2025-11-23 05:30:26.327
6	::ffff:206.168.34.214	Mozilla/5.0 (compatible; CensysInspect/1.1; +https://about.censys.io/)	/	\N	2025-11-23 05:57:15.153
7	::ffff:176.65.148.51	unknown	/	\N	2025-11-23 09:14:55.894
8	::ffff:34.76.70.200	python-requests/2.32.5	/	\N	2025-11-23 15:01:22.496
9	::ffff:124.198.132.121	Hello World	/	\N	2025-11-23 22:01:39.821
10	::ffff:127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	/	http://poniaganetworking.com	2025-11-24 00:03:46.154
11	::ffff:111.7.96.159	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	/	\N	2025-11-24 03:33:39.525
12	::ffff:167.94.138.124	unknown	/	\N	2025-11-24 05:27:33.056
13	::ffff:216.180.246.12	'Mozilla/5.0 (compatible; GenomeCrawlerd/1.0; +https://www.nokia.com/genomecrawler)'	/	\N	2025-11-24 05:44:17.252
14	::ffff:3.137.73.221	cypex.ai/scanning Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) Chrome/126.0.0.0 Safari/537.36	/	\N	2025-11-24 06:30:23.217
15	::ffff:152.32.135.214	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36 Edg/120.0.0.0	/	\N	2025-11-24 13:27:04.227
16	::ffff:176.65.148.250	unknown	/	\N	2025-11-24 18:38:05.86
17	::ffff:127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	/	http://poniaganetworking.com	2025-11-25 00:04:00.295
18	::ffff:124.198.132.121	unknown	/	\N	2025-11-25 02:16:37.305
19	::ffff:176.65.148.250	unknown	/	\N	2025-11-25 02:26:07.61
20	::ffff:202.120.234.42	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.0.1 Safari/605.1.15	/	\N	2025-11-25 04:49:10.086
21	::ffff:199.45.154.157	unknown	/	\N	2025-11-25 05:11:51.406
22	::ffff:167.94.138.171	Mozilla/5.0 (compatible; CensysInspect/1.1; +https://about.censys.io/)	/	\N	2025-11-25 05:57:45.011
23	::ffff:34.140.71.81	python-requests/2.32.5	/	\N	2025-11-25 08:02:27.351
24	::ffff:172.234.217.192	Mozilla/5.0 (Macintosh; Intel Mac OS X 13_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36	/	\N	2025-11-25 08:26:11.473
25	::ffff:71.6.167.142	unknown	/	\N	2025-11-25 10:07:55.492
26	::ffff:127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	/	http://poniaganetworking.com	2025-11-26 00:03:45.169
27	::ffff:176.65.148.250	unknown	/	\N	2025-11-26 03:15:59.743
28	::ffff:222.186.13.130	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4 240.111 Safari/537.36	/	\N	2025-11-26 04:34:51.614
29	::ffff:167.94.138.176	unknown	/	\N	2025-11-26 05:14:06.169
30	::ffff:223.243.184.197	unknown	/	\N	2025-11-26 05:58:28.933
31	::ffff:71.6.199.23	unknown	/	\N	2025-11-26 11:04:48.65
32	::ffff:34.79.200.193	python-requests/2.32.5	/	\N	2025-11-26 13:44:19.116
33	::ffff:127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	/	http://poniaganetworking.com	2025-11-27 00:14:02.447
34	::ffff:20.163.33.23	Mozilla/5.0 zgrab/0.x	/	\N	2025-11-27 00:21:43.253
35	::ffff:176.65.148.250	unknown	/	\N	2025-11-27 05:10:10.054
36	::ffff:71.6.158.166	unknown	/	\N	2025-11-27 05:25:37.442
37	::ffff:167.94.138.179	unknown	/	\N	2025-11-27 05:35:42.612
38	::ffff:206.168.34.193	Mozilla/5.0 (compatible; CensysInspect/1.1; +https://about.censys.io/)	/	\N	2025-11-27 06:00:32.261
39	::ffff:123.160.223.74	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	/	\N	2025-11-27 06:35:52.596
40	::ffff:123.160.223.73	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36	/	\N	2025-11-27 06:35:53.835
41	::ffff:123.160.223.72	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	/	\N	2025-11-27 06:35:54.806
42	::ffff:111.7.96.162	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	/	\N	2025-11-27 06:35:55.847
43	::ffff:207.90.244.14	unknown	/	\N	2025-11-27 07:34:24.869
44	::ffff:72.14.178.148	Mozilla/5.0 zgrab/0.x	/	\N	2025-11-27 10:33:10.803
45	::ffff:172.234.231.111	unknown	/	\N	2025-11-27 10:57:54.309
46	::ffff:172.236.228.227	Mozilla/5.0 (Macintosh; Intel Mac OS X 13_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36	/	\N	2025-11-27 11:29:33.52
47	::ffff:34.38.246.252	python-requests/2.32.5	/	\N	2025-11-27 12:49:13.907
48	::ffff:127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	/	http://poniaganetworking.com	2025-11-28 00:08:23.751
49	::ffff:176.65.148.250	unknown	/	\N	2025-11-28 03:54:05.63
50	::ffff:66.132.153.123	unknown	/	\N	2025-11-28 05:25:28.871
51	::ffff:34.77.91.166	python-requests/2.32.5	/	\N	2025-11-28 09:31:23.955
52	::ffff:104.199.26.108	python-requests/2.32.5	/	\N	2025-11-28 11:09:08.025
53	::ffff:44.220.188.226	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36	/	\N	2025-11-28 15:35:53.874
54	::ffff:45.156.129.178	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.113 Safari/537.36	/	\N	2025-11-28 21:02:38.364
55	::ffff:127.0.0.1	Mozilla/5.0 (X11; Linux i686; rv:109.0) Gecko/20100101 Firefox/120.0	/	\N	2025-11-29 00:23:32.336
56	::ffff:194.164.107.5	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36	/	\N	2025-11-29 01:28:46.306
57	::ffff:3.130.96.91	cypex.ai/scanning Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) Chrome/126.0.0.0 Safari/537.36	/	\N	2025-11-29 03:12:58.924
58	::ffff:66.132.153.120	unknown	/	\N	2025-11-29 05:15:15.682
59	::ffff:167.94.138.185	Mozilla/5.0 (compatible; CensysInspect/1.1; +https://about.censys.io/)	/	\N	2025-11-29 05:58:26.163
60	::ffff:176.65.148.250	unknown	/	\N	2025-11-29 07:12:19.97
61	::ffff:185.247.137.119	Mozilla/5.0 (compatible; InternetMeasurement/1.0; +https://internet-measurement.com/)	/	\N	2025-11-29 10:46:15.798
123	::ffff:206.168.34.221	unknown	/	\N	2025-12-07 05:11:59.613
249	::ffff:69.164.217.245	Mozilla/5.0 zgrab/0.x	/	\N	2025-12-19 15:33:46.36
62	::ffff:185.106.177.86	Mozilla/5.0 (iPad; CPU OS 17_7_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.4.1 Mobile/15E148 Safari/604.1	/	\N	2025-11-29 11:56:36.767
63	::ffff:127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	/	http://poniaganetworking.com	2025-11-30 01:04:59.953
64	::ffff:199.45.155.80	unknown	/	\N	2025-11-30 05:28:35.408
65	::ffff:176.65.148.250	unknown	/	\N	2025-11-30 06:52:27.191
66	::ffff:34.77.152.43	python-requests/2.32.5	/	\N	2025-11-30 16:50:20.185
67	::ffff:185.247.137.89	Mozilla/5.0 (compatible; InternetMeasurement/1.0; +https://internet-measurement.com/)	/	\N	2025-11-30 21:24:10.811
68	::ffff:127.0.0.1	Mozilla/5.0 (Linux; U; Android 2.0; en-us; Droid Build/ESD20) AppleWebKit/530.17 (KHTML, like Gecko) Version/4.0 Mobile Safari/530.17	/	\N	2025-12-01 00:01:18.562
69	::ffff:3.143.33.63	cypex.ai/scanning Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) Chrome/126.0.0.0 Safari/537.36	/	\N	2025-12-01 01:06:02.042
70	::ffff:176.65.148.250	unknown	/	\N	2025-12-01 05:02:40.771
71	::ffff:206.168.34.60	unknown	/	\N	2025-12-01 05:15:52.575
72	::ffff:206.168.34.62	Mozilla/5.0 (compatible; CensysInspect/1.1; +https://about.censys.io/)	/	\N	2025-12-01 05:59:16.982
73	::ffff:172.236.228.220	Mozilla/5.0 (Macintosh; Intel Mac OS X 13_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36	/	\N	2025-12-01 09:04:02.067
74	::ffff:15.204.142.151	unknown	/	\N	2025-12-01 11:10:12.807
75	::ffff:97.107.131.169	unknown	/	\N	2025-12-01 11:12:26.363
76	::ffff:127.0.0.1	Mozilla/5.0 (X11; Linux i686; rv:109.0) Gecko/20100101 Firefox/120.0	/	\N	2025-12-02 00:20:00.519
77	::ffff:185.226.197.49	Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.117 Safari/537.36	/	\N	2025-12-02 01:04:36.066
78	::ffff:91.230.168.16	Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	/	\N	2025-12-02 01:23:09.406
79	::ffff:3.130.96.91	cypex.ai/scanning Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) Chrome/126.0.0.0 Safari/537.36	/	\N	2025-12-02 01:45:42.506
80	::ffff:173.255.229.77	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.61 Safari/537.36	/	\N	2025-12-02 04:03:57.638
81	::ffff:162.142.125.195	unknown	/	\N	2025-12-02 05:11:03.444
82	::ffff:216.180.246.134	'Mozilla/5.0 (compatible; GenomeCrawlerd/1.0; +https://www.nokia.com/genomecrawler)'	/	\N	2025-12-02 07:34:34.638
83	::ffff:152.32.227.68	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36 Edg/120.0.0.0	/	\N	2025-12-02 12:32:41.375
84	::ffff:185.247.137.29	Mozilla/5.0 (compatible; InternetMeasurement/1.0; +https://internet-measurement.com/)	/	\N	2025-12-02 12:59:06.272
85	::ffff:87.236.176.30	Mozilla/5.0 (compatible; InternetMeasurement/1.0; +https://internet-measurement.com/)	/	\N	2025-12-02 14:10:40.578
86	::ffff:80.82.77.202	Mozilla/5.0 (Linux; Android 8.1.0; SM-J530F) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/76.0.3809.111 Mobile Safari/537.36	/	\N	2025-12-02 15:43:29.217
87	::ffff:127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36	/	\N	2025-12-03 00:11:02.119
88	::ffff:185.247.137.157	Mozilla/5.0 (compatible; InternetMeasurement/1.0; +https://internet-measurement.com/)	/	\N	2025-12-03 05:11:34.089
89	::ffff:66.132.153.126	unknown	/	\N	2025-12-03 05:46:48.76
90	::ffff:162.142.125.126	Mozilla/5.0 (compatible; CensysInspect/1.1; +https://about.censys.io/)	/	\N	2025-12-03 05:59:24.774
91	::ffff:176.65.148.250	unknown	/	\N	2025-12-03 09:19:35.043
92	::ffff:185.247.137.188	Mozilla/5.0 (compatible; InternetMeasurement/1.0; +https://internet-measurement.com/)	/	\N	2025-12-03 14:34:46.599
93	::ffff:18.97.19.185	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36	/	\N	2025-12-03 18:01:36.812
94	::ffff:80.82.77.202	fasthttp	/	\N	2025-12-03 21:37:04.735
95	::ffff:127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	/	http://poniaganetworking.com	2025-12-04 01:07:57.52
96	::ffff:176.65.148.250	unknown	/	\N	2025-12-04 03:54:19.054
97	::ffff:199.45.155.90	unknown	/	\N	2025-12-04 05:24:44.996
98	::ffff:3.131.215.38	cypex.ai/scanning Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) Chrome/126.0.0.0 Safari/537.36	/	\N	2025-12-04 06:45:46.072
99	::ffff:195.184.76.149	Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	/	\N	2025-12-04 11:51:39.398
100	::ffff:71.6.134.235	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36	/	\N	2025-12-04 11:57:14.813
101	::ffff:91.196.152.147	Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	/	\N	2025-12-04 14:01:13.833
102	::ffff:74.235.100.142	Mozilla/5.0 zgrab/0.x	/	\N	2025-12-04 15:20:27.228
103	::ffff:216.180.246.59	'Mozilla/5.0 (compatible; GenomeCrawlerd/1.0; +https://www.nokia.com/genomecrawler)'	/	\N	2025-12-04 16:09:42.169
104	::ffff:127.0.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36	/	http://poniaganetworking.com	2025-12-05 00:55:38.879
105	::ffff:162.142.125.116	unknown	/	\N	2025-12-05 05:21:54.362
106	::ffff:167.94.138.203	Mozilla/5.0 (compatible; CensysInspect/1.1; +https://about.censys.io/)	/	\N	2025-12-05 05:58:12.119
107	::ffff:176.65.148.250	unknown	/	\N	2025-12-05 07:53:51.264
108	::ffff:34.38.83.65	python-requests/2.32.5	/	\N	2025-12-05 12:00:40.132
109	::ffff:87.236.176.34	Mozilla/5.0 (compatible; InternetMeasurement/1.0; +https://internet-measurement.com/)	/	\N	2025-12-05 23:01:53.447
110	::ffff:87.236.176.221	Mozilla/5.0 (compatible; InternetMeasurement/1.0; +https://internet-measurement.com/)	/	\N	2025-12-05 23:59:07.501
111	::ffff:127.0.0.1	Mozilla/5.0 (compatible; AhrefsBot/7.0; +http://ahrefs.com/robot/)	/blog	\N	2025-12-06 00:50:10.074
112	::ffff:199.45.155.89	unknown	/	\N	2025-12-06 05:42:59.806
113	::ffff:66.23.193.169	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36	/	\N	2025-12-06 05:45:25.334
114	::ffff:176.65.148.250	unknown	/	\N	2025-12-06 06:44:45.339
115	::ffff:35.233.96.173	python-requests/2.32.5	/	\N	2025-12-06 11:13:32.829
116	::ffff:15.204.163.45	Go-http-client/1.1	/	\N	2025-12-06 14:31:47.722
117	::ffff:141.98.82.26	Mozilla/5.0 (Knoppix; Linux i686; rv:128.0) Gecko/20100101 Firefox/128.0	/	\N	2025-12-06 15:57:35.505
118	::ffff:71.6.146.185	unknown	/	\N	2025-12-06 21:03:05.859
119	::ffff:34.63.66.50	unknown	/	\N	2025-12-07 01:04:39.54
120	::ffff:127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	/	http://poniaganetworking.com	2025-12-07 01:07:24.349
121	::ffff:176.65.148.250	unknown	/	\N	2025-12-07 02:42:33.472
122	::ffff:141.98.82.26	Mozilla/5.0 (Ubuntu; Linux i686) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36	/	\N	2025-12-07 02:57:06.433
124	::ffff:162.142.125.207	Mozilla/5.0 (compatible; CensysInspect/1.1; +https://about.censys.io/)	/	\N	2025-12-07 05:58:57.911
125	::ffff:172.236.228.39	Mozilla/5.0 (Macintosh; Intel Mac OS X 13_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36	/	\N	2025-12-07 12:44:05.039
126	::ffff:3.131.215.38	cypex.ai/scanning Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) Chrome/126.0.0.0 Safari/537.36	/	\N	2025-12-07 13:39:10.217
127	::ffff:192.249.121.157	unknown	/	\N	2025-12-07 16:52:59.346
128	::ffff:146.148.26.145	python-requests/2.32.5	/	\N	2025-12-07 18:15:19.035
129	::ffff:185.247.137.159	Mozilla/5.0 (compatible; InternetMeasurement/1.0; +https://internet-measurement.com/)	/	\N	2025-12-07 20:45:15.212
130	::ffff:127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	/	http://poniaganetworking.com	2025-12-08 01:05:52.647
131	::ffff:176.65.148.250	unknown	/	\N	2025-12-08 02:02:08.076
132	::ffff:174.138.186.218	unknown	/	\N	2025-12-08 04:07:33.017
133	::ffff:199.45.155.78	unknown	/	\N	2025-12-08 05:17:53.916
134	::ffff:173.255.197.68	unknown	/	\N	2025-12-08 06:15:40.412
135	::ffff:35.88.241.55	unknown	/	\N	2025-12-08 08:52:59.045
136	::ffff:185.247.137.195	Mozilla/5.0 (compatible; InternetMeasurement/1.0; +https://internet-measurement.com/)	/	\N	2025-12-08 09:21:00.954
137	::ffff:45.156.128.108	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.113 Safari/537.36	/	\N	2025-12-08 10:04:48.157
138	::ffff:89.248.171.24	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/104.0.0.0 Safari/537.36	/	\N	2025-12-08 11:03:14.42
139	::ffff:91.230.168.189	Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	/	\N	2025-12-08 12:14:09.898
140	::ffff:3.131.215.38	cypex.ai/scanning Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) Chrome/126.0.0.0 Safari/537.36	/	\N	2025-12-08 12:23:57.674
141	::ffff:1.9.51.1	unknown	/	\N	2025-12-08 16:34:38.397
142	::ffff:87.236.176.215	Mozilla/5.0 (compatible; InternetMeasurement/1.0; +https://internet-measurement.com/)	/	\N	2025-12-08 23:12:36.276
143	::ffff:127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/112.0.0.0 Safari/537.36	/	\N	2025-12-09 00:05:56.589
144	::ffff:80.82.77.202	fasthttp	/	\N	2025-12-09 00:18:15.474
145	::ffff:159.65.239.102	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.61 Safari/537.36	/	\N	2025-12-09 04:21:54.03
146	::ffff:167.94.138.186	unknown	/	\N	2025-12-09 05:12:12.615
147	::ffff:162.142.125.214	Mozilla/5.0 (compatible; CensysInspect/1.1; +https://about.censys.io/)	/	\N	2025-12-09 05:58:07.251
148	::ffff:3.137.73.221	cypex.ai/scanning Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) Chrome/126.0.0.0 Safari/537.36	/	\N	2025-12-09 12:58:42.463
149	::ffff:213.21.239.49	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36	/	\N	2025-12-09 14:07:01.479
150	::ffff:216.180.246.159	'Mozilla/5.0 (compatible; GenomeCrawlerd/1.0; +https://www.nokia.com/genomecrawler)'	/	\N	2025-12-09 14:46:09.725
151	::ffff:209.182.233.206	unknown	/	\N	2025-12-09 15:06:48.427
152	::ffff:176.65.148.250	unknown	/	\N	2025-12-09 15:55:54.252
153	::ffff:176.65.149.162	Mozilla/5.0 (compatible; Let's Encrypt validation server; +https://www.letsencrypt.org  )	/	\N	2025-12-09 20:40:10.719
154	::ffff:127.0.0.1	Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.7390.122 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)	/	\N	2025-12-10 01:04:42.898
155	::ffff:216.180.246.87	'Mozilla/5.0 (compatible; GenomeCrawlerd/1.0; +https://www.nokia.com/genomecrawler)'	/	\N	2025-12-10 03:25:46.037
156	::ffff:176.65.148.250	unknown	/	\N	2025-12-10 04:51:23.392
157	::ffff:199.45.154.154	unknown	/	\N	2025-12-10 05:25:28.883
158	::ffff:176.65.149.162	Mozilla/5.0 (compatible; Let's Encrypt validation server; +https://www.letsencrypt.org  )	/	\N	2025-12-10 12:51:07.846
159	::ffff:3.143.33.63	cypex.ai/scanning Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) Chrome/126.0.0.0 Safari/537.36	/	\N	2025-12-10 13:20:30.401
160	::ffff:216.180.246.65	'Mozilla/5.0 (compatible; GenomeCrawlerd/1.0; +https://www.nokia.com/genomecrawler)'	/	\N	2025-12-10 14:54:09.067
161	::ffff:75.119.128.89	Mozilla/5.0 (Debian; Linux i686) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	/	\N	2025-12-10 21:05:23.297
162	::ffff:127.0.0.1	Mozilla/5.0 (compatible; NetcraftSurveyAgent/1.0; +info@netcraft.com)	/	\N	2025-12-11 00:28:41.348
163	::ffff:20.80.105.17	Mozilla/5.0 zgrab/0.x	/	\N	2025-12-11 01:34:44.058
164	::ffff:66.132.153.138	unknown	/	\N	2025-12-11 05:29:08.069
165	::ffff:176.65.148.250	unknown	/	\N	2025-12-11 05:40:04.556
166	::ffff:172.232.186.12	unknown	/	\N	2025-12-11 08:20:45.084
167	::ffff:159.65.193.194	curl	/	\N	2025-12-11 10:21:28.818
168	::ffff:172.236.228.39	Mozilla/5.0 (Macintosh; Intel Mac OS X 13_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36	/	\N	2025-12-11 13:07:27.872
169	::ffff:3.137.73.221	cypex.ai/scanning Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) Chrome/126.0.0.0 Safari/537.36	/	\N	2025-12-11 13:24:31.401
170	::ffff:64.227.90.185	unknown	/	\N	2025-12-11 21:36:45.255
171	::ffff:80.82.77.202	fasthttp	/	\N	2025-12-11 22:53:07.794
172	::ffff:127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36	/	\N	2025-12-12 00:46:06.705
173	::ffff:87.236.176.59	Mozilla/5.0 (compatible; InternetMeasurement/1.0; +https://internet-measurement.com/)	/	\N	2025-12-12 04:49:46.587
174	::ffff:167.94.138.189	unknown	/	\N	2025-12-12 05:11:35.623
175	::ffff:185.16.39.52	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36	/	\N	2025-12-12 05:42:11.745
176	::ffff:176.65.148.250	unknown	/	\N	2025-12-12 07:42:53.434
177	::ffff:74.207.252.24	unknown	/	\N	2025-12-12 07:56:58.456
178	::ffff:80.82.77.202	Mozilla/5.0 (Linux; Android 7.0; Redmi Note 4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/76.0.3809.111 Mobile Safari/537.36	/	\N	2025-12-12 08:40:11.135
179	::ffff:90.85.127.131	unknown	/	\N	2025-12-12 13:23:19.407
180	::ffff:3.132.23.201	cypex.ai/scanning Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) Chrome/126.0.0.0 Safari/537.36	/	\N	2025-12-12 14:25:49.847
181	::ffff:176.65.149.162	Mozilla/5.0 (compatible; Let's Encrypt validation server; +https://www.letsencrypt.org  )	/	\N	2025-12-12 17:46:09.837
182	::ffff:34.22.177.31	python-requests/2.32.5	/	\N	2025-12-12 21:42:28.968
183	::ffff:1.12.45.58	unknown	/	\N	2025-12-13 00:21:56.292
184	::ffff:127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	/	http://poniaganetworking.com	2025-12-13 01:06:17.788
185	::ffff:3.130.96.91	cypex.ai/scanning Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) Chrome/126.0.0.0 Safari/537.36	/	\N	2025-12-13 02:16:39.742
186	::ffff:66.132.153.129	unknown	/	\N	2025-12-13 05:17:21.116
187	::ffff:176.65.148.250	unknown	/	\N	2025-12-13 05:45:42.198
188	::ffff:162.142.125.206	Mozilla/5.0 (compatible; CensysInspect/1.1; +https://about.censys.io/)	/	\N	2025-12-13 05:56:20.287
189	::ffff:45.33.14.5	Mozilla/5.0 zgrab/0.x	/	\N	2025-12-13 12:33:22.755
190	::ffff:172.236.127.133	Mozilla/5.0 (Macintosh; Intel Mac OS X 13_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36	/	\N	2025-12-13 12:47:57.686
191	::ffff:194.163.172.10	Mozilla/5.0	/	\N	2025-12-13 21:19:17.82
192	::ffff:35.195.43.11	python-requests/2.32.5	/	\N	2025-12-13 23:20:35.188
193	::ffff:134.199.159.144	Mozilla/5.0	/	\N	2025-12-13 23:42:28.602
194	::ffff:127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	/	http://poniaganetworking.com	2025-12-14 01:03:31.454
195	::ffff:185.237.83.193	python-requests/2.32.5	/	\N	2025-12-14 01:05:27.838
196	::ffff:176.65.148.250	unknown	/	\N	2025-12-14 03:57:35.371
197	::ffff:66.132.153.131	unknown	/	\N	2025-12-14 05:17:39.468
198	::ffff:35.195.43.11	python-requests/2.32.5	/	\N	2025-12-14 09:27:41.47
199	::ffff:192.3.138.26	Mozilla/5.0 (compatible; LumeWebScan/2.0; +https://lumeweaver.com/)	/	\N	2025-12-14 13:06:10.219
200	::ffff:176.65.149.162	Mozilla/5.0 (compatible; Let's Encrypt validation server; +https://www.letsencrypt.org  )	/	\N	2025-12-14 13:43:09.657
201	::ffff:203.55.131.4	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36	/	\N	2025-12-14 15:24:04.945
202	::ffff:36.156.22.4	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4 240.111 Safari/537.36	/	\N	2025-12-14 16:42:33.132
203	::ffff:87.236.176.64	Mozilla/5.0 (compatible; InternetMeasurement/1.0; +https://internet-measurement.com/)	/	\N	2025-12-14 23:10:42.902
204	::ffff:127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	/	http://poniaganetworking.com	2025-12-15 01:05:49.343
205	::ffff:176.65.148.250	unknown	/	\N	2025-12-15 01:47:05.047
206	::ffff:89.42.231.244	unknown	/	\N	2025-12-15 04:16:49.544
207	::ffff:199.45.154.126	unknown	/	\N	2025-12-15 05:22:03.131
208	::ffff:206.168.34.120	Mozilla/5.0 (compatible; CensysInspect/1.1; +https://about.censys.io/)	/	\N	2025-12-15 05:58:17.112
209	::ffff:35.233.94.99	python-requests/2.32.5	/	\N	2025-12-15 06:13:02.977
210	::ffff:91.230.168.31	Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	/	\N	2025-12-15 12:16:58.241
211	::ffff:45.82.78.100	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36	/	\N	2025-12-15 13:06:28.966
212	::ffff:45.135.194.99	unknown	/	\N	2025-12-15 14:26:29.503
213	::ffff:124.227.31.3	unknown	/	\N	2025-12-15 18:34:20.205
214	::ffff:182.119.224.160	Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36	/	\N	2025-12-15 18:35:10.311
215	::ffff:134.199.164.204	Mozilla/5.0	/	\N	2025-12-15 21:13:55.731
216	::ffff:209.38.31.214	Mozilla/5.0	/	\N	2025-12-15 22:38:07.306
217	::ffff:44.220.185.184	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36	/	\N	2025-12-15 23:00:46.946
218	::ffff:127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	/	http://poniaganetworking.com	2025-12-16 01:06:35.57
219	::ffff:176.65.149.162	Mozilla/5.0 (compatible; Let's Encrypt validation server; +https://www.letsencrypt.org  )	/	\N	2025-12-16 02:27:09.333
220	::ffff:206.168.34.114	unknown	/	\N	2025-12-16 05:18:13.489
221	::ffff:170.64.169.5	Mozilla/5.0	/	\N	2025-12-16 11:36:28.336
222	::ffff:46.151.178.49	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36	/	\N	2025-12-16 23:23:55.706
223	::ffff:64.23.170.42	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3	/	\N	2025-12-16 23:24:59.4
224	::ffff:123.160.223.72	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36	/	\N	2025-12-17 00:30:50.255
225	::ffff:123.160.223.73	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36	/	\N	2025-12-17 00:30:51.105
226	::ffff:123.160.223.75	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36	/	\N	2025-12-17 00:31:03.874
227	::ffff:127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	/	http://poniaganetworking.com	2025-12-17 01:09:20.313
228	::ffff:176.65.148.250	unknown	/	\N	2025-12-17 01:55:41.9
229	::ffff:3.149.59.26	cypex.ai/scanning Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) Chrome/126.0.0.0 Safari/537.36	/	\N	2025-12-17 04:34:57.214
230	::ffff:199.45.154.115	unknown	/	\N	2025-12-17 05:36:33.054
231	::ffff:206.168.34.42	Mozilla/5.0 (compatible; CensysInspect/1.1; +https://about.censys.io/)	/	\N	2025-12-17 05:52:59.324
232	::ffff:176.65.149.162	Mozilla/5.0 (compatible; Let's Encrypt validation server; +https://www.letsencrypt.org  )	/	\N	2025-12-17 06:26:03.562
233	::ffff:91.231.89.60	Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	/	\N	2025-12-17 13:05:13.696
234	::ffff:66.228.53.157	Mozilla/5.0 (Macintosh; Intel Mac OS X 13_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36	/	\N	2025-12-17 14:35:20.757
235	::ffff:127.0.0.1	Mozilla/5.0 (X11; Linux i686; rv:109.0) Gecko/20100101 Firefox/120.0	/	\N	2025-12-18 00:06:32.67
236	::ffff:74.207.237.5	unknown	/	\N	2025-12-18 01:27:04.845
237	::ffff:80.82.77.202	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/76.0.3809.87 Safari/537.36	/	\N	2025-12-18 02:52:41.109
238	::ffff:185.247.137.216	Mozilla/5.0 (compatible; InternetMeasurement/1.0; +https://internet-measurement.com/)	/	\N	2025-12-18 03:56:09.789
239	::ffff:66.132.153.137	unknown	/	\N	2025-12-18 05:29:35.407
240	::ffff:3.134.148.59	cypex.ai/scanning Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) Chrome/126.0.0.0 Safari/537.36	/	\N	2025-12-18 06:46:11.078
241	::ffff:172.202.117.179	Mozilla/5.0 zgrab/0.x	/	\N	2025-12-18 07:03:41.587
242	::ffff:176.65.149.162	Mozilla/5.0 (compatible; Let's Encrypt validation server; +https://www.letsencrypt.org  )	/	\N	2025-12-18 11:41:07.873
243	::ffff:127.0.0.1	Mozilla/5.0 (compatible; AhrefsBot/7.0; +http://ahrefs.com/robot/)	/	\N	2025-12-19 00:15:35.059
244	::ffff:66.132.153.118	Mozilla/5.0 (compatible; CensysInspect/1.1; +https://about.censys.io/)	/	\N	2025-12-19 05:56:24.276
245	::ffff:199.45.154.156	unknown	/	\N	2025-12-19 06:15:07.317
246	::ffff:35.195.168.139	python-requests/2.32.5	/	\N	2025-12-19 06:18:22.805
247	::ffff:3.130.96.91	cypex.ai/scanning Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) Chrome/126.0.0.0 Safari/537.36	/	\N	2025-12-19 10:25:48.876
248	::ffff:176.65.149.162	Mozilla/5.0 (compatible; Let's Encrypt validation server; +https://www.letsencrypt.org  )	/	\N	2025-12-19 15:06:04.965
250	::ffff:66.228.53.162	Mozilla/5.0 (Macintosh; Intel Mac OS X 13_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36	/	\N	2025-12-19 15:33:48.742
251	::ffff:66.240.236.119	unknown	/	\N	2025-12-19 20:33:03.782
252	::ffff:127.0.0.1	Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.7390.122 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)	/	\N	2025-12-20 00:23:57.488
253	::ffff:82.96.166.194	unknown	/	\N	2025-12-20 00:30:17.009
254	::ffff:89.248.171.24	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/104.0.0.0 Safari/537.36	/	\N	2025-12-20 04:12:47.717
255	::ffff:206.168.34.58	unknown	/	\N	2025-12-20 05:17:54.01
256	::ffff:3.149.59.26	cypex.ai/scanning Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) Chrome/126.0.0.0 Safari/537.36	/	\N	2025-12-20 11:45:01.411
257	::ffff:176.65.149.162	Mozilla/5.0 (compatible; Let's Encrypt validation server; +https://www.letsencrypt.org  )	/	\N	2025-12-20 12:37:09.807
258	::ffff:207.90.244.28	unknown	/	\N	2025-12-20 19:51:58.696
259	::ffff:34.78.140.118	python-requests/2.32.5	/	\N	2025-12-20 22:05:25.084
260	::ffff:203.55.131.5	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36	/	\N	2025-12-20 22:06:54.237
261	::ffff:127.0.0.1	Mozilla/5.0 (compatible; CensysInspect/1.1; +https://about.censys.io/)	/	\N	2025-12-21 00:22:52.702
262	::ffff:118.193.47.114	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36 Edg/120.0.0.0	/	\N	2025-12-21 02:17:32.031
263	::ffff:87.236.176.116	Mozilla/5.0 (compatible; InternetMeasurement/1.0; +https://internet-measurement.com/)	/	\N	2025-12-21 04:45:41.336
264	::ffff:162.142.125.216	unknown	/	\N	2025-12-21 05:24:00.104
265	::ffff:167.94.138.182	Mozilla/5.0 (compatible; CensysInspect/1.1; +https://about.censys.io/)	/	\N	2025-12-21 05:55:53.577
266	::ffff:3.130.96.91	cypex.ai/scanning Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) Chrome/126.0.0.0 Safari/537.36	/	\N	2025-12-21 11:11:21.717
267	::ffff:134.199.160.159	Mozilla/5.0	/	\N	2025-12-21 11:37:16.91
268	::ffff:80.82.77.202	fasthttp	/	\N	2025-12-21 15:32:37.263
269	::ffff:46.151.178.49	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36	/	\N	2025-12-22 00:23:35.314
270	::ffff:127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	/	http://poniaganetworking.com	2025-12-22 01:05:33.503
271	::ffff:45.142.193.221	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36	/	\N	2025-12-22 01:19:23.271
272	::ffff:199.45.155.107	unknown	/	\N	2025-12-22 05:11:17.495
273	::ffff:34.34.132.221	python-requests/2.32.5	/	\N	2025-12-22 07:52:02.736
274	::ffff:3.130.96.91	cypex.ai/scanning Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) Chrome/126.0.0.0 Safari/537.36	/	\N	2025-12-22 12:39:07.344
275	::ffff:176.65.149.162	Mozilla/5.0 (compatible; Let's Encrypt validation server; +https://www.letsencrypt.org  )	/	\N	2025-12-22 14:07:09.713
276	::ffff:91.231.89.135	Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	/	\N	2025-12-22 23:49:17.38
277	::ffff:127.0.0.1	unknown	/	http://104.236.250.242:80/	2025-12-23 00:12:24.579
278	::ffff:188.166.191.136	curl	/	\N	2025-12-23 03:39:38.7
279	::ffff:176.65.149.162	Mozilla/5.0 (compatible; Let's Encrypt validation server; +https://www.letsencrypt.org  )	/	\N	2025-12-23 05:12:11.425
280	::ffff:66.132.153.134	unknown	/	\N	2025-12-23 05:27:08.398
281	::ffff:167.94.138.165	Mozilla/5.0 (compatible; CensysInspect/1.1; +https://about.censys.io/)	/	\N	2025-12-23 05:59:04.925
282	::ffff:159.89.146.29	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	/	\N	2025-12-23 07:21:19.354
283	::ffff:80.82.77.202	Mozilla/4.8 [en] (X11; U; SunOS; 5.7 sun4u)	/	\N	2025-12-23 09:13:00.806
284	::ffff:185.247.137.71	Mozilla/5.0 (compatible; InternetMeasurement/1.0; +https://internet-measurement.com/)	/	\N	2025-12-23 19:03:24.192
285	::ffff:127.0.0.1	Mozilla/5.0 (compatible; wpbot/1.3; +https://forms.gle/ajBaxygz9jSR8p8G9)	/	\N	2025-12-24 00:18:41.457
286	::ffff:176.65.149.162	Mozilla/5.0 (compatible; Let's Encrypt validation server; +https://www.letsencrypt.org  )	/	\N	2025-12-24 04:51:03.124
287	::ffff:199.45.154.119	unknown	/	\N	2025-12-24 05:17:46.094
288	::ffff:3.137.73.221	cypex.ai/scanning Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) Chrome/126.0.0.0 Safari/537.36	/	\N	2025-12-24 06:41:57.223
289	::ffff:170.64.145.146	Mozilla/5.0	/	\N	2025-12-24 10:42:25.139
290	::ffff:209.38.86.215	Mozilla/5.0	/	\N	2025-12-24 10:58:27.806
291	::ffff:89.248.171.24	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/104.0.0.0 Safari/537.36	/	\N	2025-12-24 12:27:05.898
292	::ffff:127.0.0.1	Mozilla/5.0 (compatible; CensysInspect/1.1; +https://about.censys.io/)	/	\N	2025-12-25 00:18:17.068
293	::ffff:167.94.138.179	unknown	/	\N	2025-12-25 05:17:11.855
294	::ffff:206.168.34.52	Mozilla/5.0 (compatible; CensysInspect/1.1; +https://about.censys.io/)	/	\N	2025-12-25 05:57:41.495
295	::ffff:176.65.149.162	Mozilla/5.0 (compatible; Let's Encrypt validation server; +https://www.letsencrypt.org  )	/	\N	2025-12-25 11:01:06.009
296	::ffff:172.208.25.111	Mozilla/5.0 zgrab/0.x	/	\N	2025-12-25 12:02:55.859
297	::ffff:172.234.217.192	Mozilla/5.0 (Macintosh; Intel Mac OS X 13_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36	/	\N	2025-12-25 19:06:35.193
298	::ffff:106.75.86.6	unknown	/	\N	2025-12-25 20:02:56.21
299	::ffff:172.236.228.229	Mozilla/5.0 (Macintosh; Intel Mac OS X 13_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36	/	\N	2025-12-25 21:18:10.905
300	::ffff:127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36	/	\N	2025-12-26 00:12:33.05
301	::ffff:176.65.149.162	Mozilla/5.0 (compatible; Let's Encrypt validation server; +https://www.letsencrypt.org  )	/	\N	2025-12-26 00:22:03.41
302	::ffff:162.142.125.220	unknown	/	\N	2025-12-26 05:43:02.969
303	::ffff:3.143.33.63	cypex.ai/scanning Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) Chrome/126.0.0.0 Safari/537.36	/	\N	2025-12-26 07:31:03.641
304	::ffff:80.82.77.202	Mozilla/5.0 (Linux; Android 9; Mi A1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.157 Mobile Safari/537.36	/	\N	2025-12-26 17:32:26.812
305	::ffff:80.82.77.202	fasthttp	/	\N	2025-12-27 01:05:01.842
306	::ffff:127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	/	http://poniaganetworking.com	2025-12-27 01:14:58.556
307	::ffff:87.236.176.82	Mozilla/5.0 (compatible; InternetMeasurement/1.0; +https://internet-measurement.com/)	/	\N	2025-12-27 02:39:41.323
308	::ffff:97.107.129.191	unknown	/	\N	2025-12-27 03:20:45.169
309	::ffff:66.132.153.113	Mozilla/5.0 (compatible; CensysInspect/1.1; +https://about.censys.io/)	/	\N	2025-12-27 05:57:35.365
310	::ffff:206.168.34.33	unknown	/	\N	2025-12-27 06:22:42.878
311	::ffff:3.149.59.26	cypex.ai/scanning Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) Chrome/126.0.0.0 Safari/537.36	/	\N	2025-12-27 07:49:33.765
312	::ffff:176.65.149.162	Mozilla/5.0 (compatible; Let's Encrypt validation server; +https://www.letsencrypt.org  )	/	\N	2025-12-27 09:36:06.591
313	::ffff:52.83.92.55	Python-urllib/2.7	/	\N	2025-12-27 11:05:09.576
314	::ffff:80.14.67.55	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	/	\N	2025-12-27 14:23:54.587
315	::ffff:216.180.246.22	'Mozilla/5.0 (compatible; GenomeCrawlerd/1.0; +https://www.nokia.com/genomecrawler)'	/	\N	2025-12-27 23:22:24.613
316	::ffff:127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 16_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) CriOS/122.0.6261.89 Mobile/15E148 Safari/604	/	http://poniaganetworking.com/	2025-12-28 00:54:24.548
317	::ffff:176.65.149.162	Mozilla/5.0 (compatible; Let's Encrypt validation server; +https://www.letsencrypt.org  )	/	\N	2025-12-28 01:42:10.323
318	::ffff:157.245.131.28	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.61 Safari/537.36	/	\N	2025-12-28 01:50:53.858
319	::ffff:167.94.138.181	unknown	/	\N	2025-12-28 05:52:46.756
320	::ffff:203.55.131.3	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36	/	\N	2025-12-28 05:59:14.054
321	::ffff:3.137.73.221	cypex.ai/scanning Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) Chrome/126.0.0.0 Safari/537.36	/	\N	2025-12-28 10:30:53.677
322	::ffff:102.69.167.14	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36	/	\N	2025-12-28 19:34:53.723
323	::ffff:139.5.70.70	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:121.0) Gecko/20100101 Firefox/121.0	/	\N	2025-12-28 21:07:30.523
324	::ffff:139.5.70.221	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36	/	\N	2025-12-28 22:26:17.393
325	::ffff:150.107.38.251	unknown	/	\N	2025-12-28 22:58:19.059
326	::ffff:38.242.242.250	Mozilla/5.0	/	\N	2025-12-29 00:33:20.191
327	::ffff:127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	/	http://poniaganetworking.com	2025-12-29 01:06:43.576
328	::ffff:167.94.146.58	unknown	/	\N	2025-12-29 05:12:55.206
329	::ffff:139.144.52.241	unknown	/	\N	2025-12-29 06:36:09.426
330	::ffff:3.143.33.63	cypex.ai/scanning Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) Chrome/126.0.0.0 Safari/537.36	/	\N	2025-12-29 09:04:33.047
331	::ffff:170.64.138.153	Mozilla/5.0	/	\N	2025-12-29 10:11:39.494
332	::ffff:176.65.149.162	Mozilla/5.0 (compatible; Let's Encrypt validation server; +https://www.letsencrypt.org  )	/	\N	2025-12-29 13:53:02.516
333	::ffff:209.38.29.79	Mozilla/5.0	/	\N	2025-12-29 15:49:04.082
334	::ffff:51.195.222.14	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	/	\N	2025-12-29 17:29:07.552
335	::ffff:87.236.176.131	Mozilla/5.0 (compatible; InternetMeasurement/1.0; +https://internet-measurement.com/)	/	\N	2025-12-29 21:26:06.477
336	::ffff:44.220.188.38	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36	/	\N	2025-12-29 23:17:43.9
337	::ffff:91.231.89.26	Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	/	\N	2025-12-29 23:46:53.011
338	::ffff:176.65.149.162	Mozilla/5.0 (compatible; Let's Encrypt validation server; +https://www.letsencrypt.org  )	/	\N	2025-12-30 00:18:07.106
339	::ffff:127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	/	http://poniaganetworking.com	2025-12-30 01:08:19.691
340	::ffff:66.132.153.136	unknown	/	\N	2025-12-30 05:24:56.25
341	::ffff:216.180.246.214	'Mozilla/5.0 (compatible; GenomeCrawlerd/1.0; +https://www.nokia.com/genomecrawler)'	/	\N	2025-12-30 05:34:05.6
342	::ffff:80.82.77.202	fasthttp	/	\N	2025-12-30 06:00:01.204
343	::ffff:206.168.34.45	Mozilla/5.0 (compatible; CensysInspect/1.1; +https://about.censys.io/)	/	\N	2025-12-30 06:02:17.687
344	::ffff:3.137.73.221	cypex.ai/scanning Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) Chrome/126.0.0.0 Safari/537.36	/	\N	2025-12-30 10:58:18.743
345	::ffff:178.16.54.197	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:98.0) Gecko/20100101 Firefox/98.0	/	\N	2025-12-30 16:09:22.966
346	::ffff:127.0.0.1	Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.7390.122 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)	/	\N	2025-12-31 00:04:44.788
347	::ffff:167.94.138.202	Mozilla/5.0 (compatible; CensysInspect/1.1; +https://about.censys.io/)	/	\N	2025-12-31 07:03:21.737
348	::ffff:167.94.138.176	unknown	/	\N	2025-12-31 07:32:03.183
349	::ffff:118.193.65.209	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36 Edg/120.0.0.0	/	\N	2025-12-31 12:26:01.876
350	::ffff:178.16.54.197	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/52.0.2743.116 Safari/537.36 Edge/15.15063	/	\N	2025-12-31 13:04:04.949
351	::ffff:3.134.148.59	cypex.ai/scanning Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) Chrome/126.0.0.0 Safari/537.36	/	\N	2025-12-31 14:28:00.309
352	::ffff:176.65.149.162	Mozilla/5.0 (compatible; Let's Encrypt validation server; +https://www.letsencrypt.org  )	/	\N	2025-12-31 19:00:11.194
353	::ffff:66.228.53.78	Mozilla/5.0 (Macintosh; Intel Mac OS X 13_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36	/	\N	2025-12-31 20:39:01.211
354	::ffff:80.82.77.202	MobileSafari/600.1.4 CFNetwork/711.1.12 Darwin/14.0.0	/	\N	2025-12-31 21:25:36.12
355	::ffff:127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	/	http://poniaganetworking.com	2026-01-01 01:05:12.356
356	::ffff:71.6.146.186	unknown	/	\N	2026-01-01 04:30:16.093
357	::ffff:206.168.34.117	Mozilla/5.0 (compatible; CensysInspect/1.1; +https://about.censys.io/)	/	\N	2026-01-01 07:59:04.841
358	::ffff:167.94.146.51	unknown	/	\N	2026-01-01 08:16:14.439
359	::ffff:185.247.137.187	Mozilla/5.0 (compatible; InternetMeasurement/1.0; +https://internet-measurement.com/)	/	\N	2026-01-01 13:03:39.398
360	::ffff:176.65.149.162	Mozilla/5.0 (compatible; Let's Encrypt validation server; +https://www.letsencrypt.org  )	/	\N	2026-01-01 13:13:03.662
361	::ffff:3.132.23.201	cypex.ai/scanning Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) Chrome/126.0.0.0 Safari/537.36	/	\N	2026-01-01 15:12:58.998
362	::ffff:172.202.118.17	Mozilla/5.0 zgrab/0.x	/	\N	2026-01-01 16:24:57.912
363	::ffff:203.55.131.5	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36	/	\N	2026-01-01 19:27:03.34
364	::ffff:20.163.20.206	Mozilla/5.0 zgrab/0.x	/	\N	2026-01-01 21:42:54.187
365	::ffff:89.248.172.33	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/104.0.0.0 Safari/537.36	/	\N	2026-01-01 23:17:20.814
366	::ffff:127.0.0.1	Mozilla/5.0 (compatible; CensysInspect/1.1; +https://about.censys.io/)	/	\N	2026-01-02 00:45:47.975
367	::ffff:139.144.52.241	unknown	/	\N	2026-01-02 06:50:26.656
368	::ffff:66.132.153.117	unknown	/	\N	2026-01-02 08:21:02.818
369	::ffff:167.94.138.189	Mozilla/5.0 (compatible; CensysInspect/1.1; +https://about.censys.io/)	/	\N	2026-01-02 09:02:54.225
370	::ffff:35.187.114.229	python-requests/2.32.5	/	\N	2026-01-02 09:24:28.782
371	::ffff:3.134.148.59	cypex.ai/scanning Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) Chrome/126.0.0.0 Safari/537.36	/	\N	2026-01-02 11:52:00.592
372	::ffff:176.65.149.162	Mozilla/5.0 (compatible; Let's Encrypt validation server; +https://www.letsencrypt.org  )	/	\N	2026-01-02 13:18:03.723
373	::ffff:185.247.137.153	Mozilla/5.0 (compatible; InternetMeasurement/1.0; +https://internet-measurement.com/)	/	\N	2026-01-03 00:19:13.914
374	::ffff:127.0.0.1	okhttp/5.3.0	/	\N	2026-01-03 00:28:23.471
375	::ffff:46.151.178.49	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36	/	\N	2026-01-03 04:37:22.047
376	::ffff:89.248.172.33	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/104.0.0.0 Safari/537.36	/	\N	2026-01-03 04:57:11.593
377	::ffff:66.132.153.112	Mozilla/5.0 (compatible; CensysInspect/1.1; +https://about.censys.io/)	/	\N	2026-01-03 10:07:14.533
378	::ffff:66.132.153.137	Mozilla/5.0 (compatible; CensysInspect/1.1; +https://about.censys.io/)	/	\N	2026-01-03 10:08:56.261
379	::ffff:45.82.78.107	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36	/	\N	2026-01-03 10:21:07.182
380	::ffff:3.130.96.91	cypex.ai/scanning Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) Chrome/126.0.0.0 Safari/537.36	/	\N	2026-01-03 12:56:31.731
381	::ffff:176.65.149.162	Mozilla/5.0 (compatible; Let's Encrypt validation server; +https://www.letsencrypt.org  )	/	\N	2026-01-03 21:46:02.639
382	::ffff:34.79.212.205	python-requests/2.32.5	/	\N	2026-01-03 22:15:38.175
383	::ffff:127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36	/	\N	2026-01-04 00:06:28.547
384	::ffff:185.247.137.186	Mozilla/5.0 (compatible; InternetMeasurement/1.0; +https://internet-measurement.com/)	/	\N	2026-01-04 02:11:47.929
385	::ffff:94.102.49.193	unknown	/	\N	2026-01-04 04:56:13.094
386	::ffff:71.6.135.131	unknown	/	\N	2026-01-04 05:30:15.152
387	::ffff:204.76.203.8	Go-http-client/1.1	/	\N	2026-01-04 07:54:45.348
388	::ffff:91.196.152.73	Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	/	\N	2026-01-04 10:50:21.019
389	::ffff:167.94.138.59	Mozilla/5.0 (compatible; CensysInspect/1.1; +https://about.censys.io/)	/	\N	2026-01-04 11:05:15.413
390	::ffff:3.143.33.63	cypex.ai/scanning Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) Chrome/126.0.0.0 Safari/537.36	/	\N	2026-01-04 12:47:15.887
391	::ffff:176.65.149.162	Mozilla/5.0 (compatible; Let's Encrypt validation server; +https://www.letsencrypt.org  )	/	\N	2026-01-04 17:56:08.637
392	::ffff:80.82.77.202	fasthttp	/	\N	2026-01-04 18:57:28.956
393	::ffff:127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	/	http://poniaganetworking.com	2026-01-05 00:43:36.481
394	::ffff:176.65.149.162	Mozilla/5.0 (compatible; Let's Encrypt validation server; +https://www.letsencrypt.org  )	/	\N	2026-01-05 05:05:08.526
395	::ffff:206.168.34.117	Mozilla/5.0 (compatible; CensysInspect/1.1; +https://about.censys.io/)	/	\N	2026-01-05 12:00:51.925
396	::ffff:3.132.23.201	cypex.ai/scanning Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) Chrome/126.0.0.0 Safari/537.36	/	\N	2026-01-05 13:36:08.139
397	::ffff:66.240.219.146	unknown	/	\N	2026-01-05 20:24:50.885
398	::ffff:44.220.185.244	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36	/	\N	2026-01-05 22:13:34.946
399	::ffff:172.236.228.115	Mozilla/5.0 (Macintosh; Intel Mac OS X 13_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36	/	\N	2026-01-05 23:09:02.307
400	::ffff:127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	/	http://poniaganetworking.com	2026-01-06 01:09:18.16
401	::ffff:199.45.154.156	unknown	/	\N	2026-01-06 05:15:02.72
402	::ffff:79.127.221.66	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36	/	\N	2026-01-06 11:52:51.156
403	::ffff:37.19.216.146	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36	/	\N	2026-01-06 11:52:57.457
404	::ffff:176.65.149.162	Mozilla/5.0 (compatible; Let's Encrypt validation server; +https://www.letsencrypt.org  )	/	\N	2026-01-06 12:00:03.418
405	::ffff:3.143.33.63	cypex.ai/scanning Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) Chrome/126.0.0.0 Safari/537.36	/	\N	2026-01-06 15:06:45.198
406	::ffff:91.231.89.196	Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	/	\N	2026-01-06 21:22:04.465
407	::ffff:127.0.0.1	Mozilla/5.0 (compatible; AhrefsBot/7.0; +http://ahrefs.com/robot/)	/contact	\N	2026-01-07 00:15:27.08
408	::ffff:87.236.176.195	Mozilla/5.0 (compatible; InternetMeasurement/1.0; +https://internet-measurement.com/)	/	\N	2026-01-07 01:50:06.585
409	::ffff:167.94.138.193	unknown	/	\N	2026-01-07 05:13:12.541
410	::ffff:66.132.153.130	Mozilla/5.0 (compatible; CensysInspect/1.1; +https://about.censys.io/)	/	\N	2026-01-07 05:56:51.542
411	::ffff:3.143.33.63	cypex.ai/scanning Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) Chrome/126.0.0.0 Safari/537.36	/	\N	2026-01-07 13:58:51.633
412	::ffff:34.34.132.221	python-requests/2.32.5	/	\N	2026-01-07 15:42:12.366
413	::ffff:35.233.95.0	python-requests/2.32.5	/	\N	2026-01-07 16:25:11.638
414	::ffff:15.204.47.3	unknown	/	\N	2026-01-07 19:30:21.844
415	::ffff:45.79.211.97	Mozilla/5.0 zgrab/0.x	/	\N	2026-01-07 22:32:35.383
416	::ffff:66.228.53.204	Mozilla/5.0 (Macintosh; Intel Mac OS X 13_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36	/	\N	2026-01-07 23:13:49.305
417	::ffff:127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	/	http://poniaganetworking.com	2026-01-08 01:08:56.084
418	::ffff:66.132.153.113	unknown	/	\N	2026-01-08 05:42:15.99
419	::ffff:176.65.149.162	Mozilla/5.0 (compatible; Let's Encrypt validation server; +https://www.letsencrypt.org  )	/	\N	2026-01-08 09:13:07.913
420	::ffff:87.236.176.166	Mozilla/5.0 (compatible; InternetMeasurement/1.0; +https://internet-measurement.com/)	/	\N	2026-01-08 09:13:37.357
421	::ffff:3.130.96.91	cypex.ai/scanning Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) Chrome/126.0.0.0 Safari/537.36	/	\N	2026-01-08 13:52:10.307
422	::ffff:164.52.24.186	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36	/	\N	2026-01-08 16:19:03.317
423	::ffff:141.98.82.26	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:125.0) Gecko/20100101 Firefox/125.0	/	\N	2026-01-08 18:07:34.365
424	::ffff:89.248.172.33	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/104.0.0.0 Safari/537.36	/	\N	2026-01-08 22:21:49.65
425	::ffff:71.6.134.231	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36	/	\N	2026-01-08 23:38:26.433
426	::ffff:127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	/	http://poniaganetworking.com	2026-01-09 01:08:57.704
427	::ffff:172.212.201.77	Mozilla/5.0 zgrab/0.x	/	\N	2026-01-09 01:37:37.643
428	::ffff:206.168.34.211	Mozilla/5.0 (compatible; CensysInspect/1.1; +https://about.censys.io/)	/	\N	2026-01-09 06:00:16.351
429	::ffff:199.45.155.100	unknown	/	\N	2026-01-09 07:00:45.36
430	::ffff:62.4.14.71	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36	/	\N	2026-01-09 10:33:14.463
431	::ffff:34.76.200.20	python-requests/2.32.5	/	\N	2026-01-09 11:26:57.51
432	::ffff:3.130.96.91	cypex.ai/scanning Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) Chrome/126.0.0.0 Safari/537.36	/	\N	2026-01-09 14:20:46.523
433	::ffff:176.65.149.162	Mozilla/5.0 (compatible; Let's Encrypt validation server; +https://www.letsencrypt.org  )	/	\N	2026-01-09 17:19:11.242
434	::ffff:154.197.56.163	unknown	/	\N	2026-01-09 19:36:01.262
435	::ffff:127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	/	http://poniaganetworking.com	2026-01-10 00:39:53.424
436	::ffff:199.45.154.155	unknown	/	\N	2026-01-10 06:12:03.824
437	::ffff:185.247.137.150	Mozilla/5.0 (compatible; InternetMeasurement/1.0; +https://internet-measurement.com/)	/	\N	2026-01-10 08:07:10.811
438	::ffff:176.65.149.162	Mozilla/5.0 (compatible; Let's Encrypt validation server; +https://www.letsencrypt.org  )	/	\N	2026-01-10 10:06:05.131
439	::ffff:3.143.33.63	cypex.ai/scanning Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) Chrome/126.0.0.0 Safari/537.36	/	\N	2026-01-10 16:02:43.173
440	::ffff:45.156.129.82	Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.117 Safari/537.36	/	\N	2026-01-10 21:50:57.865
441	::ffff:127.0.0.1	Mozilla/5.0	/	\N	2026-01-11 00:38:50.688
442	::ffff:206.168.34.211	Mozilla/5.0 (compatible; CensysInspect/1.1; +https://about.censys.io/)	/	\N	2026-01-11 06:56:47.834
443	::ffff:66.132.153.136	unknown	/	\N	2026-01-11 15:27:42.759
444	::ffff:3.137.73.221	cypex.ai/scanning Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) Chrome/126.0.0.0 Safari/537.36	/	\N	2026-01-11 15:48:02.62
445	::ffff:157.245.178.217	unknown	/	\N	2026-01-11 23:07:40.378
446	::ffff:127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	/	http://poniaganetworking.com	2026-01-12 00:33:41.892
447	::ffff:45.33.23.10	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.61 Safari/537.36	/	\N	2026-01-12 03:26:48.544
448	::ffff:195.184.76.170	Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	/	\N	2026-01-12 04:27:23.659
449	::ffff:216.180.246.63	'Mozilla/5.0 (compatible; GenomeCrawlerd/1.0; +https://www.nokia.com/genomecrawler)'	/	\N	2026-01-12 04:56:12.347
450	::ffff:172.236.228.86	Mozilla/5.0 (Macintosh; Intel Mac OS X 13_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36	/	\N	2026-01-12 05:16:09.84
451	::ffff:207.90.244.28	unknown	/	\N	2026-01-12 05:38:38.082
452	::ffff:176.65.149.162	Mozilla/5.0 (compatible; Let's Encrypt validation server; +https://www.letsencrypt.org  )	/	\N	2026-01-12 08:38:06.921
453	::ffff:35.195.180.151	python-requests/2.32.5	/	\N	2026-01-12 12:35:28.444
454	::ffff:206.168.34.212	Mozilla/5.0 (compatible; CensysInspect/1.1; +https://about.censys.io/)	/	\N	2026-01-12 15:51:06.295
455	::ffff:127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	/	http://poniaganetworking.com	2026-01-13 01:05:41.222
456	::ffff:185.247.137.210	Mozilla/5.0 (compatible; InternetMeasurement/1.0; +https://internet-measurement.com/)	/	\N	2026-01-13 04:58:38.888
457	::ffff:87.236.176.67	Mozilla/5.0 (compatible; InternetMeasurement/1.0; +https://internet-measurement.com/)	/	\N	2026-01-13 05:13:15.212
458	::ffff:35.195.185.167	python-requests/2.32.5	/	\N	2026-01-13 07:08:35.487
459	::ffff:213.177.179.5	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	/	\N	2026-01-13 07:11:16.933
460	::ffff:162.142.125.113	unknown	/	\N	2026-01-13 08:30:02.296
461	::ffff:91.231.89.117	Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	/	\N	2026-01-13 21:28:24.502
462	::ffff:104.152.52.216	curl/7.61.1	/	\N	2026-01-13 22:39:01.457
463	::ffff:127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36 Edg/120.0.0.0	/	\N	2026-01-14 00:47:52.909
464	::ffff:3.134.148.59	cypex.ai/scanning Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) Chrome/126.0.0.0 Safari/537.36	/	\N	2026-01-14 03:43:52.489
465	::ffff:206.168.34.55	unknown	/	\N	2026-01-14 06:44:18.789
466	::ffff:179.43.134.114	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36	/	\N	2026-01-14 08:07:57.699
467	::ffff:127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	/	http://poniaganetworking.com	2026-01-15 01:07:46.211
468	::ffff:3.130.96.91	cypex.ai/scanning Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) Chrome/126.0.0.0 Safari/537.36	/	\N	2026-01-15 05:57:08.411
469	::ffff:172.234.217.192	Mozilla/5.0 (Macintosh; Intel Mac OS X 13_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36	/	\N	2026-01-15 06:29:28.905
470	::ffff:206.168.34.193	Mozilla/5.0 (compatible; CensysInspect/1.1; +https://about.censys.io/)	/	\N	2026-01-15 07:02:00.338
471	::ffff:199.45.154.121	unknown	/	\N	2026-01-15 07:07:21.973
472	::ffff:152.32.207.88	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36 Edg/120.0.0.0	/	\N	2026-01-15 21:43:04.078
473	::ffff:127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	/	http://poniaganetworking.com	2026-01-16 00:23:38.552
474	::ffff:135.119.89.109	Mozilla/5.0 zgrab/0.x	/	\N	2026-01-16 06:16:44.683
475	::ffff:87.236.176.207	Mozilla/5.0 (compatible; InternetMeasurement/1.0; +https://internet-measurement.com/)	/	\N	2026-01-16 06:28:40.014
476	::ffff:206.168.34.218	Mozilla/5.0 (compatible; CensysInspect/1.1; +https://about.censys.io/)	/	\N	2026-01-16 08:04:27.256
477	::ffff:167.94.138.57	unknown	/	\N	2026-01-16 10:42:40.083
478	::ffff:141.11.213.161	Mozilla/5.0 (Macintosh; Intel Mac OS X 15_7_3) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.0 Safari/605.1.15	/	\N	2026-01-16 14:49:43.907
479	::ffff:127.0.0.1	Scrapy/2.13.4 (+https://scrapy.org)	/	\N	2026-01-17 00:48:45.869
480	::ffff:91.230.168.103	Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	/	\N	2026-01-17 03:43:38.482
481	::ffff:206.168.34.194	unknown	/	\N	2026-01-17 08:31:25.814
482	::ffff:123.6.49.9	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36 Edg/120.0.0.0	/	\N	2026-01-17 10:32:52.358
483	::ffff:27.115.124.40	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36 Edg/120.0.0.0	/	\N	2026-01-17 11:13:37.901
484	::ffff:87.236.176.37	Mozilla/5.0 (compatible; InternetMeasurement/1.0; +https://internet-measurement.com/)	/	\N	2026-01-17 16:39:28.588
485	::ffff:185.247.137.182	Mozilla/5.0 (compatible; InternetMeasurement/1.0; +https://internet-measurement.com/)	/	\N	2026-01-17 19:07:17.451
486	::ffff:185.93.89.43	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	/	\N	2026-01-18 00:02:25.034
487	::ffff:127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36	/	\N	2026-01-18 00:38:17.027
488	::ffff:66.132.153.127	unknown	/	\N	2026-01-18 05:25:57.483
489	::ffff:194.164.107.4	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36	/	\N	2026-01-18 06:56:44.848
490	::ffff:185.247.137.71	Mozilla/5.0 (compatible; InternetMeasurement/1.0; +https://internet-measurement.com/)	/	\N	2026-01-18 21:07:06.746
491	::ffff:127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36	/	\N	2026-01-19 00:12:44.268
492	::ffff:3.130.96.91	cypex.ai/scanning Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) Chrome/126.0.0.0 Safari/537.36	/	\N	2026-01-19 02:24:48.015
493	::ffff:162.142.125.113	unknown	/	\N	2026-01-19 05:24:44.189
494	::ffff:206.168.34.62	Mozilla/5.0 (compatible; CensysInspect/1.1; +https://about.censys.io/)	/	\N	2026-01-19 05:58:48.265
495	::ffff:185.216.75.69	unknown	/	\N	2026-01-19 08:15:18.601
496	::ffff:216.180.246.188	'Mozilla/5.0 (compatible; GenomeCrawlerd/1.0; +https://www.nokia.com/genomecrawler)'	/	\N	2026-01-19 10:09:39.024
497	::ffff:209.38.94.29	Mozilla/5.0	/	\N	2026-01-19 12:13:55.852
498	::ffff:91.231.89.204	Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	/	\N	2026-01-19 21:18:38.638
499	::ffff:127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/121.0.0.0 Safari/537.36	/	\N	2026-01-20 01:31:06.979
500	::ffff:3.137.73.221	cypex.ai/scanning Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) Chrome/126.0.0.0 Safari/537.36	/	\N	2026-01-20 04:02:07.672
501	::ffff:209.38.94.78	Mozilla/5.0	/	\N	2026-01-20 04:41:47.193
502	::ffff:162.142.125.39	unknown	/	\N	2026-01-20 05:23:23.488
503	::ffff:203.55.131.5	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36	/	\N	2026-01-20 08:36:40.294
504	::ffff:134.199.169.17	Mozilla/5.0	/	\N	2026-01-20 14:58:53.454
505	::ffff:104.152.52.208	curl/7.61.1	/	\N	2026-01-20 15:23:49.319
506	::ffff:134.199.168.136	Mozilla/5.0	/	\N	2026-01-20 19:24:14.313
507	::ffff:127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36	/	\N	2026-01-21 00:16:07.993
508	::ffff:3.143.33.63	cypex.ai/scanning Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) Chrome/126.0.0.0 Safari/537.36	/	\N	2026-01-21 04:03:51.941
509	::ffff:172.236.228.227	Mozilla/5.0 (Macintosh; Intel Mac OS X 13_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36	/	\N	2026-01-21 04:36:45.022
510	::ffff:199.45.154.121	unknown	/	\N	2026-01-21 05:14:57.373
511	::ffff:206.168.34.50	Mozilla/5.0 (compatible; CensysInspect/1.1; +https://about.censys.io/)	/	\N	2026-01-21 06:00:17.553
512	::ffff:185.247.137.183	Mozilla/5.0 (compatible; InternetMeasurement/1.0; +https://internet-measurement.com/)	/	\N	2026-01-21 09:28:16.001
513	::ffff:185.226.197.54	Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.117 Safari/537.36	/	\N	2026-01-21 22:00:02.156
514	::ffff:198.58.117.211	unknown	/	\N	2026-01-21 23:35:20.585
515	::ffff:127.0.0.1	Mozilla/5.0 (compatible; Barkrowler/0.9; +https://babbar.tech/crawler)	/	\N	2026-01-22 02:11:25.937
516	::ffff:3.134.148.59	cypex.ai/scanning Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) Chrome/126.0.0.0 Safari/537.36	/	\N	2026-01-22 05:07:09.358
517	::ffff:66.132.153.130	Mozilla/5.0 (compatible; CensysInspect/1.1; +https://about.censys.io/)	/	\N	2026-01-22 06:59:14.85
518	::ffff:66.132.153.132	unknown	/	\N	2026-01-22 07:17:36.122
519	::ffff:209.38.94.255	Mozilla/5.0	/	\N	2026-01-22 10:51:17.368
520	::ffff:127.0.0.1	Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.7499.192 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)	/about	\N	2026-01-23 01:16:44.808
521	::ffff:36.156.22.4	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4 240.111 Safari/537.36	/	\N	2026-01-23 02:03:43.009
522	::ffff:199.45.154.154	unknown	/	\N	2026-01-23 06:47:29.499
523	::ffff:128.203.203.4	Mozilla/5.0 zgrab/0.x	/	\N	2026-01-23 13:09:10.021
524	::ffff:91.231.89.80	Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	/	\N	2026-01-23 13:59:08.745
525	::ffff:18.97.5.55	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36	/	\N	2026-01-23 18:48:27.91
526	::ffff:207.90.244.14	unknown	/	\N	2026-01-23 19:47:48.209
527	::ffff:127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	/study-abbroad-list	\N	2026-01-24 00:09:58.626
528	::ffff:199.45.154.125	unknown	/	\N	2026-01-24 05:43:09.892
529	::ffff:87.236.176.73	Mozilla/5.0 (compatible; InternetMeasurement/1.0; +https://internet-measurement.com/)	/	\N	2026-01-24 08:25:00.385
530	::ffff:35.195.168.139	python-requests/2.32.5	/	\N	2026-01-24 11:22:01.14
531	::ffff:80.87.206.63	python-requests/2.31.0	/	\N	2026-01-24 20:15:44.652
532	::ffff:127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36	/	\N	2026-01-25 00:19:25.669
533	::ffff:3.132.23.201	cypex.ai/scanning Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) Chrome/126.0.0.0 Safari/537.36	/	\N	2026-01-25 01:50:33.386
534	::ffff:216.180.246.14	'Mozilla/5.0 (compatible; GenomeCrawlerd/1.0; +https://www.nokia.com/genomecrawler)'	/	\N	2026-01-25 04:06:07.002
535	::ffff:172.236.228.197	Mozilla/5.0 (Macintosh; Intel Mac OS X 13_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36	/	\N	2026-01-25 05:02:23.779
536	::ffff:206.168.34.194	unknown	/	\N	2026-01-25 05:42:59.994
537	::ffff:66.132.153.122	Mozilla/5.0 (compatible; CensysInspect/1.1; +https://about.censys.io/)	/	\N	2026-01-25 05:55:26.963
538	::ffff:170.64.168.249	Mozilla/5.0	/	\N	2026-01-25 18:07:24.262
539	::ffff:127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.3	/	\N	2026-01-26 00:08:46.537
540	::ffff:3.134.148.59	cypex.ai/scanning Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) Chrome/126.0.0.0 Safari/537.36	/	\N	2026-01-26 01:29:36.792
541	::ffff:162.142.125.39	unknown	/	\N	2026-01-26 05:16:29.544
542	::ffff:170.64.229.147	Mozilla/5.0	/	\N	2026-01-26 06:57:07.986
543	::ffff:170.64.168.249	Mozilla/5.0	/	\N	2026-01-26 09:23:51.676
544	::ffff:110.177.181.130	unknown	/	\N	2026-01-26 11:19:00.062
545	::ffff:122.96.28.5	Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36	/	\N	2026-01-26 11:19:24.456
546	::ffff:91.231.89.106	Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	/	\N	2026-01-26 16:24:43.302
547	::ffff:79.127.221.66	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36	/	\N	2026-01-26 18:10:30.687
548	::ffff:37.19.216.146	Mozilla/5.0 (Macintosh; Intel Mac OS X 11_0_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.88 Safari/537.36	/	\N	2026-01-26 18:10:35.04
549	::ffff:170.64.234.63	Mozilla/5.0	/	\N	2026-01-27 00:45:59.608
550	::ffff:127.0.0.1	Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.3; +https://openai.com/gptbot)	/	\N	2026-01-27 01:23:34.235
551	::ffff:3.149.59.26	cypex.ai/scanning Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) Chrome/126.0.0.0 Safari/537.36	/	\N	2026-01-27 02:19:05.023
552	::ffff:206.168.34.55	Mozilla/5.0 (compatible; CensysInspect/1.1; +https://about.censys.io/)	/	\N	2026-01-27 06:02:31.64
553	::ffff:209.38.18.80	Mozilla/5.0	/	\N	2026-01-27 06:41:07.666
554	::ffff:162.142.125.127	unknown	/	\N	2026-01-27 07:12:27.925
555	::ffff:216.180.246.95	'Mozilla/5.0 (compatible; GenomeCrawlerd/1.0; +https://www.nokia.com/genomecrawler)'	/	\N	2026-01-27 07:18:05.371
556	::ffff:170.64.229.147	Mozilla/5.0	/	\N	2026-01-27 10:13:55.188
557	::ffff:104.152.52.223	curl/7.61.1	/	\N	2026-01-27 15:33:33.065
558	::ffff:87.236.176.112	Mozilla/5.0 (compatible; InternetMeasurement/1.0; +https://internet-measurement.com/)	/	\N	2026-01-27 16:11:35.604
559	::ffff:127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	/	http://poniaganetworking.com	2026-01-28 04:12:46.096
560	::ffff:162.142.125.47	Mozilla/5.0 (compatible; CensysInspect/1.1; +https://about.censys.io/)	/	\N	2026-01-28 08:00:45.537
561	::ffff:178.175.132.162	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	/	\N	2026-01-28 08:53:23.091
562	::ffff:199.45.154.127	unknown	/	\N	2026-01-28 09:33:17.849
563	::ffff:170.64.237.227	Mozilla/5.0	/	\N	2026-01-28 21:35:16.81
564	::ffff:127.0.0.1	Mozilla/5.0 (compatible; AhrefsBot/7.0; +http://ahrefs.com/robot/)	/	\N	2026-01-29 01:44:16.906
565	::ffff:103.255.66.122	Go-http-client/1.1	/	\N	2026-01-29 03:09:36.215
566	::ffff:66.228.53.157	Mozilla/5.0 (Macintosh; Intel Mac OS X 13_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36	/	\N	2026-01-29 04:32:09.796
567	::ffff:45.79.211.97	Mozilla/5.0 zgrab/0.x	/	\N	2026-01-29 04:35:30.751
568	::ffff:66.228.53.46	Mozilla/5.0 (Macintosh; Intel Mac OS X 13_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36	/	\N	2026-01-29 04:35:36.191
569	::ffff:3.130.96.91	cypex.ai/scanning Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) Chrome/126.0.0.0 Safari/537.36	/	\N	2026-01-29 06:16:59.728
570	::ffff:85.217.149.5	Mozilla/5.0 (compatible; ModatScanner/1.2; +https://modat.io/)	/	\N	2026-01-29 06:31:44.468
571	::ffff:162.142.125.216	Mozilla/5.0 (compatible; CensysInspect/1.1; +https://about.censys.io/)	/	\N	2026-01-29 09:52:20.529
572	::ffff:66.132.153.135	unknown	/	\N	2026-01-29 11:45:32.017
573	::ffff:203.55.131.4	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36	/	\N	2026-01-30 01:40:31.672
574	::ffff:127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36	/	\N	2026-01-30 04:01:01.982
575	::ffff:3.143.33.63	cypex.ai/scanning Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) Chrome/126.0.0.0 Safari/537.36	/	\N	2026-01-30 05:33:21.097
576	::ffff:167.94.138.201	Mozilla/5.0 (compatible; CensysInspect/1.1; +https://about.censys.io/)	/	\N	2026-01-30 13:02:40.03
577	::ffff:199.45.154.131	unknown	/	\N	2026-01-30 15:23:42.317
578	::ffff:20.172.70.65	Mozilla/5.0 zgrab/0.x	/	\N	2026-01-30 18:21:38.577
579	::ffff:87.236.176.178	Mozilla/5.0 (compatible; InternetMeasurement/1.0; +https://internet-measurement.com/)	/	\N	2026-01-31 01:11:23.529
580	::ffff:127.0.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:103.0) Gecko/20100101 Firefox/103.0	/	\N	2026-01-31 01:30:17.586
581	::ffff:3.137.73.221	cypex.ai/scanning Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) Chrome/126.0.0.0 Safari/537.36	/	\N	2026-01-31 06:25:39.177
582	::ffff:34.76.134.123	python-requests/2.32.5	/	\N	2026-01-31 07:21:00.023
583	::ffff:167.94.146.58	unknown	/	\N	2026-01-31 08:33:15.386
584	::ffff:139.144.52.241	unknown	/	\N	2026-01-31 10:40:06.21
585	::ffff:127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 15_7_3) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.0 Safari/605.1.15	/	http://www.poniaga.netjtz.tech/	2026-02-01 00:22:28.64
586	::ffff:85.11.183.6	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	/	\N	2026-02-01 03:39:46.108
587	::ffff:199.45.154.119	unknown	/	\N	2026-02-01 05:13:08.739
588	::ffff:209.38.88.27	Mozilla/5.0	/	\N	2026-02-01 05:25:03.988
589	::ffff:192.155.90.220	Mozilla/5.0 (Macintosh; Intel Mac OS X 13_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36	/	\N	2026-02-01 06:44:13.331
590	::ffff:3.137.73.221	cypex.ai/scanning Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) Chrome/126.0.0.0 Safari/537.36	/	\N	2026-02-01 06:46:11.273
591	::ffff:3.134.148.59	cypex.ai/scanning Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) Chrome/126.0.0.0 Safari/537.36	/	\N	2026-02-01 07:25:19.821
592	::ffff:98.80.4.110	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36	/	\N	2026-02-01 21:34:02.252
593	::ffff:127.0.0.1	Mozilla/5.0	/	\N	2026-02-02 00:13:55.779
594	::ffff:167.94.138.53	unknown	/	\N	2026-02-02 05:23:32.318
595	::ffff:162.142.125.125	Mozilla/5.0 (compatible; CensysInspect/1.1; +https://about.censys.io/)	/	\N	2026-02-02 05:56:28.909
596	::ffff:3.130.96.91	cypex.ai/scanning Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) Chrome/126.0.0.0 Safari/537.36	/	\N	2026-02-02 06:20:46.85
597	::ffff:87.236.176.35	Mozilla/5.0 (compatible; InternetMeasurement/1.0; +https://internet-measurement.com/)	/	\N	2026-02-02 10:11:43.297
598	::ffff:91.231.89.84	Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	/	\N	2026-02-02 16:27:03.419
599	::ffff:206.123.145.68	Shodan-Pull/1.0	/	\N	2026-02-02 17:46:36.698
600	::ffff:116.172.249.58	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/121.0.0.0 Safari/537.36	/	\N	2026-02-02 19:42:47.172
601	::ffff:127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36	/	\N	2026-02-03 02:02:55.633
602	::ffff:185.247.137.201	Mozilla/5.0 (compatible; InternetMeasurement/1.0; +https://internet-measurement.com/)	/	\N	2026-02-03 03:16:35.05
603	::ffff:66.132.153.123	unknown	/	\N	2026-02-03 05:40:20.639
604	::ffff:104.152.52.226	curl/7.61.1	/	\N	2026-02-03 15:27:21.327
605	::ffff:165.154.182.207	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36 Edg/120.0.0.0	/	\N	2026-02-03 18:51:18.48
606	::ffff:127.0.0.1	curl/8.7.1	/	\N	2026-02-04 00:06:50.665
607	::ffff:204.76.203.210	Mozilla/5.0	/	\N	2026-02-04 01:00:42.679
608	::ffff:192.227.159.123	Mozilla/5.0 (Macintosh; Intel Mac OS X 15_7_3) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.0 Safari/605.1.15	/	\N	2026-02-04 01:15:48.405
609	::ffff:85.217.149.27	Mozilla/5.0 (compatible; ModatScanner/1.2; +https://modat.io/)	/	\N	2026-02-04 01:42:01.377
610	::ffff:206.168.34.53	unknown	/	\N	2026-02-04 05:34:20.231
611	::ffff:167.94.138.50	Mozilla/5.0 (compatible; CensysInspect/1.1; +https://about.censys.io/)	/	\N	2026-02-04 05:57:20.751
612	::ffff:182.138.158.171	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36	/	\N	2026-02-04 08:58:01.99
613	::ffff:91.196.152.161	Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	/	\N	2026-02-04 11:12:22.212
614	::ffff:3.138.110.133	visionheight.com/scan Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) Chrome/126.0.0.0 Safari/537.36	/	\N	2026-02-04 13:38:52.723
615	::ffff:18.118.139.166	visionheight.com/scan Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) Chrome/126.0.0.0 Safari/537.36	/	\N	2026-02-04 13:40:41.785
616	::ffff:18.224.180.235	visionheight.com/scan Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) Chrome/126.0.0.0 Safari/537.36	/	\N	2026-02-04 13:41:57.405
617	::ffff:3.21.206.218	visionheight.com/scan Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) Chrome/126.0.0.0 Safari/537.36	/	\N	2026-02-04 16:08:52.875
618	::ffff:3.138.173.150	visionheight.com/scan Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) Chrome/126.0.0.0 Safari/537.36	/	\N	2026-02-04 16:10:11.792
619	::ffff:52.15.101.224	visionheight.com/scan Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) Chrome/126.0.0.0 Safari/537.36	/	\N	2026-02-04 16:13:50.417
620	::ffff:18.224.93.12	visionheight.com/scan Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) Chrome/126.0.0.0 Safari/537.36	/	\N	2026-02-04 18:52:41.78
621	::ffff:18.217.76.163	visionheight.com/scan Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) Chrome/126.0.0.0 Safari/537.36	/	\N	2026-02-04 18:57:30.291
622	::ffff:18.119.110.205	visionheight.com/scan Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) Chrome/126.0.0.0 Safari/537.36	/	\N	2026-02-04 18:59:01.114
623	::ffff:18.116.43.92	visionheight.com/scan Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) Chrome/126.0.0.0 Safari/537.36	/	\N	2026-02-04 21:04:38.821
624	::ffff:3.139.62.152	visionheight.com/scan Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) Chrome/126.0.0.0 Safari/537.36	/	\N	2026-02-04 21:17:56.284
625	::ffff:127.0.0.1	Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)	/	\N	2026-02-05 00:24:38.388
626	::ffff:45.79.115.134	Mozilla/5.0 zgrab/0.x	/	\N	2026-02-05 03:33:45.633
627	::ffff:172.236.228.245	Mozilla/5.0 (Macintosh; Intel Mac OS X 13_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36	/	\N	2026-02-05 03:33:51.189
628	::ffff:199.45.155.92	unknown	/	\N	2026-02-05 05:19:47.379
629	::ffff:85.217.149.10	Mozilla/5.0 (compatible; ModatScanner/1.2; +https://modat.io/)	/	\N	2026-02-05 05:40:22.169
630	::ffff:185.180.141.68	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.113 Safari/537.36	/	\N	2026-02-05 09:55:13.874
631	::ffff:87.236.176.203	Mozilla/5.0 (compatible; InternetMeasurement/1.0; +https://internet-measurement.com/)	/	\N	2026-02-05 21:07:24.294
632	::ffff:127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3	/	\N	2026-02-06 00:56:06.232
633	::ffff:199.45.155.99	unknown	/	\N	2026-02-06 05:45:34.401
634	::ffff:206.168.34.222	Mozilla/5.0 (compatible; CensysInspect/1.1; +https://about.censys.io/)	/	\N	2026-02-06 05:58:51.72
635	::ffff:92.63.197.50	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	/	\N	2026-02-06 10:32:47.257
636	::ffff:141.98.82.26	Mozilla/5.0 (Macintosh; Intel Mac OS X 14.3) AppleWebKit/614.31.14 (KHTML, like Gecko) Version/17.0.96 Safari/614.31.14	/	\N	2026-02-06 20:33:34.543
637	::ffff:20.163.74.182	Mozilla/5.0 zgrab/0.x	/	\N	2026-02-07 01:34:35.982
638	::ffff:127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	/	http://poniaganetworking.com	2026-02-07 01:42:15.026
639	::ffff:162.142.125.35	Mozilla/5.0 (compatible; CensysInspect/1.1; +https://about.censys.io/)	/	\N	2026-02-07 07:08:31.339
640	::ffff:85.217.149.3	Mozilla/5.0 (compatible; ModatScanner/1.2; +https://modat.io/)	/	\N	2026-02-07 07:11:51.01
641	::ffff:3.129.58.48	visionheight.com/scan Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) Chrome/126.0.0.0 Safari/537.36	/	\N	2026-02-07 10:51:52.188
642	::ffff:3.137.194.242	visionheight.com/scan Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) Chrome/126.0.0.0 Safari/537.36	/	\N	2026-02-07 10:59:56.527
643	::ffff:3.135.20.78	visionheight.com/scan Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) Chrome/126.0.0.0 Safari/537.36	/	\N	2026-02-07 11:01:33.286
644	::ffff:167.94.138.50	unknown	/	\N	2026-02-07 16:24:55.342
645	::ffff:127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	/	http://poniaganetworking.com	2026-02-08 00:11:53.76
646	::ffff:71.6.134.235	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36	/	\N	2026-02-08 10:27:17.357
647	::ffff:18.191.106.209	visionheight.com/scan Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) Chrome/126.0.0.0 Safari/537.36	/	\N	2026-02-08 12:47:35.732
648	::ffff:167.94.138.179	unknown	/	\N	2026-02-08 13:23:43.121
649	::ffff:204.76.203.210	Mozilla/5.0	/	\N	2026-02-08 18:41:12.964
650	::ffff:87.236.176.196	Mozilla/5.0 (compatible; InternetMeasurement/1.0; +https://internet-measurement.com/)	/	\N	2026-02-08 22:24:04.476
651	::ffff:71.6.146.186	unknown	/	\N	2026-02-09 00:09:22.234
652	::ffff:127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36	/	\N	2026-02-09 01:23:09.528
653	::ffff:172.236.119.165	Mozilla/5.0 (Macintosh; Intel Mac OS X 13_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36	/	\N	2026-02-09 04:26:51.426
654	::ffff:3.147.57.192	visionheight.com/scan Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) Chrome/126.0.0.0 Safari/537.36	/	\N	2026-02-09 04:44:36.665
655	::ffff:85.217.149.13	Mozilla/5.0 (compatible; ModatScanner/1.2; +https://modat.io/)	/	\N	2026-02-09 08:42:07.619
656	::ffff:199.45.155.105	unknown	/	\N	2026-02-09 11:58:19.702
657	::ffff:45.148.10.244	unknown	/	\N	2026-02-09 16:43:57.894
658	::ffff:204.76.203.210	Mozilla/5.0	/	\N	2026-02-09 20:35:08.601
659	::ffff:127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.51 Safari/537.36 Edg/99.0.1150.30	/	https://www.google.com	2026-02-10 00:21:25.651
660	::ffff:3.131.220.121	visionheight.com/scan Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) Chrome/126.0.0.0 Safari/537.36	/	\N	2026-02-10 04:59:12.283
661	::ffff:34.76.210.200	python-requests/2.32.5	/	\N	2026-02-10 05:54:23.434
662	::ffff:35.233.86.238	python-requests/2.32.5	/	\N	2026-02-10 05:57:48.146
663	::ffff:71.6.134.234	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36	/	\N	2026-02-10 06:02:31.143
664	::ffff:146.19.24.133	unknown	/	\N	2026-02-10 10:30:58.365
665	::ffff:162.142.125.124	Mozilla/5.0 (compatible; CensysInspect/1.1; +https://about.censys.io/)	/	\N	2026-02-10 13:02:57.348
666	::ffff:152.32.199.20	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36 Edg/120.0.0.0	/	\N	2026-02-10 14:38:39.025
667	::ffff:104.152.52.236	curl/7.61.1	/	\N	2026-02-10 16:36:27.31
668	::ffff:71.6.146.130	unknown	/	\N	2026-02-10 18:00:18.178
669	::ffff:199.45.154.131	unknown	/	\N	2026-02-10 19:58:40.048
670	::ffff:87.236.176.164	Mozilla/5.0 (compatible; InternetMeasurement/1.0; +https://internet-measurement.com/)	/	\N	2026-02-10 22:02:37.445
671	::ffff:127.0.0.1	Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.7559.132 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)	/	\N	2026-02-11 00:09:09.729
672	::ffff:124.198.131.61	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/42.0.2311.135 Safari/537.36 Edge/12.246	/	\N	2026-02-11 05:54:21.758
673	unknown	Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:71.0) Gecko/20100101 Firefox/71.0	/	\N	2026-02-11 05:54:27.852
674	::ffff:16.58.56.214	visionheight.com/scan Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) Chrome/126.0.0.0 Safari/537.36	/	\N	2026-02-11 09:20:37.964
675	::ffff:85.217.149.19	Mozilla/5.0 (compatible; ModatScanner/1.2; +https://modat.io/)	/	\N	2026-02-11 10:36:20.186
676	::ffff:35.195.168.139	python-requests/2.32.5	/	\N	2026-02-11 11:03:22.043
677	::ffff:185.247.137.135	Mozilla/5.0 (compatible; InternetMeasurement/1.0; +https://internet-measurement.com/)	/	\N	2026-02-11 18:16:29.298
678	::ffff:167.94.138.166	Mozilla/5.0 (compatible; CensysInspect/1.1; +https://about.censys.io/)	/	\N	2026-02-11 21:01:08.396
679	::ffff:127.0.0.1	Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.3; +https://openai.com/gptbot)	/	\N	2026-02-12 00:23:52.058
680	::ffff:123.160.223.72	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36	/	\N	2026-02-12 01:34:55.418
681	::ffff:47.251.118.89	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36	/	\N	2026-02-12 01:34:58.197
682	::ffff:123.160.223.75	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36	/	\N	2026-02-12 01:35:07.712
683	::ffff:47.89.246.29	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36	/	\N	2026-02-12 01:35:15.122
684	::ffff:199.45.154.155	unknown	/	\N	2026-02-12 02:16:05.3
685	::ffff:91.230.168.95	Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	/	\N	2026-02-12 02:26:04.497
686	::ffff:3.130.168.2	visionheight.com/scan Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) Chrome/126.0.0.0 Safari/537.36	/	\N	2026-02-12 04:30:53.265
687	::ffff:104.244.79.113	Mozilla/5.0	/	\N	2026-02-12 14:32:43.142
688	::ffff:71.6.167.142	unknown	/	\N	2026-02-12 17:01:42.609
689	::ffff:94.102.49.193	unknown	/	\N	2026-02-12 18:57:27.308
690	::ffff:199.45.155.100	unknown	/	\N	2026-02-12 21:31:25.657
691	::ffff:45.79.207.111	Mozilla/5.0 zgrab/0.x	/	\N	2026-02-13 03:33:10.445
692	::ffff:172.236.228.115	Mozilla/5.0 (Macintosh; Intel Mac OS X 13_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36	/	\N	2026-02-13 03:33:15.381
693	::ffff:127.0.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36	/	\N	2026-02-13 05:49:43.082
694	::ffff:3.129.187.38	visionheight.com/scan Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) Chrome/126.0.0.0 Safari/537.36	/	\N	2026-02-13 06:22:44.749
695	::ffff:146.19.24.133	unknown	/	\N	2026-02-13 09:01:17.882
696	::ffff:138.197.143.27	unknown	/	\N	2026-02-13 10:42:13.296
697	::ffff:85.217.149.20	Mozilla/5.0 (compatible; ModatScanner/1.2; +https://modat.io/)	/	\N	2026-02-13 11:54:07.169
698	::ffff:35.187.31.145	python-requests/2.32.5	/	\N	2026-02-13 12:15:26.852
699	::ffff:167.94.146.61	unknown	/	\N	2026-02-13 17:54:37.257
700	::ffff:127.0.0.1	Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.72 YaBrowser/21.5.1.355 Yowser/2.5 Safari/537.36	/	\N	2026-02-14 03:11:22.748
701	::ffff:20.64.104.93	Mozilla/5.0 zgrab/0.x	/	\N	2026-02-14 09:44:09.295
702	::ffff:167.94.146.55	unknown	/	\N	2026-02-14 15:34:20.593
703	::ffff:87.236.176.112	Mozilla/5.0 (compatible; InternetMeasurement/1.0; +https://internet-measurement.com/)	/	\N	2026-02-14 23:41:42.209
704	::ffff:127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36	/	\N	2026-02-15 03:24:04.159
705	::ffff:172.232.9.106	unknown	/	\N	2026-02-15 09:14:41.693
706	::ffff:35.205.235.254	python-requests/2.32.5	/	\N	2026-02-15 10:50:04.72
707	::ffff:207.90.244.28	unknown	/	\N	2026-02-15 12:01:28.472
708	::ffff:199.45.155.93	unknown	/	\N	2026-02-15 12:19:04.082
709	::ffff:85.217.149.0	Mozilla/5.0 (compatible; ModatScanner/1.2; +https://modat.io/)	/	\N	2026-02-15 12:50:02.881
710	::ffff:18.218.118.203	visionheight.com/scan Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) Chrome/126.0.0.0 Safari/537.36	/	\N	2026-02-15 21:15:04.872
711	::ffff:127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1	/	http://poniaganetworking.com	2026-02-16 00:57:13.094
712	::ffff:98.80.4.99	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36	/	\N	2026-02-16 01:35:04.975
713	::ffff:45.194.92.11	unknown	/	\N	2026-02-16 09:26:11.164
714	::ffff:199.45.154.113	unknown	/	\N	2026-02-16 10:37:35.392
715	::ffff:35.233.5.189	python-requests/2.32.5	/	\N	2026-02-16 10:59:59.447
716	::ffff:71.6.199.23	unknown	/	\N	2026-02-16 11:29:36.956
717	::ffff:3.130.168.2	visionheight.com/scan Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) Chrome/126.0.0.0 Safari/537.36	/	\N	2026-02-16 13:10:27.54
718	::ffff:207.90.244.28	unknown	/	\N	2026-02-16 14:32:44.154
719	::ffff:91.231.89.219	Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	/	\N	2026-02-16 16:28:26.88
720	::ffff:127.0.0.1	Go-http-client/1.1	/	http://poniaganetworking.com	2026-02-17 00:38:39.806
721	::ffff:207.90.244.14	unknown	/	\N	2026-02-17 00:55:25.213
722	::ffff:172.236.228.193	Mozilla/5.0 (Macintosh; Intel Mac OS X 13_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36	/	\N	2026-02-17 04:20:09.431
723	::ffff:167.94.138.203	Mozilla/5.0 (compatible; CensysInspect/1.1; +https://about.censys.io/)	/	\N	2026-02-17 06:11:17.952
724	::ffff:91.230.168.195	Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0	/	\N	2026-02-17 06:35:12.17
725	::ffff:3.131.220.121	visionheight.com/scan Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) Chrome/126.0.0.0 Safari/537.36	/	\N	2026-02-17 13:20:28.331
726	::ffff:85.217.149.28	Mozilla/5.0 (compatible; ModatScanner/1.2; +https://modat.io/)	/	\N	2026-02-17 13:23:57.328
727	::ffff:104.152.52.113	curl/7.61.1	/	\N	2026-02-17 15:53:44.064
728	::ffff:87.236.176.116	Mozilla/5.0 (compatible; InternetMeasurement/1.0; +https://internet-measurement.com/)	/	\N	2026-02-17 18:26:03.025
729	::ffff:87.236.176.12	Mozilla/5.0 (compatible; InternetMeasurement/1.0; +https://internet-measurement.com/)	/	\N	2026-02-17 22:13:05.678
730	::ffff:127.0.0.1	Mozilla/5.0 (compatible; InternetMeasurement/1.0; +https://internet-measurement.com/)	/	\N	2026-02-18 01:08:35.8
731	::ffff:34.38.246.252	python-requests/2.32.5	/	\N	2026-02-18 01:32:00.235
732	::ffff:35.195.185.167	python-requests/2.32.5	/	\N	2026-02-18 02:04:18.761
733	::ffff:87.121.84.24	unknown	/	\N	2026-02-18 04:34:33.273
734	::ffff:66.132.153.136	unknown	/	\N	2026-02-18 05:18:20.744
735	::ffff:146.190.63.248	Mozilla/5.0 (l9scan/2.0.234323e2035323e2633323e2430313; +https://leakix.net)	/	\N	2026-02-18 13:29:21.331
736	::ffff:3.129.187.38	visionheight.com/scan Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) Chrome/126.0.0.0 Safari/537.36	/	\N	2026-02-18 18:34:26.108
737	::ffff:127.0.0.1	Mozilla/5.0 (iPhone; CPU iPhone OS 17_3_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.3.1 Mobile/15E148 Safari/604	/	http://poniaganetworking.com/	2026-02-19 00:40:07.647
738	::ffff:185.180.141.59	Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.117 Safari/537.36	/	\N	2026-02-19 01:11:48.333
739	::ffff:45.79.115.59	Mozilla/5.0 zgrab/0.x	/	\N	2026-02-19 04:33:45.111
740	::ffff:45.79.181.104	Mozilla/5.0 (Macintosh; Intel Mac OS X 13_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36	/	\N	2026-02-19 05:07:01.053
741	::ffff:167.94.146.51	unknown	/	\N	2026-02-19 05:11:53.819
742	::ffff:206.168.34.40	Mozilla/5.0 (compatible; CensysInspect/1.1; +https://about.censys.io/)	/	\N	2026-02-19 05:57:52.232
743	::ffff:167.94.138.37	Mozilla/5.0 (compatible; CensysInspect/1.1; +https://about.censys.io/)	/	\N	2026-02-19 05:59:25.153
744	::ffff:85.11.182.23	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36	/	\N	2026-02-19 07:56:35.273
745	::ffff:85.217.149.38	Mozilla/5.0 (compatible; ModatScanner/1.2; +https://modat.io/)	/	\N	2026-02-19 17:05:59.462
746	::ffff:3.131.220.121	visionheight.com/scan Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) Chrome/126.0.0.0 Safari/537.36	/	\N	2026-02-19 19:56:47.654
\.


--
-- Name: admins_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.admins_id_seq', 1, true);


--
-- Name: applications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.applications_id_seq', 2, true);


--
-- Name: contacts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.contacts_id_seq', 60, true);


--
-- Name: jobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.jobs_id_seq', 16, true);


--
-- Name: scholarship_applications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.scholarship_applications_id_seq', 1, false);


--
-- Name: scholarships_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.scholarships_id_seq', 10, true);


--
-- Name: team_members_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.team_members_id_seq', 3, true);


--
-- Name: visitors_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.visitors_id_seq', 746, true);


--
-- Name: _prisma_migrations _prisma_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public._prisma_migrations
    ADD CONSTRAINT _prisma_migrations_pkey PRIMARY KEY (id);


--
-- Name: admins admins_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admins
    ADD CONSTRAINT admins_pkey PRIMARY KEY (id);


--
-- Name: applications applications_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.applications
    ADD CONSTRAINT applications_pkey PRIMARY KEY (id);


--
-- Name: contacts contacts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contacts
    ADD CONSTRAINT contacts_pkey PRIMARY KEY (id);


--
-- Name: jobs jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jobs
    ADD CONSTRAINT jobs_pkey PRIMARY KEY (id);


--
-- Name: scholarship_applications scholarship_applications_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scholarship_applications
    ADD CONSTRAINT scholarship_applications_pkey PRIMARY KEY (id);


--
-- Name: scholarships scholarships_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scholarships
    ADD CONSTRAINT scholarships_pkey PRIMARY KEY (id);


--
-- Name: team_members team_members_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.team_members
    ADD CONSTRAINT team_members_pkey PRIMARY KEY (id);


--
-- Name: visitors visitors_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.visitors
    ADD CONSTRAINT visitors_pkey PRIMARY KEY (id);


--
-- Name: admins_email_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX admins_email_idx ON public.admins USING btree (email);


--
-- Name: admins_email_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX admins_email_key ON public.admins USING btree (email);


--
-- Name: applications_jobId_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "applications_jobId_idx" ON public.applications USING btree ("jobId");


--
-- Name: scholarship_applications_scholarshipId_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "scholarship_applications_scholarshipId_idx" ON public.scholarship_applications USING btree ("scholarshipId");


--
-- Name: visitors_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "visitors_createdAt_idx" ON public.visitors USING btree ("createdAt");


--
-- Name: visitors_ipAddress_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "visitors_ipAddress_idx" ON public.visitors USING btree ("ipAddress");


--
-- Name: applications applications_jobId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.applications
    ADD CONSTRAINT "applications_jobId_fkey" FOREIGN KEY ("jobId") REFERENCES public.jobs(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: scholarship_applications scholarship_applications_scholarshipId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scholarship_applications
    ADD CONSTRAINT "scholarship_applications_scholarshipId_fkey" FOREIGN KEY ("scholarshipId") REFERENCES public.scholarships(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;


--
-- PostgreSQL database dump complete
--

\unrestrict 0jyC5N6C9V0iPJfVhDP64aIstRRPnygJX31sK0dA5f1LOYXkmhT2pvFtiSplhE5


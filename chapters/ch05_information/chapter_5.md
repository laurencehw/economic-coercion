# Information, Standards, and Digital Infrastructure

## Executive Summary

In December 2021, the Biden administration placed eight Chinese technology firms on the Entity List for developing surveillance technology used against Uyghurs in Xinjiang. Among them was SenseTime, one of China's leading artificial intelligence companies, scheduled for a Hong Kong initial public offering worth $767 million. The designation—requiring U.S. government approval for any American technology sales to SenseTime—forced postponement of the IPO and cut the company off from American AI chips, software, and technical support. SenseTime's facial recognition systems, trained on databases of millions of faces and capable of real-time identification across vast camera networks, represented both commercial success (deployed in over 100 Chinese cities) and strategic concern (enabling authoritarian surveillance at unprecedented scale). The Entity List designation signaled American determination to restrict technology enabling human rights abuses while raising fundamental questions: Can democracies compete with authoritarian regimes wielding information technology for social control? Should Western technology companies profit from surveillance states? Can export controls meaningfully constrain information technologies that diffuse rapidly and require primarily software rather than restricted hardware?

SenseTime's predicament illustrates broader dynamics examined in this chapter: the information domain has become a central arena of U.S.-China strategic competition, encompassing cyber operations targeting intellectual property and critical infrastructure, data localization requirements fragmenting the global internet, standards battles determining whose technical specifications govern 5G networks and IoT devices, information warfare campaigns shaping narratives and perceptions, and the emerging "splinternet" where digital ecosystems diverge along geopolitical lines. Unlike the physical supply chain vulnerabilities examined in Chapter 2 or semiconductor chokepoints analyzed in Chapter 4, information domain competition involves intangible assets—data, software, protocols, standards, and narratives—that flow across borders invisibly, replicate costlessly, and resist control through traditional export restrictions.

This informational character creates distinct challenges for economic coercion and strategic competition. A semiconductor fabrication facility requires billions in investment, years to construct, and rare technical expertise; a surveillance algorithm can be copied instantly, modified easily, and deployed globally at negligible marginal cost. Cyber intrusions traverse borders at lightspeed, with attribution challenges and escalation dynamics differing fundamentally from physical conflicts. Data localization laws force foreign firms to build infrastructure and accept regulatory burdens, yet data itself moves through encrypted channels difficult to monitor or restrict. Technology standards battles determine competitive advantages lasting decades, fought in obscure technical committees where geopolitical influence operates through different mechanisms than military or economic power.

Three core arguments organize this chapter's analysis.

First, **the information domain enables economic coercion through mechanisms distinct from traditional trade and financial tools**. Rather than restricting physical goods or financial flows, information domain coercion operates through cyber espionage (stealing intellectual property worth hundreds of billions), data localization mandates (forcing costly infrastructure investments and creating leverage over foreign firms), standards manipulation (designing technical specifications that favor domestic champions), and information operations (shaping public opinion to pressure governments or undermine adversaries). These mechanisms leverage information technology's unique characteristics: low marginal costs of replication, network effects creating winner-take-all dynamics, and difficulties distinguishing legitimate uses from malicious applications. Understanding these mechanisms is essential for policymakers confronting strategic competition increasingly mediated through information infrastructure.

Second, **China's approach to information technology fundamentally challenges Western assumptions about internet openness, free information flows, and global digital connectivity**. Since the 1990s, U.S. policy largely assumed that internet adoption would promote democratization, economic interdependence would constrain authoritarian impulses, and information freedom would erode closed societies. China's trajectory contradicts these assumptions: the Communist Party has demonstrated that authoritarian regimes can harness internet technologies for social control (surveillance systems monitoring populations, content censorship limiting information access, digital payment systems enabling transaction tracking), economic development (e-commerce, fintech, platform economies rivaling Western counterparts), and international influence (exporting surveillance technology, building digital infrastructure through Belt and Road Initiative, promoting "cyber sovereignty" norms challenging Western internet governance). This Chinese model represents not a transitional phase toward Western practices but a coherent alternative vision—"authoritarian digital governance"—with implications for global norms, developing country technology choices, and the future of internet governance.

Third, **standards competition determines long-term strategic advantage by shaping global technology architecture**. When Huawei's 5G specifications become industry standards, telecommunications equipment worldwide must interoperate with Huawei designs, creating vendor lock-in and market advantages lasting decades. When China's face recognition protocols become international standards, Chinese firms gain preferential positions in global surveillance markets. When American internet protocols (TCP/IP, HTTP, DNS) dominated early internet development, American firms enjoyed first-mover advantages and architectural influence. Standards battles occur in technical venues (3GPP for telecommunications, ISO for international standards, ITU for internet governance) where engineers and diplomats negotiate specifications with massive economic and strategic implications yet receive limited public attention. Understanding and engaging in standards competition has become a strategic imperative comparable to industrial policy and export controls.

The chapter proceeds through five main sections. Section 1 examines **cyber operations and espionage**, analyzing state-sponsored intellectual property theft campaigns (including APT1, APT41, and others), critical infrastructure vulnerabilities, attribution challenges complicating deterrence, and effectiveness of sanctions and indictments. Section 2 explores **data localization and digital sovereignty**, examining Chinese data security laws forcing foreign firms to store data domestically, European GDPR creating compliance burdens and potential protectionism, Russia's sovereign internet initiatives, and strategic implications for global internet fragmentation. Section 3 analyzes **technology standards competition**, focusing on 5G standards battles (Huawei versus Ericsson/Nokia/Samsung), IoT and edge computing standards, AI governance frameworks, and mechanisms for winning standards contests. Section 4 investigates **information warfare and influence operations**, examining disinformation campaigns, platform manipulation, narrative control, and challenges distinguishing legitimate speech from malicious information operations. Section 5 addresses the **splinternet and digital fragmentation**, analyzing internet balkanization dynamics, alternative digital infrastructures (China's BeiDou navigation, CIPS payment system), content restriction ecosystems, and implications for global connectivity.

Two case studies apply the analytical framework established in Chapter 1. Case Study 1 examines **China's Great Firewall and digital sovereignty approach**, tracing the technical architecture enabling content censorship, economic implications for foreign firms seeking Chinese market access, effectiveness in controlling information flows, and the model's export to other authoritarian regimes. Case Study 2 analyzes **5G standards competition**, examining Huawei's rise to standards leadership, U.S. and allied responses through exclusion campaigns, European decisions balancing economic and security considerations, and impacts on both immediate 5G deployment and long-term 6G competition.

Two Government Tools Boxes explain American legal authorities for information domain competition. The first covers the **Computer Fraud and Abuse Act (CFAA)** and related cyber authorities, detailing legal frameworks for prosecuting cyber espionage, deterring intrusions through indictments and sanctions, and limitations in enforcement against state-sponsored actors. The second examines **Foreign Investment Risk Review Modernization Act (FIRRMA)** provisions targeting technology sector investments, mandatory declarations for technology deals, and coordination with allied investment screening mechanisms.

A Chinese Perspective Box explores Beijing's concept of **cyber sovereignty** (网络主权, wǎngluò zhǔquán) and **discourse power** (话语权, huàyǔquán)—the ability to shape international narratives and information governance norms. Key concepts include **information security** (信息安全, xìnxī ānquán) emphasizing protection from Western information operations, **digital civilization** (数字文明, shùzì wénmíng) as China's vision for global internet governance, and **technology sovereignty** (科技主权, kējì zhǔquán) justifying restrictions on foreign technology companies. The box examines Chinese perspectives on Western internet governance dominance, concerns about ideological infiltration through foreign platforms, and strategic logic behind digital infrastructure and standards competition.

The information domain represents competition's cutting edge where conventional tools of economic statecraft face limitations. Traditional export controls targeting physical goods struggle to restrict software that crosses borders intangibly. Financial sanctions targeting specific entities encounter difficulties addressing cyber operations conducted through proxies and shell companies with shifting identities. Tariffs and quotas prove irrelevant for digital services delivered through internet connections. This domain requires new conceptual frameworks and policy tools—combining technical measures (cyber defenses, encryption standards), regulatory approaches (data localization responses, platform governance), standards engagement (technical committee participation, allied coordination), and narrative contestation (countering disinformation, promoting democratic technology governance norms). Understanding information domain competition is essential not just for comprehending U.S.-China strategic rivalry but for navigating the broader transformation of economic and security competition in an increasingly digital world.

![Global Subsea Cable Infrastructure](../../figures/fig_03_05_subsea_cables.png)
*Figure 5.1: Global subsea telecommunications cable infrastructure. Over 95% of intercontinental data travels via undersea cables, making landing points and cable routes critical chokepoints for global connectivity. Critical hubs (red) include major data centers and internet exchange points.*

---

## Cyber Operations and Espionage

### The Economics of Cyber Espionage: Strategic IP Theft

Cyber espionage represents economic coercion through intellectual property theft at unprecedented scale. Traditional industrial espionage—agents photographing documents, bribing insiders, recruiting employees—operated at human speed with inherent limitations: each target required dedicated resources, stolen information volume remained modest, and exposure risks constrained operations. Cyber operations transformed this calculus: automated tools can penetrate thousands of networks simultaneously, exfiltrate terabytes of data within hours, and operate from jurisdictions beyond law enforcement reach. The economics favor attackers: intrusion operations cost thousands to millions of dollars while stolen intellectual property may be worth billions, and attribution difficulties reduce reputational and punitive costs.

**China's state-sponsored cyber espionage campaigns** exemplify how information technology enables massive economic coercion. U.S. government assessments, private sector security firm investigations, and declassified intelligence consistently identify Chinese government-affiliated groups as conducting systematic intellectual property theft targeting American and allied companies across strategic sectors: aerospace, pharmaceuticals, chemicals, telecommunications, semiconductors, automotive, and energy. These operations persist over years or decades, compromising hundreds of organizations and stealing designs, manufacturing processes, business strategies, and research data worth conservatively hundreds of billions of dollars.

The **APT1 revelations** in 2013 demonstrated the scale and systematization of Chinese cyber espionage. Mandiant (later acquired by FireEye) published detailed technical analysis attributing massive intellectual property theft campaigns to Unit 61398 of the People's Liberation Army, operating from a specific building in Shanghai. The report documented intrusions into 141 organizations across 20 industries, with attackers maintaining persistent access to networks for months or years, exfiltrating confidential data, and demonstrating operational patterns consistent with intelligence collection supporting Chinese industrial policy. Specific examples included:

- Stealing designs for gas pipeline components from a U.S. company, with Chinese state-owned enterprises subsequently producing suspiciously similar products
- Exfiltrating thousands of files from a solar energy company containing trade secrets and manufacturing processes
- Compromising a telecommunications firm and stealing information about network architecture, pricing strategies, and customer data
- Accessing engineering documents from multiple steel manufacturers

The technical sophistication varied—some intrusions exploited zero-day vulnerabilities in commercial software, others relied on spear-phishing emails with malicious attachments leveraging social engineering—but operational persistence and systematic targeting indicated resourced, tasked intelligence operations rather than criminal hackers seeking financial gain.

**APT10, APT41, and successor campaigns** demonstrated that public exposure and U.S. indictments did not halt operations but instead drove tactical adaptations. After the APT1 revelation and 2014 U.S. indictments of five PLA officers for economic espionage, Chinese cyber operations temporarily decreased in volume but soon resumed using new infrastructure, revised tradecraft, and contractors rather than military personnel (providing plausible deniability). APT10, attributed to China's Ministry of State Security, conducted "Operation Cloud Hopper" targeting managed service providers (MSPs)—companies providing IT services to multiple client organizations. By compromising MSPs, attackers gained access to hundreds of downstream clients through trusted channels, enabling espionage at scale with fewer individual intrusions. Targets included aerospace, telecommunications, pharmaceutical, and government contractors.

APT41, a sophisticated group attributed to China's Ministry of State Security contractor Chengdu 404, demonstrated blurred lines between state-sponsored espionage and financially motivated cybercrime. U.S. indictments in 2019 and 2020 accused APT41 of both traditional espionage (targeting defense contractors, telecommunications firms, pharmaceutical companies) and profit-driven intrusions (compromising gaming companies to steal virtual currency, ransomware attacks). This duality complicates attribution and responses: is ransomware attack on a U.S. hospital politically motivated strategic disruption or financially motivated crime? The group's ability to pursue both missions suggests Chinese government tolerance or direction of financially self-sustaining cyber operations—effectively privatizing intelligence collection while maintaining deniability.

**Effectiveness assessment** of cyber espionage as economic coercion reveals complex dynamics. From an immediate Chinese perspective, campaigns have been extraordinarily effective: acquiring intellectual property worth tens or hundreds of billions of dollars, enabling Chinese firms to leapfrog R&D timelines, and supporting indigenous innovation programs (ironically, "indigenous" innovation substantially relies on stolen foreign technology). Examples include:

- High-speed rail development: China acquired Siemens, Bombardier, Kawasaki Heavy Industries, and Alstom technologies through joint venture requirements and cyber espionage, then developed domestic trains competing internationally
- Wind turbine technology: American Superconductor reported Chinese partner Sinovel Wind Group stole proprietary software source code, enabling Sinovel to manufacture turbines without licensing fees
- C-919 aircraft: China's domestic narrowbody airliner incorporated designs and technologies from compromised aerospace contractors
- Pharmaceutical formulations: Multiple Chinese firms accelerated drug development using stolen clinical trial data, manufacturing processes, and molecular designs

From a long-term strategic perspective, effectiveness proves more ambiguous. Stolen technology provides immediate capabilities but creates dependencies: firms relying on espionage rather than organic R&D develop weaker innovation capabilities, struggle to advance beyond stolen technologies, and face quality control challenges (not understanding underlying principles means difficulties troubleshooting failures or adapting designs). American Superconductor's experience illustrates: while Sinovel stole software and avoided licensing fees, Sinovel subsequently struggled with product quality, customer service, and technological advancement—ultimately facing bankruptcy proceedings and losing market share. Chinese aviation still cannot produce competitive jet engines despite decades of espionage targeting Pratt & Whitney, GE Aviation, and Rolls-Royce, suggesting that tacit knowledge and manufacturing expertise resist transfer through data theft alone.

Moreover, cyber espionage imposes costs on perpetrators beyond immediate operational expenses. **Reputational damage** when attribution succeeds creates diplomatic tensions, business obstacles (foreign firms reduce Chinese partnerships), and security cooperation deterioration. The 2015 Xi-Obama agreement nominally committing both countries to refrain from commercial cyber espionage followed sustained U.S. pressure and threatened sanctions—Chinese operations temporarily decreased (though later resumed), suggesting reputational costs can modify behavior even if not eliminating espionage entirely. **Counterintelligence risks** emerge when targeted organizations improve security practices, deploy deception operations (feeding false information to identified intruders), and share threat intelligence—making future operations more difficult and expensive. **Retaliatory capabilities** develop as victims improve defensive and offensive cyber capacities, creating escalation risks where both sides lose more than they gain.

### Critical Infrastructure Vulnerabilities: From Reconnaissance to Potential Disruption

Beyond intellectual property theft, cyber operations targeting critical infrastructure represent perhaps the most concerning dimension of information domain competition. Unlike espionage seeking data exfiltration, infrastructure targeting positions attackers to disrupt essential services—electricity grids, water treatment, telecommunications, financial systems, transportation networks, and healthcare—during crises or conflicts. The strategic logic parallels Cold War nuclear targeting: demonstrating capabilities and pre-positioning access creates deterrent effects and potential coercive leverage, even if never activated.

**Chinese reconnaissance of U.S. critical infrastructure** has been documented across multiple sectors over the past decade. Security firms and U.S. government agencies have attributed persistent intrusions into electric utilities, water systems, natural gas pipelines, and telecommunications networks to Chinese state-sponsored groups. These intrusions often involve reconnaissance—mapping networks, identifying control systems, testing access methods—rather than immediate disruption, suggesting strategic pre-positioning for potential future operations. The 2021 revelation that Chinese-affiliated hackers had accessed U.S. oil and natural gas pipeline systems demonstrated presence in operationally critical networks capable of causing physical disruptions if exploited.

The **Volt Typhoon campaign** disclosed in 2023 exemplified this pre-positioning strategy. Microsoft and U.S. government agencies attributed widespread intrusions across U.S. critical infrastructure—telecommunications, energy, water, and transportation sectors—to a Chinese state-sponsored group focused on maintaining persistent, stealthy access. Unlike traditional espionage campaigns targeting intellectual property, Volt Typhoon operations avoided detection through "living off the land" techniques: using legitimate administrative tools already present in networks rather than custom malware, blending malicious activity with normal operations, and exfiltrating minimal data. The campaign's apparent objective was establishing persistent access enabling future disruption rather than immediate intelligence collection—positioning China to potentially cripple U.S. critical infrastructure during Taiwan Strait or other conflicts.

**Strategic implications** of critical infrastructure vulnerabilities extend beyond immediate disruption risks. Knowledge that adversaries have penetrated essential systems creates **psychological and political effects**: public anxiety about grid failures or water contamination, political pressure on leaders to avoid escalation lest cyber retaliation devastate civilian infrastructure, and deterrent effects where both sides recognize mutual vulnerability. This dynamic creates a form of "cyber mutual assured destruction" analogous to nuclear deterrence—but with crucial differences. Nuclear arsenals are relatively well-understood, physically located, and subject to detection and verification regimes. Cyber capabilities remain secret (attackers don't reveal full access until using it), constantly evolving (new vulnerabilities discovered regularly), and difficult to verify (defensive measures may succeed in removing access, or attackers may have maintained alternative entry points). This opacity creates strategic instability: neither side confidently knows its true vulnerabilities or adversary capabilities, potentially causing either dangerous complacency or paranoid overreaction.

**Deterrence challenges** in critical infrastructure protection differ from traditional military deterrence. Nuclear retaliation is unambiguous and devastating; cyber retaliation faces attribution difficulties (was China responsible for specific infrastructure failure, or did it result from domestic technical issues, criminal hackers, or third-party states?), escalation uncertainties (what cyber attack justifies what military response?), and effectiveness questions (can retaliatory cyber operations impose equivalent costs?). The United States has articulated that cyber attacks causing significant physical damage or casualties could trigger conventional military responses, but thresholds remain deliberately ambiguous—simultaneously attempting to deter attacks while preserving flexibility.

**Defense strategies** for critical infrastructure involve layered approaches combining technical, organizational, and policy measures. **Network segmentation** isolates operational technology (OT) systems controlling physical processes from information technology (IT) networks connected to the internet, reducing attack surfaces. **Zero-trust architectures** require continuous verification rather than assuming internal network traffic is legitimate. **Threat intelligence sharing** through organizations like the Electricity Information Sharing and Analysis Center (E-ISAC) enables collective defense where utilities share indicators of compromise and defensive techniques. **Regulatory requirements** from Department of Homeland Security (NERC CIP standards for electric utilities, TSA directives for pipelines, Sector Risk Management Agencies for various critical infrastructure sectors) mandate minimum security standards, though implementation and enforcement vary.

However, fundamental vulnerabilities persist. Much U.S. critical infrastructure relies on legacy systems designed decades ago without security considerations, operated by private sector entities with varying resources and security maturity. Upgrading industrial control systems proves expensive and risky (shutting down facilities for security improvements creates immediate operational disruptions and costs). The interconnected nature of modern infrastructure means that securing individual assets proves insufficient—attackers can pivot through supply chains, compromise less-secure suppliers or contractors, and exploit trust relationships. Perfect defense appears unattainable; resilience strategies emphasizing rapid recovery rather than prevention increasingly dominate security thinking.

### Attribution Challenges and Deterrence Dilemmas

**Attribution**—confidently identifying who conducted cyber operations—represents a persistent challenge complicating deterrence, retaliation, and norm enforcement in cyberspace. Unlike kinetic attacks where physical evidence, geographic locations, and weapons systems often reveal attackers, cyber operations can route through compromised computers in third countries, employ false flags mimicking adversary techniques, and leverage criminal infrastructure masking state involvement. This attribution difficulty creates a "plausible deniability" space where states conduct operations while maintaining diplomatic pretenses that constraints wouldn't permit for overt actions.

**Technical attribution** involves analyzing malware code, infrastructure (command-and-control servers, domain registrations), operational patterns (working hours suggesting time zones, language artifacts in code comments), and targeting logic (victim selection revealing strategic priorities). Private sector cybersecurity firms (Mandiant, CrowdStrike, Recorded Future, Kaspersky, ESET) have developed sophisticated attribution methodologies, tracking persistent threat actor groups across campaigns, documenting toolsets and techniques, and making public attributions linking activities to specific state intelligence services. These technical attributions often precede official government acknowledgments, creating an interesting dynamic where corporate security researchers effectively conduct open-source intelligence analysis previously reserved for classified government operations.

**Official government attribution** requires higher confidence thresholds and incorporates classified intelligence beyond technical forensics—signals intelligence revealing tasking and reporting, human sources within intelligence services, and clandestine observations of adversary operations. U.S. government attributions typically come through formal statements from FBI, Department of Homeland Security, NSA, or direct presidential attribution. The decision to publicly attribute involves weighing costs (revealing intelligence sources and methods, potentially escalating tensions) against benefits (deterring future operations, building international consensus for responses, demonstrating capabilities to adversaries). Political considerations influence timing and specificity: attribution may be delayed for diplomatic reasons, specificity limited to protect sources, or amplified to justify retaliatory measures.

**Strategic ambiguity and plausible deniability** create advantages for cyber operations that conventional military actions lack. China can orchestrate massive intellectual property theft while officially denying involvement and prosecuting token cases of domestic hackers to demonstrate "commitment" to cyber norms. Russia can disrupt Ukrainian electrical grids while maintaining diplomatic fiction that it doesn't conduct offensive cyber operations. North Korea can steal billions through cryptocurrency heists while diplomatic channels discuss denuclearization. This plausible deniability operates even when technical evidence is overwhelming and government attributions are confident—targets of operations may know with near-certainty who is responsible yet face domestic or international political constraints requiring definitive proof before responding forcefully.

**Deterrence in the absence of reliable attribution** requires strategies distinct from conventional military deterrence. One approach involves **declaratory policies** announcing that cyber attacks will trigger responses regardless of attribution certainty—holding responsible any state whose territory or infrastructure facilitated attacks, even if direct government involvement is unclear. This "safe haven liability" principle appears in U.S. cyber strategy documents but faces practical challenges: many countries lack capacity to police cyber operations from their territory, creating unjust attribution; sophisticated attackers route operations through multiple jurisdictions specifically to implicate innocent third parties; and holding states responsible for all cyber activity originating from their territory sets a precedent that could backfire against the United States (which hosts significant cybercriminal infrastructure despite law enforcement efforts).

**Cost imposition** represents another deterrence approach: raising operational costs for adversaries through improved defenses (making intrusions more expensive), persistent engagement (conducting operations that disrupt adversary infrastructure), and economic consequences (sanctions, export controls, diplomatic isolation) that exceed benefits of cyber operations. The U.S. Cyber Command's "defend forward" and "persistent engagement" strategies emphasize continuous operations to map adversary networks, pre-position access for potential disruption, and impose costs making cyber operations less attractive. However, measuring effectiveness proves difficult—are adversary operations declining because of defensive improvements, or are they simply less observed because attackers improved stealth? Does persistent engagement deter adversaries or simply normalize reciprocal intrusions creating escalation risks?

**International norms and agreements** offer potential paths toward stability but face severe limitations. The 2015 U.S.-China agreement and broader G20 endorsement of norms prohibiting state-sponsored theft of intellectual property for commercial advantage represented rhetorical progress. However, Chinese cyber espionage resumed after temporary decreases, suggesting limited practical impact. The challenge is that cyber norms lack verification mechanisms and enforcement tools: no equivalent exists to nuclear inspection regimes or arms control treaties with intrusive monitoring. States that benefit from cyber operations (China's technology acquisition, Russia's disruption capabilities, North Korea's cryptocurrency theft) have limited incentives for meaningful restraint. Democracies facing public accountability for cyber vulnerabilities may unilaterally constrain operations that authoritarian adversaries pursue freely, creating asymmetric disadvantages.

---

## Data Localization and Digital Sovereignty

### China's Data Security Framework: From Ambiguity to Control

Data localization requirements—mandating that data about domestic citizens or activities be stored within national borders and subject to domestic legal jurisdiction—represent a form of economic coercion with profound implications for global digital integration. These requirements force foreign firms to invest in local infrastructure, subject operations to host government oversight and potential manipulation, and fragment global data flows that have enabled seamless digital services. China's evolving data security legal framework illustrates how information domain policies serve multiple objectives: legitimate privacy and security concerns, protectionist industrial policy favoring domestic firms, and state control over information flows.

**The progression of Chinese data regulation** from ambiguous requirements to comprehensive frameworks spans the past decade. Early regulations were vague and inconsistently enforced: the 2016 Cybersecurity Law nominally required "critical information infrastructure operators" to store data domestically and submit to security reviews, but definitions remained unclear and enforcement selective. Foreign firms operating in China faced uncertainty about compliance requirements, with government agencies providing conflicting guidance and applying rules differently across sectors and firms. This ambiguity itself functioned as leverage—foreign firms uncertain about legal requirements often chose conservative interpretations (localizing data, accepting government access requests) to avoid regulatory troubles.

The **2021 Data Security Law** and **2021 Personal Information Protection Law (PIPL)** represented major steps toward comprehensive data governance frameworks comparable in scope (though not content) to European GDPR. The Data Security Law established hierarchical data classification (core, important, general), required security reviews for data export, and mandated that "critical information infrastructure operators" and firms processing data of over 1 million users undergo security assessments before listing on foreign stock exchanges. The PIPL created consent requirements for data collection, use restrictions, and cross-border transfer limitations—ostensibly protecting citizen privacy but implemented through state control rather than individual rights frameworks typical in Western privacy regulations.

**Critical Information Infrastructure (CII) operator designation** grants Chinese authorities extensive control over firms' data practices and operations. CII status applies to telecommunications, internet services, financial infrastructure, transportation, energy, and water systems—interpreted broadly to encompass major foreign technology firms operating in China. CII operators must:

- Store all data collected in China on servers physically located within Chinese borders
- Submit to annual security reviews conducted by government agencies with broad investigatory powers
- Provide authorities with data access upon request, including encryption keys and source code
- Obtain approval for cross-border data transfers, with regulators retaining discretion to deny requests
- Accept on-site inspections by cybersecurity authorities
- Purchase products and services from approved vendors (often favoring domestic Chinese suppliers)

These requirements create multiple leverage points for Chinese authorities over foreign firms. Compliance costs prove substantial: building Chinese data centers, implementing separate data handling processes for China versus global operations, and undergoing security reviews consume significant resources. More fundamentally, requirements force foreign firms to choose between Chinese market access and protection of intellectual property, user data, and operational independence. Firms that refuse face market exclusion; firms that comply expose sensitive information to Chinese government access and potential theft or manipulation.

**Case examples** illustrate coercive dynamics. LinkedIn, the professional networking platform, operated a localized Chinese version (领英, Lǐngyīng) for years by accepting censorship requirements, storing Chinese user data domestically, and implementing content restrictions. Despite compliance, Chinese authorities repeatedly pressured LinkedIn to expand censorship—blocking activist profiles, removing politically sensitive content, restricting international interactions for Chinese users. In 2021, LinkedIn announced closure of its Chinese social networking service, citing "a significantly more challenging operating environment and greater compliance requirements." The firm would continue offering job listing services in China but abandon social networking features that regulators found problematic—demonstrating limits of compliance when host government demands escalate beyond acceptable bounds.

Microsoft, operating cloud services in China through local partner 21Vianet, implemented elaborate structures attempting to balance Chinese requirements with corporate security standards: physical infrastructure owned and operated by Chinese partner, Microsoft providing technology and support but lacking direct access to Chinese customer data, separate security protocols for Chinese versus global operations. Even these accommodations face persistent tensions as Chinese data laws evolve and regulatory interpretations tighten. Tech firms increasingly question whether Chinese market revenues justify compliance costs, security risks, and reputational damage from association with authoritarian surveillance.

### European GDPR and Digital Protectionism

The European Union's General Data Protection Regulation (GDPR), implemented in May 2018, created the world's most comprehensive data privacy framework—establishing individual rights to data access, correction, deletion, and portability; requiring consent for data collection and use; mandating security protections; and imposing substantial penalties for violations (up to 4% of global annual revenue or €20 million, whichever is greater). GDPR was justified primarily through privacy protection and individual rights rhetoric, but also serves protectionist functions favoring European firms and constraining American technology companies' competitive advantages.

**GDPR's privacy protections** represent genuine advances in individual rights: requiring clear consent rather than opaque terms-of-service agreements, enabling users to access and delete personal data, creating "right to be forgotten" allowing removal of damaging or outdated information from search results, and establishing Data Protection Authorities (DPAs) with enforcement powers. These provisions addressed legitimate concerns about data exploitation by platforms that collected vast personal information with minimal transparency or user control. European regulators argued that American "surveillance capitalism"—business models monetizing user data through targeted advertising—violated fundamental privacy rights and required regulatory constraints.

However, GDPR's **practical implementation** disproportionately burdens foreign firms, particularly American technology companies, creating competitive advantages for European enterprises. Compliance costs prove substantial: hiring data protection officers, implementing consent management systems, restructuring data handling processes, conducting impact assessments, and preparing for regulatory audits. Small and medium enterprises struggle with compliance complexity and costs, but large American technology firms face the most aggressive enforcement. Google has been fined over €8 billion across multiple GDPR violations and antitrust actions; Meta (Facebook) has faced billions in fines for data transfers and privacy violations; Amazon received €746 million fine for data processing practices. European technology firms, while technically subject to the same rules, face less aggressive enforcement and benefit from competitive handicaps imposed on American rivals.

**Cross-border data transfer restrictions** create particularly significant barriers. GDPR prohibits personal data transfers to third countries lacking "adequate" data protection—as determined by European Commission assessments. The United States failed adequacy assessment, creating legal obstacles for trans-Atlantic data flows essential to global digital services. Two successive frameworks attempting to enable U.S.-EU data transfers (Safe Harbor, Privacy Shield) were invalidated by European Court of Justice rulings finding U.S. surveillance practices incompatible with European privacy standards. The 2023 Data Privacy Framework represents a third attempt, but legal challenges persist and future invalidation remains possible.

These restrictions require American firms to implement complex legal mechanisms (Standard Contractual Clauses with additional safeguards, Binding Corporate Rules, explicit consents) adding costs and uncertainty. European firms operating within the EU face no such barriers, creating competitive advantages. Critics argue GDPR functions as **digital protectionism** disguised as privacy protection—using ostensibly neutral regulations to handicap foreign competition while shielding domestic firms. EU officials reject such characterizations, emphasizing that GDPR applies equally to all firms and that American data practices genuinely violate fundamental privacy rights. The debate highlights tensions between legitimate regulatory sovereignty and protectionist trade barriers when digital services cross borders.

**Global influence** of GDPR extends beyond Europe through "Brussels Effect" dynamics where EU regulations become de facto global standards. Multinational firms often implement GDPR-compliant practices globally rather than maintaining separate systems for European versus other markets—spreading European privacy norms worldwide. Countries developing data protection frameworks (Brazil's LGPD, California's CCPA, dozens of others) draw heavily on GDPR models. This regulatory globalization represents European strategic success: shaping global digital governance through domestic regulations backed by market access leverage, compensating for European technology industry weaknesses (few European tech champions competing globally) through regulatory leadership.

### Russia, India, and the Proliferation of Data Localization

Beyond China and Europe, data localization requirements have proliferated globally, with Russia, India, Vietnam, Indonesia, and many others implementing variants. Each regime reflects specific national objectives—ranging from legitimate security and privacy concerns to naked protectionism, authoritarian control, or bargaining leverage over foreign firms.

**Russia's data localization law** (Federal Law No. 242-FZ), effective 2015, requires that operators collecting Russian citizens' personal data record, systematize, accumulate, store, update, and extract such data using databases physically located in Russia. The law applies broadly to internet services, social media platforms, search engines, e-commerce sites, and foreign firms processing Russian user data. Ostensible justifications emphasized national security (protecting Russian data from foreign intelligence surveillance) and sovereignty (ensuring regulatory access to data about Russian citizens). However, implementation revealed ulterior motives: creating leverage over foreign technology firms, forcing infrastructure investments supporting Russian technology sector, and enabling government surveillance of domestic online activities.

LinkedIn refused full compliance with Russian data localization and content restriction demands, leading to 2016 blocking by Roskomnadzor (Russian telecommunications regulator). The ban demonstrated Russia's willingness to exclude foreign platforms refusing compliance, while also revealing limitations: tech-savvy users circumvented blocks through VPNs, LinkedIn's absence created opportunities for Russian professional networking competitors, and the case provided precedent for escalating content and data restrictions. Meta (Facebook, Instagram, WhatsApp), Google (YouTube, search, cloud), Apple, and other foreign firms ultimately complied, building Russian data centers and accepting Roskomnadzor oversight—demonstrating that market access leverage compels compliance when exclusion threatens substantial revenues.

**Russia's 2019 Sovereign Internet Law** further exemplified digital sovereignty pursued through technical and legal measures. The law requires Russian internet service providers to install government-controlled equipment enabling traffic routing through domestic exchange points, creating infrastructure for comprehensive domestic internet isolation from global networks if authorities decide to activate capabilities. Technical implementation faced challenges and full isolation remains implausible, but the law signals intent to establish "sovereign internet" capability enabling disconnection from global internet during crises or conflicts—preventing external information flows and sanctions-related disruptions to domestic internet operations.

**India's data localization initiatives** combine security concerns, industrial policy, and technology sovereignty ambitions. The Reserve Bank of India in 2018 mandated that payment system operators store complete transaction data exclusively in India, forcing Mastercard, Visa, and American Express to build Indian data infrastructure. The broader Personal Data Protection Bill (now Digital Personal Data Protection Act) includes provisions requiring localization of "critical personal data" and restrictions on cross-border transfers, though implementation details and enforcement remain evolving. Indian justifications emphasize data sovereignty (control over data about Indian citizens), economic development (forcing foreign firms to invest in Indian infrastructure and create local jobs), security (preventing foreign intelligence access), and law enforcement access (ensuring authorities can obtain data through domestic legal processes rather than mutual legal assistance treaties with foreign governments).

The **strategic calculations** behind data localization involve tradeoffs. **Benefits** include enhanced regulatory jurisdiction (authorities can compel data access without foreign cooperation), domestic industry support (forced foreign investment and competitive handicaps on global platforms), and population control capabilities (facilitating surveillance and content censorship). **Costs** include substantial economic inefficiencies (fragmenting global data flows increases costs and reduces service quality), security vulnerabilities (dispersing data across many jurisdictions expands attack surfaces), innovation constraints (preventing data aggregation and analysis enabling AI/ML advances), and diplomatic tensions with trading partners viewing localization as protectionist barriers.

Economic analysis suggests data localization imposes net costs: Brookings Institution estimated that data localization policies globally could reduce GDP by 0.7-1.7% through increased IT costs, reduced trade in digital services, and diminished productivity. However, governments pursuing localization prioritize sovereignty, security, and industrial policy over economic efficiency—accepting GDP costs for strategic control. This dynamic parallels Chapter 2's analysis of semiconductor self-sufficiency: economic costs prove acceptable when strategic objectives predominate.

---

## Technology Standards Competition

### Why Standards Matter: Architecture as Strategic Advantage

Technology standards—the technical specifications defining how devices, networks, and systems interoperate—determine market structures, competitive advantages, and strategic dependencies lasting decades. When Huawei's 5G specifications become industry standards adopted by 3GPP (3rd Generation Partnership Project), telecommunications equipment globally must conform to those specifications to achieve interoperability. This creates massive advantages: Huawei's equipment inherently complies with standards the company helped write, competitors face costs adapting to specifications they didn't design, and network effects lock in Huawei's market position as deployed infrastructure creates path dependencies resisting change.

Standards competition operates through mechanisms distinct from market competition or geopolitical contests. **Technical committee processes** in bodies like 3GPP, ITU (International Telecommunication Union), ISO (International Organization for Standardization), IEEE (Institute of Electrical and Electronics Engineers), and IETF (Internet Engineering Task Force) involve engineers proposing specifications, working groups evaluating alternatives, and consensus processes approving standards. This technocratic veneer obscures strategic dimensions: which proposals are advanced, how alternatives are evaluated, whose participation shapes decisions, and what criteria determine adoption all reflect power dynamics and economic interests alongside pure technical merit.

**Chinese standards strategy** has evolved from passive adoption of Western standards to active standards competition pursuing leadership. Early Chinese economic development relied on implementing international standards developed primarily by American, European, and Japanese firms—accepting disadvantageous positions in technology value chains but enabling rapid integration into global manufacturing networks. As Chinese firms' technical capabilities advanced, strategy shifted toward developing indigenous standards (AVS video coding versus MPEG, WAPI wireless security versus Wi-Fi, TD-SCDMA 3G standard) that created protected domestic markets while remaining isolated internationally due to incompatibility with dominant global standards.

The current Chinese approach emphasizes **standards leadership in emerging technologies** where no incumbent dominant standards exist. 5G represents the most prominent success: Huawei contributed more 5G standard-essential patents to 3GPP than any other firm (approximately 15-20% of total), shaping specifications in ways favoring Huawei equipment and establishing technical leadership translated into market dominance. Chinese firms and institutions now actively participate in standards bodies across AI governance, IoT protocols, facial recognition, smart cities infrastructure, and other emerging domains—seeking to replicate 5G successes in shaping global technology architecture.

### The 5G Standards Battle: Huawei's Rise and Western Response

5G wireless technology represents critical infrastructure enabling next-generation applications: ultra-high-definition video streaming, autonomous vehicles, remote surgery, industrial automation, smart cities infrastructure, and ubiquitous IoT connectivity. The firm or nation controlling 5G standards and dominating equipment markets gains advantages extending beyond telecommunications to entire digital economy ecosystems dependent on wireless connectivity. Huawei's emergence as 5G standards leader and dominant equipment supplier created strategic concerns in the United States and allied nations, triggering campaigns to exclude Huawei from critical networks despite technical capabilities and cost advantages.

**Huawei's standards leadership** resulted from sustained technical investment and strategic standards engagement. The company allocated billions annually to R&D (consistently ranking among world's top R&D spenders across all industries), employed tens of thousands of engineers developing wireless technologies, and systematically participated in 3GPP working groups drafting 5G specifications. This technical investment translated to standards influence: Huawei representatives chaired key 3GPP working groups, contributed thousands of technical proposals, and accumulated the largest portfolio of 5G standard-essential patents (SEPs) among all firms. By the time 5G standards were finalized (Release 15 in 2018, Release 16 in 2020), Huawei's technologies were deeply embedded in specifications that all equipment manufacturers must implement for 5G compatibility.

**Market dominance** followed standards leadership. Huawei captured approximately 30% of global telecommunications equipment market share (competing with Ericsson, Nokia, Samsung, and smaller players), with particularly strong positions in Asia, Africa, Middle East, and parts of Europe. Several factors drove Huawei's success beyond standards influence:

- **Cost advantages:** Chinese government support, lower labor costs, and vertically integrated supply chains enabled Huawei to underprice Western competitors by 20-30% for equivalent equipment
- **Performance and features:** Huawei equipment matched or exceeded competitors in technical capabilities, network efficiency, and feature sets
- **Financing packages:** Offering attractive vendor financing through Chinese state banks, particularly appealing to developing nations lacking capital for network upgrades
- **Rapid deployment support:** Providing extensive technical support, training, and integration services accelerating network rollouts

Western telecommunications firms (Ericsson, Nokia) struggled competing against Huawei's combination of technical excellence, cost advantages, and state backing. By 2019, Huawei appeared poised to dominate global 5G deployments, translating standards leadership and market position into enduring competitive advantages.

**U.S. security concerns and exclusion campaigns** targeted Huawei's 5G equipment based on espionage and disruption risks. U.S. intelligence agencies and allied counterparts assessed that Huawei equipment in critical telecommunications networks could enable Chinese government surveillance (intercepting communications, stealing data transiting networks) and disruption (remote shutdown or manipulation of network operations during crises). Several factors intensified concerns specifically about Huawei and 5G:

- **Chinese legal obligations:** National Intelligence Law requiring Chinese firms and citizens to cooperate with intelligence services, creating mandatory compliance with government espionage demands
- **Communist Party influence:** Huawei's internal Party committees and reported intelligence service ties raising questions about independence from state direction
- **Supply chain opacity:** Complexity of equipment and software making comprehensive security audits difficult, creating opportunities for embedded vulnerabilities or backdoors
- **5G architecture:** Unlike previous wireless generations with centralized switching infrastructure, 5G distributes intelligence throughout networks, making Huawei equipment ubiquitous and deeply integrated rather than isolated in specific network segments
- **Software-defined networking:** 5G's reliance on software-controlled network functions enables remote updates and modifications, creating persistent access opportunities for equipment manufacturers

The Trump administration launched aggressive campaigns to exclude Huawei from allied 5G networks, combining domestic restrictions (banning Huawei equipment from U.S. networks, Entity List designation cutting off semiconductor and software supplies) with diplomatic pressure on allies to reject Huawei. Secretary of State Mike Pompeo and other officials conducted extensive international travel explicitly lobbying against Huawei deployments, warning that intelligence sharing with nations deploying Huawei 5G could be curtailed. The campaign achieved mixed results across allied nations.

**Five Eyes intelligence partners** (United States, United Kingdom, Canada, Australia, New Zealand) demonstrated varied responses revealing tensions between security concerns and economic interests. **Australia** banned Huawei from 5G networks in August 2018, becoming the first major economy to implement comprehensive exclusion. Australian intelligence assessments concluded that 5G architecture made distinguishing "core" versus "edge" network components meaningless—Huawei equipment anywhere in networks created unacceptable risks. **New Zealand** followed with restrictions preventing major carriers from using Huawei 5G equipment, though implementation remained less absolute than Australia's.

**United Kingdom** initially attempted a middle path: allowing Huawei participation in 5G but limiting market share to 35%, excluding equipment from "core" network functions and sensitive geographic areas (near military bases, government facilities). The UK's National Cyber Security Centre assessed that risks from Huawei equipment could be managed through technical measures, vendor diversity, and oversight. However, U.S. pressure intensified following January 2020 semiconductor export controls cutting Huawei's access to advanced chips. UK government reversed course in July 2020, announcing complete Huawei exclusion from 5G networks by 2027—demonstrating that U.S. leverage ultimately overcame UK's preferred balanced approach.

**Canada** delayed decisions for years, caught between security partnership with the United States and complex political dynamics involving Huawei CFO Meng Wanzhou's detention in Vancouver (on U.S. extradition request for fraud charges related to Iran sanctions violations) creating Chinese retaliation against Canadian agricultural exports and arbitrary detention of Canadian citizens in China. Canada ultimately banned Huawei and ZTE from 5G networks in May 2022, joining other Five Eyes partners but only after extended deliberation reflecting costs of security alignment.

**European responses** varied widely, with major economies attempting balances between U.S. pressure and commercial interests. **Germany** faced particularly acute tensions: Deutsche Telekom, Vodafone Germany, and Telefónica Deutschland had deployed Huawei 4G equipment extensively and planned continued Huawei use for 5G, generating cost and deployment timeline advantages. German automotive industry relied on Huawei for connected vehicle development. However, U.S. pressure and internal security debates led to restrictions: Huawei not banned outright, but stringent certification requirements, vendor diversity mandates, and exclusion from sensitive applications created de facto limitations. The compromise satisfied neither security hawks (who wanted complete bans) nor Huawei (which faced severe market constraints).

**France** similarly avoided outright bans but implemented security certification processes and encouraged carriers to favor Ericsson and Nokia, effectively limiting Huawei to existing footprint without expansion. **Italy, Spain, and other EU members** maintained Huawei relationships with varying restrictions, balancing security concerns against deployment costs and carrier preferences. The fragmented European response frustrated American officials seeking unified allied exclusion but reflected EU member states' sovereign decisions and economic calculations.

**Effectiveness assessment** of Huawei exclusion campaigns reveals partial success with significant costs:

- **Market impact:** Huawei's international 5G equipment sales declined substantially in developed markets, with lost revenues estimated at tens of billions. However, Huawei maintained strong positions in Asia, Africa, Middle East, and parts of Latin America—particularly countries prioritizing cost and performance over Western security concerns
- **Allied coordination:** Five Eyes partners ultimately aligned on Huawei exclusion (though timing and implementation varied), demonstrating U.S. influence. European fragmentation revealed limits of American leverage when security arguments compete with commercial interests
- **Chinese retaliation:** Limited direct retaliation against Huawei bans, but broader deterioration of technology cooperation and investment relationships imposed mutual costs
- **Innovation impact:** Excluding Huawei reduced competitive pressure on Ericsson and Nokia, potentially slowing innovation and increasing costs for carriers and consumers. Western equipment vendors benefited commercially but faced questions about whether reduced competition would sustain technical leadership
- **Standards influence:** Huawei's standards contributions and patent portfolios remained embedded in 5G specifications regardless of equipment exclusion. Ericsson and Nokia must license Huawei patents and implement Huawei-influenced specifications, limiting exclusion's completeness

### Beyond 5G: IoT, AI Governance, and 6G Standards Competition

The 5G standards battle foreshadows intensifying competition across emerging technology domains where standards remain contested. Chinese firms and government agencies now systematically pursue standards leadership in Internet of Things (IoT), artificial intelligence governance, facial recognition protocols, smart cities infrastructure, and next-generation 6G wireless—learning from 5G successes and failures.

**IoT and edge computing standards** determine interoperability for billions of connected devices: industrial sensors, smart home appliances, autonomous vehicles, medical devices, agricultural equipment, and urban infrastructure. Multiple competing standards bodies and protocols create fragmentation—IEEE, ITU, ISO, IETF, and industry consortia all advance different specifications. Chinese participation in these venues has increased dramatically, with firms contributing technical proposals, representatives chairing working groups, and government funding supporting standards engagement.

Chinese IoT standards initiatives emphasize **domestic market leverage**: China's massive manufacturing base and consumer market create opportunities to establish dominant standards through market adoption rather than purely technical committee processes. If hundreds of millions of Chinese IoT devices implement specifications developed by Huawei, Xiaomi, Alibaba, or government research institutes, foreign manufacturers face pressures to adopt Chinese standards for market access—creating network effects and locked-in advantages. This "standards through scale" strategy leverages China's economic weight to complement technical committee engagement.

**AI governance standards** represent particularly consequential competition with limited international progress toward consensus. Technical standards for AI systems (testing methodologies, documentation requirements, transparency protocols, bias assessment) are emerging through ISO, IEEE, and national standards bodies. However, fundamental disagreements about AI governance between democratic and authoritarian regimes impede convergence. Western frameworks emphasize transparency, accountability, individual rights protection, and independent oversight. Chinese approaches prioritize state control, social stability, party leadership, and national security—creating incompatible governance philosophies translated into competing technical standards.

The **ITU's AI for Good Global Summit** and UNESCO's AI ethics frameworks represent attempts at international cooperation, but progress proves limited when underlying values diverge. China has proposed facial recognition standards at ITU emphasizing technical interoperability while ignoring human rights concerns Western democracies prioritize. These proposals, if adopted internationally, would facilitate surveillance technology exports and normalize authoritarian applications—demonstrating how ostensibly neutral technical standards embed political values.

**6G standards competition** is already underway despite 5G deployment remaining incomplete globally. 6G promises orders of magnitude improvements in speed, latency, and connectivity density—enabling applications currently speculative: truly seamless virtual/augmented reality, pervasive artificial intelligence, advanced holographic communications, and integration of terrestrial and satellite networks. Standards development is in early stages, with 3GPP planning initial specifications for late 2020s and commercial deployment in 2030s.

Both United States and China recognize 6G standards as critical strategic competition domain. **China launched 6G development initiatives** in 2019, establishing research programs, funding university and industry projects, and coordinating standards engagement strategies. The goal is establishing standards leadership from initial development rather than catching up as occurred in earlier wireless generations. **United States**, having largely ceded 5G standards leadership to Huawei, seeks to regain initiative in 6G through "Next G Alliance" (industry consortium coordinating 6G R&D), increased government funding for wireless research, and diplomatic efforts to coordinate allied standards positions.

The fundamental question is whether Western firms and governments can match Chinese systematic, state-supported standards engagement. U.S. firms excel at innovation but often underinvest in standards processes—viewing committee work as burdensome rather than strategic. Chinese firms receive government guidance and support for standards participation, attend meetings systematically, and coordinate positions—creating persistent engagement advantages. Unless Western approaches adapt, Chinese standards influence will likely continue expanding across emerging technologies.

---

## Information Warfare and Influence Operations

### Disinformation, Platform Manipulation, and Narrative Control

Information warfare—the use of information and communication technologies to gain strategic advantages through manipulating perceptions, spreading disinformation, and shaping narratives—represents an increasingly prominent dimension of great power competition. Unlike cyber espionage seeking data theft or infrastructure attacks pursuing disruption, information operations target human cognition and political processes: influencing elections, undermining trust in institutions, polarizing societies, and advancing geopolitical narratives favorable to operators.

**Chinese information operations** differ in character from Russian approaches, reflecting distinct strategic objectives and political systems. Russian operations, as demonstrated in 2016 U.S. elections and ongoing campaigns, emphasize chaos, polarization, and undermining democratic legitimacy—seeking to weaken adversaries through internal divisions rather than promoting specific Russian narratives. Chinese operations more often pursue **positive propaganda** promoting Chinese Communist Party achievements, Belt and Road Initiative benefits, and Chinese governance model advantages, alongside **defensive censorship** suppressing criticism of Chinese policies and human rights abuses.

**COVID-19 pandemic** provided case study in Chinese information operations' scale and mechanisms. As global criticism mounted regarding initial outbreak handling in Wuhan, delayed information sharing, and potential laboratory origins, Chinese government agencies and affiliated entities conducted coordinated campaigns deflecting blame and promoting Chinese pandemic response successes. Operations included:

- **Diplomatic "wolf warrior" rhetoric:** Chinese diplomats and Foreign Ministry spokespersons aggressively promoted conspiracy theories about U.S. military origins of COVID-19, amplified criticism of Western pandemic responses, and highlighted Chinese medical assistance to other countries
- **State media amplification:** CGTN, Xinhua, China Daily, and other official outlets produced massive content promoting Chinese pandemic control, contrasting "superior" Chinese governance with "chaotic" Western responses, and depicting China as responsible global leader
- **Social media manipulation:** Researchers documented coordinated inauthentic behavior on Twitter, Facebook, and YouTube where accounts with Chinese characteristics (registration patterns, linguistic features, behavioral signatures) systematically amplified pro-Chinese content, attacked critics, and spread disinformation
- **Information suppression:** Domestic censorship prevented Chinese citizens from accessing alternative narratives, while international pressure compelled platform removals of content critical of Chinese policies

**Effectiveness of Chinese information operations** remains contested. Some analysts assess that operations successfully shaped narratives in developing countries where Chinese infrastructure investment and media presence influence information environments, but faced limited traction in Western democracies with diverse media ecosystems and public skepticism of Chinese government claims. However, even unsuccessful influence attempts can impose costs: forcing democratic governments and civil society to invest resources in debunking disinformation, creating political controversies, and polluting information environments with contradictory narratives that undermine confidence in objective truth.

**Uyghur genocide narratives** demonstrate information warfare's intensity on issues Chinese government views as core interests. As evidence accumulated of mass detention, forced labor, coercive population control, and cultural destruction in Xinjiang, international criticism intensified. Chinese responses combined aggressive information campaigns (denying abuses, claiming "vocational training" and "deradicalization," organizing propaganda tours for sympathetic observers) with economic coercion (threatening market access for companies criticizing Xinjiang policies, pressuring governments to silence criticism). The campaign achieved limited success in changing Western government positions but successfully fragmented international responses—many Muslim-majority nations issued statements supporting Chinese policies or remained silent, prioritizing economic relationships over human rights.

### Platform Governance and the Weaponization of Content Moderation

Social media platforms—Twitter/X, Facebook/Meta, YouTube, TikTok—have become contested spaces where states pursue influence while platforms attempt content moderation balancing free expression, user safety, and political pressures from multiple governments. This creates opportunities for **authoritarian manipulation of platform policies** where governments pressure platforms to censor content, remove critics, and amplify regime narratives under guise of combating misinformation, hate speech, or extremism.

**Chinese pressure on platforms** operates through market access leverage. Platforms seeking Chinese operations must accept censorship (LinkedIn's Chinese version censored politically sensitive profiles), data localization (storing Chinese user data in China-based servers accessible to authorities), and government partnership requirements (Google's abandoned Dragonfly search engine would have enabled censorship and surveillance). Platforms refusing compliance face blocking—Google Search, Facebook, Twitter, YouTube, and most Western social media remain blocked in China behind the Great Firewall, replaced by domestic alternatives (Baidu, WeChat, Weibo) subject to comprehensive government control.

**TikTok** represents unique information warfare concerns, being Chinese-owned platform (ByteDance parent company) with massive user base in Western countries including United States (over 150 million American users). U.S. government concerns encompass multiple dimensions:

- **Data collection:** TikTok collects extensive user data (location, contacts, viewing habits, biometric information from face filters) potentially accessible to Chinese government through legal demands or ByteDance cooperation
- **Algorithm manipulation:** Recommendation algorithms determining what content users see could be manipulated to suppress content critical of China, promote pro-Chinese narratives, or influence political opinions—particularly among young users who disproportionately use TikTok
- **Influence operations:** Platform could be weaponized during crises to spread disinformation, create panic, or manipulate public opinion on geopolitically sensitive issues
- **Cognitive security:** Even without active manipulation, foreign adversary control of information platform consumed by millions creates strategic vulnerability and potential coercive leverage

TikTok has implemented various measures attempting to address concerns: storing U.S. user data with Oracle in the United States, establishing content moderation transparency, and creating organizational separations between TikTok and ByteDance. However, U.S. government assessments conclude that structural ties to Chinese parent company and potential Chinese government pressure create ineradicable risks. Legislation requiring ByteDance divestiture of TikTok (divest to non-Chinese owners or face ban) passed Congress in 2024, though implementation faces legal challenges and practical complexities.

The TikTok debate illustrates broader dilemmas about **reciprocity in digital platforms**. Chinese internet remains closed to Western platforms while Chinese platforms operate globally—creating asymmetric information access. Arguments for banning or restricting TikTok emphasize security and reciprocity; counterarguments raise free expression concerns, economic costs (American creators and businesses rely on TikTok), and precedent for internet fragmentation (if United States bans foreign platforms based on ownership nationality, will others follow, fragmenting global internet?).

---

## The Splinternet and Digital Fragmentation

### Internet Balkanization: From Global Network to Geopolitical Fragments

The internet's foundational vision—a borderless, interoperable global network enabling free information flows—is fragmenting into geopolitically defined zones with divergent governance, technical standards, and accessible content. This "splinternet" or internet balkanization reflects competing visions of digital governance, strategic competition dynamics, and erosion of consensus that sustained global internet integration.

**Technical fragmentation** manifests through incompatible standards, divergent protocols, and isolated infrastructure. China's Great Firewall creates the most comprehensive technical separation: filtering systems block access to foreign websites and services, forcing users onto domestic platforms operating under government control. Russia's sovereign internet initiatives pursue similar separation capabilities. Alternative root DNS systems, competing internet governance frameworks, and proliferating localization requirements create barriers to seamless global connectivity that characterized earlier internet eras.

**Content fragmentation** occurs as different jurisdictions enforce contradictory requirements on platforms and content providers. What is legal speech in United States may violate European hate speech laws, Chinese censorship requirements, or Russian "extremism" statutes. Platforms must either fragment offerings (different content available in different countries), accept lowest-common-denominator restrictions (global censorship to satisfy most restrictive jurisdiction), or exit markets refusing compliance. Geographic content blocking—restricting access based on user location—becomes standard practice rather than exceptional.

**Regulatory fragmentation** accelerates as nations implement incompatible frameworks for data protection, content moderation, platform liability, and technology governance. GDPR's European approach differs fundamentally from Chinese data security laws and American sectoral regulations. No global consensus exists on fundamental questions: are platforms liable for user content or protected by intermediary liability shields? Must encryption include government backdoors or preserve end-to-end security? Should data flow freely across borders or remain subject to localization? These unresolved questions generate proliferating national regulations creating compliance burdens and barriers to global digital integration.

### Alternative Digital Infrastructures: BeiDou, CIPS, and Digital Sovereignty

Chinese pursuit of digital sovereignty extends beyond censorship and data localization to building alternative digital infrastructures reducing dependencies on Western-controlled systems. These alternatives—navigation satellites, payment systems, internet routing, cloud services—create parallel ecosystems enabling both independence from Western leverage and potential extensions of Chinese influence.

**BeiDou Navigation Satellite System**, completed in 2020 with global coverage, represents China's GPS alternative. While civilian GPS remains freely available globally, Chinese government determined that military and critical infrastructure dependencies on American-controlled navigation created unacceptable vulnerabilities (GPS can be selectively denied or degraded in specific regions during conflicts). BeiDou provides Chinese military assured access independent of U.S. control and offers civilian services throughout Belt and Road Initiative countries—creating technical ties and potential leverage comparable to Western GPS dependencies.

**Cross-Border Interbank Payment System (CIPS)**, launched in 2015 and expanded substantially since, represents Chinese alternative to SWIFT (Society for Worldwide Interbank Financial Telecommunication) for international payments. While SWIFT remains dominant (processing tens of millions of daily transactions globally), CIPS enables RMB-denominated cross-border payments outside SWIFT infrastructure. Strategic motivation is clear: SWIFT's Belgian domicile notwithstanding, U.S. pressure has repeatedly compelled SWIFT disconnections as sanctions enforcement mechanism (Iran, Russia). CIPS provides potential escape from SWIFT-based financial coercion, though current transaction volumes remain orders of magnitude below SWIFT.

**Domestic technology ecosystems** substituting for American platforms create comprehensive digital sovereignty: Baidu replaces Google Search, WeChat substitutes for WhatsApp and Facebook combined, Weibo parallels Twitter, Douyin (TikTok's Chinese version) operates under different rules than international TikTok, Alibaba and JD.com replace Amazon. These platforms operate under government oversight enabling content censorship and data access, but also demonstrate that authoritarian regimes need not depend on Western platforms—comprehensive digital ecosystems can develop domestically with sufficient market scale and government support.

### Strategic Implications: Resilience or Inefficiency?

Digital fragmentation creates tradeoffs between resilience and efficiency that parallel supply chain debates in Chapter 2. **Proponents of fragmentation** emphasize resilience benefits: reduced vulnerabilities to foreign disruption, protection from surveillance and manipulation, and strategic autonomy enabling independent action during crises. **Critics highlight inefficiency costs**: duplicated infrastructure investment, lost network effects and economies of scale, reduced innovation from fragmented markets, and barriers to global cooperation on challenges requiring coordination.

The trajectory remains uncertain. Full splinternet—completely separate digital ecosystems with no interoperability—appears implausible given economic interdependencies and technical complexity. But continued fragmentation through incompatible regulations, content blocking, alternative infrastructure, and geopolitical tensions seems likely. The question is degree: will fragmentation remain modest (separate content in different jurisdictions but interoperable infrastructure) or accelerate toward substantive separation (incompatible technical standards, isolated networks, competing governance systems)?

Answers depend on broader geopolitical trajectories: deepening U.S.-China strategic competition suggests accelerating fragmentation, while economic interdependencies and shared challenges (climate, pandemics, technology governance) create incentives for maintaining connectivity. The information domain thus serves as both arena of strategic competition and potential site of cooperation—a duality defining contemporary international relations.

---

## Chinese Perspective Box: Cyber Sovereignty and Discourse Power

### Understanding Chinese Concepts of Information Security

Chinese approaches to information technology governance fundamentally diverge from Western frameworks, reflecting different political systems, historical experiences, and strategic objectives. Understanding these perspectives through key Chinese concepts provides essential context for analyzing information domain competition.

**Cyber Sovereignty (网络主权, wǎngluò zhǔquán)** represents the foundational Chinese principle: states possess sovereign authority over internet infrastructure, content, and data within their territories, equivalent to sovereignty over physical territory. This concept explicitly challenges Western internet governance norms emphasizing multi-stakeholder governance, free information flows, and limiting government control. From Chinese perspective, Western internet "freedom" rhetoric masks American dominance of internet infrastructure (root DNS servers, ICANN control, submarine cable routes) and platforms (Google, Facebook, Amazon), creating unacceptable vulnerabilities and information asymmetries.

Chinese officials argue that cyber sovereignty protects against multiple threats: foreign espionage and surveillance (Snowden revelations proved American intelligence agencies conduct massive global surveillance including of allies), ideological infiltration (Western platforms could be weaponized to spread democratic values threatening Communist Party legitimacy), and strategic manipulation (adversaries could exploit internet dependencies to disrupt China during crises). From this perspective, the Great Firewall and data localization represent defensive measures comparable to border controls and customs enforcement—legitimate exercises of sovereignty protecting national security and social stability.

**Discourse Power (话语权, huàyǔquán)** addresses perceived information asymmetries where Western nations dominate global narratives through media control, platform ownership, and cultural influence. Chinese government views international discourse as systematically biased against China: Western media emphasize Chinese human rights violations while downplaying Western abuses, international institutions reflect Western values and interests, and English language dominance marginalizes Chinese perspectives. Discourse power thus means capability to shape international narratives, influence global public opinion, and contest Western information dominance.

Pursuing discourse power motivates substantial investments in international media (CGTN, China Daily, Xinhua expanding global presence), Belt and Road Initiative infrastructure giving leverage over developing nation narratives, social media presence amplifying Chinese perspectives, and standards engagement shaping technical governance. The objective is not necessarily convincing Western audiences (acknowledged as difficult) but providing alternative narratives in developing nations, creating doubt about Western criticisms, and gradually shifting international discourse toward acknowledging Chinese model's legitimacy.

**Information Security (信息安全, xìnxī ānquán)** in Chinese usage encompasses both cybersecurity (protecting networks and data from intrusions) and content security (preventing information threatening social stability or party rule). This conflation reflects Chinese government's view that information threats are inseparable from technical threats—social media platforms enabling political organizing pose national security dangers comparable to cyber espionage or critical infrastructure attacks. Western criticisms that this violates free expression rights are dismissed as imposing Western values inappropriately—from Chinese perspective, social stability and national security legitimately constrain expression rights.

**Digital Civilization (数字文明, shùzì wénmíng)** represents Chinese vision for global internet governance: a multipolar digital order where multiple civilizations maintain distinct digital ecosystems reflecting their values and governance systems, rather than universal Western-dominated internet. This concept explicitly challenges internet universalism, instead embracing digital plurality where Chinese, Western, Islamic, and other civilizations maintain separate-but-equal digital spaces with minimal interference. Critics view this as rationalizing authoritarian censorship and fragmentation; Chinese officials portray it as respecting civilizational diversity and national sovereignty.

### Chinese Perspective: Technology Sovereignty and Strategic Objectives

Chinese information technology strategy reflects both historical lessons about technological dependence and forward-looking strategic objectives. Past experiences with foreign technology denial (Western embargoes, Soviet withdrawal of technical support) reinforce the imperative for self-reliance (自力更生, zìlì gēngshēng). Contemporary Chinese information strategy pursues several goals:

**Technology leadership**: Achieving global leadership in AI, quantum computing, 6G networks, and other frontier technologies to drive economic growth and military capability

**Digital sovereignty**: Maintaining control over domestic information flows to preserve political stability and prevent foreign influence operations

**Standard-setting power**: Shaping international technology standards (5G, AI governance, digital currencies) to favor Chinese firms and governance models

**Supply chain security**: Developing domestic alternatives to GPS, internet infrastructure, and operating systems controlled by potential adversaries

From the Chinese perspective, these measures represent strategic necessities for great power status, not merely authoritarian control. Western technology restrictions (semiconductor export controls, platform bans, network equipment exclusions) validate Chinese concerns about foreign "strangling" leverage, intensifying determination to achieve technological independence regardless of short-term costs.

### Strategic Implications for U.S. Policy

Understanding Chinese cyber sovereignty concepts reveals strategic dilemmas U.S. policymakers face. **Engagement strategies** promoting internet openness and democratic governance norms confront Chinese determination to maintain authoritarian control—creating fundamental incompatibility. **Coercive strategies** restricting Chinese technology access (semiconductor controls, platform bans) reinforce Chinese conviction that Western technology dependence creates unacceptable vulnerabilities, motivating intensified indigenous development regardless of cost.

**Alternative approaches** might emphasize reciprocity (Chinese platforms access Western markets only if Western platforms access Chinese markets under non-discriminatory terms), technical security measures (requiring supply chain transparency, independent audits, data protection standards) rather than ideological debates, and coalition-building with democracies sharing internet freedom values while acknowledging that comprehensive convergence with authoritarian regimes appears implausible.

The fundamental question is whether U.S. strategy should pursue Chinese integration into liberal internet order (assuming eventual convergence toward openness), accept permanent digital fragmentation along geopolitical lines, or seek pragmatic coexistence managing competition while preventing complete decoupling. Current trajectory suggests middle option—accelerating fragmentation with uncertain endpoints—will dominate absent deliberate strategic choices reorienting competition dynamics.

---

## Government Tools Box 1: Computer Fraud and Abuse Act and Cyber Authorities

### Legal Authority and Statutory Basis

The **Computer Fraud and Abuse Act (CFAA)**, codified at 18 U.S.C. § 1030, represents the primary federal statute criminalizing cyber intrusions and computer-related offenses in the United States. Originally enacted in 1984 and substantially amended multiple times (particularly in 1986, 1996, 2001, and 2008), the CFAA establishes criminal and civil liability for unauthorized access to computer systems, theft of data, and intentional damage to protected computers.

**Key CFAA provisions** relevant to state-sponsored cyber espionage and economic coercion include:

- **§ 1030(a)(1):** Prohibits accessing computers to obtain classified national defense or foreign relations information with intent to harm the United States or advantage foreign nations
- **§ 1030(a)(2):** Criminalizes unauthorized access to computers to obtain financial, government, or other protected information
- **§ 1030(a)(4):** Prohibits accessing protected computers with intent to defraud and obtain value
- **§ 1030(a)(5):** Criminalizes intentionally causing damage through unauthorized access, including transmission of malicious code

Penalties vary by offense severity and include fines and imprisonment up to 10-20 years for serious violations, with enhanced penalties for repeat offenders and offenses causing significant harm.

### Implementing Agencies and Authorities

**Department of Justice (DOJ)** leads CFAA enforcement through:

- **National Security Division:** Prosecutes state-sponsored cyber intrusions involving espionage, critical infrastructure targeting, and national security threats
- **Computer Crime and Intellectual Property Section (CCIPS):** Provides expertise in complex cyber investigations and prosecutions
- **U.S. Attorneys' Offices:** Conduct regional prosecutions of cyber offenses
- **FBI Cyber Division:** Investigates cyber intrusions, identifies perpetrators, and builds criminal cases

**Department of Homeland Security (DHS)** contributes through:

- **Cybersecurity and Infrastructure Security Agency (CISA):** Provides defensive cyber capabilities, threat intelligence, and incident response for federal agencies and critical infrastructure
- **Secret Service:** Investigates cyber-enabled financial crimes and critical infrastructure protection

**Additional authorities** complement CFAA in addressing cyber threats:

- **Economic Espionage Act (18 U.S.C. §§ 1831-1839):** Criminalizes theft of trade secrets to benefit foreign governments or entities
- **Wire Fraud Statute (18 U.S.C. § 1343):** Applies to cyber intrusions involving fraudulent schemes
- **Executive Order 13694 (2015):** Authorizes sanctions against individuals and entities engaging in significant malicious cyber activities
- **Executive Order 13757 (2016):** Expands cyber sanctions authorities and adds blocking of property
- **International Emergency Economic Powers Act (IEEPA):** Provides statutory basis for cyber-related sanctions

### Recent Applications to Chinese Cyber Operations

CFAA and related authorities have been invoked in numerous indictments of Chinese state-sponsored cyber actors:

**2014 PLA Unit 61398 Indictments:** Five Chinese military officers charged with economic espionage and CFAA violations for hacking U.S. companies in nuclear power, metals, and solar sectors. First-ever criminal charges against state-sponsored hackers from another nation. While defendants remain in China beyond U.S. jurisdiction, indictments established precedent for attributing state-sponsored operations and imposed reputational costs.

**2018 APT10 "Cloud Hopper" Indictments:** Two Chinese nationals affiliated with Ministry of State Security charged with CFAA violations, wire fraud, and economic espionage for compromising managed service providers to access downstream client data. Indictment detailed systematic intellectual property theft supporting Chinese industrial policy across aerospace, technology, pharmaceutical, and other sectors.

**2020 APT41 Indictments:** Five Chinese nationals charged with computer fraud conspiracy, wire fraud, and CFAA violations spanning both state-sponsored espionage and profit-motivated cybercrime. Charges detailed intrusions affecting over 100 companies globally across software development, telecommunications, social media, video gaming, and other industries.

**2020 Equifax Breach Indictments:** Four members of China's People's Liberation Army charged with CFAA violations and economic espionage for 2017 Equifax breach compromising personal data of 145 million Americans. Indictment demonstrated Chinese government targeting of consumer data with potential intelligence applications.

### Effectiveness Assessment

**Strengths:**

- **Attribution deterrence:** Public indictments impose reputational costs on Chinese government, name specific intelligence units and officers, and demonstrate technical attribution capabilities that may deter some operations
- **Diplomatic leverage:** Indictments provide basis for bilateral negotiations, allied coordination, and international pressure even when prosecution proves impossible
- **Intelligence disclosure:** Declassifying technical details about intrusion methodologies, infrastructure, and attribution indicators helps private sector defend networks
- **Domestic audience signaling:** Demonstrates government action addressing cyber threats, satisfying political demands for responses

**Limitations:**

- **Jurisdictional challenges:** Defendants remain in China beyond U.S. arrest, making prosecution impossible absent extradition (which China will never provide for state-sponsored operatives)
- **Limited deterrence:** Operations continue despite indictments, suggesting reputational costs prove acceptable to Chinese government pursuing strategic espionage objectives
- **Intelligence tradeoffs:** Public indictments may reveal sources and methods, potentially compromising ongoing intelligence operations monitoring adversary activities
- **Escalation risks:** Aggressive cyber attribution and prosecution could invite Chinese retaliation or normalization of reciprocal indictments targeting U.S. cyber operations

**Complementary Measures:**

Effective responses to state-sponsored cyber operations require combining CFAA enforcement with:

- **Export controls:** Restricting Chinese access to technologies enabling cyber capabilities (as examined in Chapter 4)
- **Sanctions:** Blocking property and prohibiting transactions with individuals and entities engaged in malicious cyber activities
- **Diplomatic coordination:** Building allied consensus on attribution and collective responses
- **Defensive improvements:** Mandating cybersecurity standards for critical infrastructure and federal systems
- **Offensive operations:** U.S. Cyber Command's "defend forward" and "persistent engagement" strategies imposing costs through disruption of adversary infrastructure

The CFAA remains essential legal tool for addressing cyber threats but proves insufficient alone. Comprehensive strategies must address both perpetrators (through prosecution and sanctions) and vulnerabilities (through defensive improvements and resilience enhancement).

---

## Government Tools Box 2: FIRRMA and Technology Investment Screening

### Legal Authority: Foreign Investment Risk Review Modernization Act of 2018

The **Foreign Investment Risk Review Modernization Act (FIRRMA)**, enacted August 2018, substantially expanded the Committee on Foreign Investment in the United States (CFIUS) authorities and scope. FIRRMA responded to concerns that Chinese investors were acquiring U.S. technology companies, gaining access to critical technologies, and potentially creating national security vulnerabilities that existing CFIUS processes failed to address.

**CFIUS** is an interagency committee chaired by the Secretary of the Treasury with membership from Defense, State, Commerce, Homeland Security, Energy, and other departments. The committee reviews foreign transactions for national security risks and can recommend that the President block or unwind deals.

### Pre-FIRRMA Limitations

Before FIRRMA, CFIUS jurisdiction was limited to transactions resulting in **foreign control** of U.S. businesses. This created gaps:

- **Minority investments** without control escaped CFIUS review even when providing foreign investors with access to sensitive technologies, facilities, or data
- **Greenfield investments** (new facilities rather than acquisitions) fell outside jurisdiction
- **Real estate transactions** near sensitive facilities weren't systematically reviewed
- **Limited enforcement** for mandatory declarations and incomplete notifications

Chinese investors exploited these gaps through minority stakes in technology startups (gaining access to innovations without triggering CFIUS review), joint ventures with operational rights short of control, and strategic real estate acquisitions.

### FIRRMA Expansions and Technology Focus

FIRRMA expanded CFIUS jurisdiction to cover **non-controlling investments** in U.S. businesses involved in:

1. **Critical technologies:** Items subject to export controls, including:
   - Semiconductors and advanced manufacturing equipment
   - AI and quantum computing technologies
   - Aerospace and satellite systems
   - Advanced materials and biotechnology
   - Cybersecurity tools and encryption

2. **Critical infrastructure:** Systems essential for national security:
   - Telecommunications networks and data centers
   - Energy systems and electrical grids
   - Financial infrastructure
   - Transportation systems

3. **Sensitive personal data:** Businesses maintaining or collecting data on U.S. citizens that could be exploited for:
   - Intelligence purposes (identifying individuals for recruitment or targeting)
   - Blackmail or influence operations
   - Military or surveillance applications

FIRRMA also expanded jurisdiction to cover certain **real estate transactions** within close proximity to military installations, government facilities, and sensitive sites.

### Mandatory Declarations

FIRRMA established **mandatory filing requirements** for specified transactions, eliminating voluntary nature that allowed parties to avoid CFIUS review. Mandatory declarations apply to foreign government-controlled investments in critical technology businesses, creating automatic triggers for Chinese state-owned enterprises and sovereign wealth funds.

**Penalties for non-compliance** include:

- Civil monetary penalties up to transaction value
- Retroactive mitigation requirements
- Unwinding of completed transactions
- Criminal penalties for willful violations

### Technology-Specific Risk Assessment Criteria

FIRRMA directed CFIUS to consider technology-specific risks including:

- **Control over critical technologies:** Whether foreign investor gains rights to export, transfer, or exploit technologies subject to controls
- **Cybersecurity vulnerabilities:** Whether transaction creates opportunities for malicious cyber activities or sabotage
- **Data access:** Whether foreign persons gain access to sensitive U.S. person data with intelligence or military applications
- **Technology transfer risks:** Whether transaction facilitates technology transfer to foreign adversaries
- **Supply chain dependencies:** Whether transaction increases U.S. reliance on foreign-controlled critical suppliers

### Implementation and Chinese Investment Impact

FIRRMA implementation significantly reduced Chinese investments in U.S. technology sectors:

**Statistical impacts:**

- Chinese venture capital and private equity investment in U.S. startups declined from $9.9 billion (2018) to $3.1 billion (2020) to approximately $1 billion (2023)
- CFIUS reviews of Chinese transactions increased from 60-80 annually pre-FIRRMA to 150-200 post-implementation
- Withdrawal rates (parties abandoning deals during CFIUS review) increased substantially for Chinese investors

**Notable blocked or abandoned transactions:**

- Broadcom-Qualcomm (2018): President Trump blocked Singapore-based Broadcom's acquisition of Qualcomm citing Chinese competition concerns in 5G
- MoneyGram-Ant Financial (2018): Alibaba affiliate abandoned $1.2 billion acquisition after CFIUS raised concerns
- Lattice Semiconductor-Canyon Bridge (2017, pre-FIRRMA): Chinese-backed fund's acquisition blocked over semiconductor technology concerns
- Numerous undisclosed startup investments withdrawn during CFIUS review

### Coordination with Allied Investment Screening

FIRRMA encouraged allied nations to develop comparable investment screening mechanisms, creating coordinated approaches to Chinese technology investments:

- **European Union** implemented FDI Screening Regulation (2019) establishing member state screening frameworks and EU-level coordination
- **United Kingdom** expanded National Security and Investment Act (2021) with mandatory notification requirements for specified sectors
- **Australia** strengthened Foreign Investment Review Board processes with lower notification thresholds for certain investors
- **Japan, Canada, and others** enhanced investment screening authorities

**Information sharing** among allied screening authorities enables coordinated reviews of multinational transactions, prevents regulatory arbitrage, and aligns risk assessments—though formal mechanisms remain limited compared to export control coordination.

### Strengths and Limitations

**Strengths:**

- Successfully reduced Chinese access to early-stage U.S. technologies through venture investments
- Closed loopholes allowing minority stakes in sensitive companies
- Established technology-focused criteria beyond traditional national security concerns
- Created deterrent effects as Chinese investors avoid sectors likely to face CFIUS blocks

**Limitations:**

- Cannot address technologies already transferred through past investments or exports
- Focused on inbound investment; doesn't restrict U.S. firms from investing in or partnering with Chinese technology companies
- Administrative burdens and timelines create costs for legitimate transactions
- Potential chilling effects on foreign investment generally, not just Chinese
- Limited extraterritorial reach; Chinese investors can acquire non-U.S. companies with relevant technologies

FIRRMA represents critical tool in technology competition strategy but proves most effective when combined with export controls (restricting technology flows regardless of investment), R&D investment (maintaining U.S. innovation leadership), and allied coordination (preventing Chinese access through third-country investments).

---

## Case Study 1: China's Great Firewall and Digital Sovereignty

### Background and Technical Architecture

China's "Great Firewall" (GFW) represents the world's most sophisticated and comprehensive internet censorship and surveillance system, blocking access to foreign websites, filtering content, and monitoring communications for over 1 billion Chinese internet users. The system's technical name is the "Golden Shield Project" (金盾工程, jīndùn gōngchéng), implemented progressively since the late 1990s and continuously upgraded to address circumvention technologies and expanding internet traffic.

**Technical mechanisms** combine multiple layers:

1. **IP blocking:** Preventing connections to specific IP addresses associated with banned websites (Google, Facebook, Twitter, YouTube, Wikipedia in certain languages, foreign news outlets)

2. **DNS filtering:** Manipulating Domain Name System responses to prevent domain names from resolving correctly, causing connection failures

3. **URL filtering:** Inspecting HTTP requests for banned keywords and URLs, blocking connections containing prohibited terms

4. **Deep packet inspection (DPI):** Analyzing network traffic content in real-time, identifying and blocking connections containing sensitive keywords, protest organization communications, or circumvention tool signatures

5. **Protocol restrictions:** Blocking or throttling VPN protocols, Tor connections, and other circumvention technologies

6. **Platform compliance requirements:** Mandating that Chinese internet platforms (WeChat, Weibo, Douyin) implement content filtering, user monitoring, and government information access

The system is not perfect—sophisticated users employ VPNs, proxy servers, and other circumvention tools to access blocked content. However, circumvention requires technical knowledge and creates barriers to casual access, effectively limiting foreign information exposure for the majority of Chinese users.

### Applying the Four-Dimension Framework

**Domain:** Information and digital infrastructure—controlling access to foreign information and platforms while developing domestic alternatives subject to government oversight.

**Target:** Both domestic (Chinese citizens prevented from accessing foreign information) and international (foreign firms denied market access unless accepting censorship and data localization).

**Objective:** Multiple overlapping objectives:
- **Deterrence:** Preventing foreign information from undermining Communist Party legitimacy and social stability
- **Containment:** Limiting Western cultural and political influence
- **Industrial policy:** Protecting domestic internet platforms (Baidu, Tencent, Alibaba) from foreign competition
- **Surveillance capability:** Enabling comprehensive monitoring of domestic communications

**Intensity:** Level 4 (Major structural coercion)—comprehensive restrictions affecting hundreds of millions of users, blocking thousands of foreign services, and requiring massive infrastructure investment to implement and maintain.

### Economic and Strategic Implications

The Great Firewall creates **multiple economic effects**:

**Market protection for domestic platforms:** Blocking Google, Facebook, Twitter, and other foreign platforms eliminated competition, enabling Chinese alternatives to dominate domestically. This protected market allowed Baidu, Tencent, Alibaba, and ByteDance to grow into technology giants generating hundreds of billions in revenue and developing world-class technical capabilities. Whether these firms would have thrived facing foreign competition remains counterfactual, but protected market unquestionably provided advantages during formative years.

**Foreign firm market access denial:** Companies unwilling to accept censorship and data localization face complete market exclusion. Google, after years operating censored Chinese search (google.cn), withdrew in 2010 citing cyber intrusions and censorship concerns—sacrificing Chinese market revenues for principles and security. Facebook has never operated in China; Mark Zuckerberg's attempts to negotiate market entry foundered on unwillingness to accept full government control. LinkedIn's 2021 withdrawal demonstrated limits of compliance when government demands continuously escalate.

**Costs to Chinese economy:** Censorship creates economic inefficiencies: businesses and researchers face barriers accessing global information, academic collaboration encounters obstacles, and innovation potentially suffers from information limitations. Some studies estimate Great Firewall costs Chinese economy tens of billions annually through reduced productivity and barriers to information flows. However, Communist Party evidently judges these costs acceptable for maintaining political control and social stability.

### Effectiveness Assessment (Five Criteria)

**Target Compliance:** High. Chinese citizens largely cannot access blocked foreign websites without circumvention tools; foreign firms either comply with censorship (accepting market constraints) or face blocking. Non-compliance exists (VPN usage, circumvention) but remains minority activity.

**Capability Degradation:** High. Foreign platforms' inability to operate in China eliminates their influence over Chinese public opinion, denies them market revenues funding global expansion, and prevents them from shaping Chinese digital ecosystem.

**Cost Imposition:** Moderate on foreign firms (lost revenues offset by avoiding costs of compliance with unacceptable restrictions); moderate on Chinese users (denied access to information and services but provided domestic alternatives).

**Sustainability:** High. System has operated for over two decades with continuous upgrades maintaining effectiveness despite circumvention efforts. Political commitment remains absolute, and costs prove acceptable to leadership prioritizing control over openness.

**Collateral Damage:** Moderate to high. Chinese researchers, businesses, and citizens bear costs of information restrictions; global internet fragments as largest national internet operates behind comprehensive censorship; precedent encourages other authoritarian regimes to implement similar systems.

### Export of Censorship Technologies and Norms

China has exported Great Firewall technologies and governance models to other authoritarian regimes through:

- **Direct technology sales:** Huawei, ZTE, and other Chinese firms sell filtering and surveillance systems to governments in Africa, Middle East, Southeast Asia, and Latin America
- **Training and technical assistance:** Chinese cybersecurity agencies provide training to foreign governments on implementing censorship and surveillance
- **Diplomatic advocacy:** Promoting "cyber sovereignty" norms in international venues (ITU, UN) as alternative to Western internet freedom advocacy
- **Belt and Road Digital Silk Road:** Including digital infrastructure in Belt and Road Initiative, creating dependencies on Chinese systems

**Recipients** of Chinese censorship technologies include:

- **Russia:** Cooperation on sovereign internet initiatives and filtering technologies
- **Central Asian states:** Kazakhstan, Uzbekistan, Tajikistan implementing Chinese-influenced systems
- **African nations:** Ethiopia, Tanzania, Uganda, others deploying Chinese-supplied surveillance and filtering
- **Southeast Asia:** Vietnam, Cambodia, Thailand expanding censorship using Chinese technologies

This export creates **normative competition** where Chinese governance model—authoritarian digital control—presents coherent alternative to Western internet freedom frameworks, particularly appealing to non-democratic regimes concerned about social media enabling political mobilization.

### Lessons for U.S. Policy

The Great Firewall demonstrates that:

1. **Comprehensive digital censorship is technically feasible and sustainable** despite Western assumptions that internet would necessarily promote openness
2. **Economic integration does not automatically produce political liberalization**—China developed sophisticated digital economy while maintaining authoritarian control
3. **Protected markets enable domestic champions**—blocking foreign competition allowed Chinese tech firms to develop capabilities now competing globally
4. **Export of authoritarian technology governance** creates international challenges beyond bilateral U.S.-China competition

U.S. policy responses must acknowledge that some nations will choose digital sovereignty over internet freedom, requiring strategies that: protect democratic digital ecosystems, support internet freedom where politically viable, counter authoritarian technology exports through alternative offerings, and maintain technological superiority ensuring Western model demonstrates advantages.

---

## Case Study 2: 5G Standards Competition and the Huawei Challenge

*[This case study expands on material from Section 3.2, applying the four-dimension framework specifically]*

### Background: Huawei's Rise to 5G Leadership

Huawei Technologies, founded 1987 as telecommunications equipment reseller, evolved into global leader in wireless infrastructure through sustained R&D investment, aggressive international expansion, and strategic standards engagement. By 2018-2019, Huawei had achieved dominant positions in 4G equipment markets and led 5G technology development—contributing approximately 15-20% of 5G standard-essential patents, more than any other single firm, and positioning itself to capture significant share of global 5G equipment deployments worth hundreds of billions in total market value.

This success reflected deliberate strategy combining technical excellence, cost advantages from Chinese government support and manufacturing scale, and systematic standards participation. Huawei employed tens of thousands of engineers in wireless R&D, contributed thousands of technical proposals to 3GPP standardization processes, and built relationships with telecommunications carriers globally through equipment sales, financing packages, and technical support.

### Applying the Four-Dimension Framework

**Domain:** Technology standards and infrastructure—determining which firm's technical specifications become global standards, controlling critical telecommunications infrastructure, and shaping evolution of mobile networks enabling next-generation applications.

**Target:** Multi-level targeting:
- **Entity level:** Huawei Technologies specifically targeted through Entity List designation, export controls, and exclusion campaigns
- **Sectoral level:** Broader Chinese telecommunications sector (ZTE also restricted)
- **State level:** China's technology competitiveness and military modernization constrained by limiting access to advanced chips and Western markets

**Objective:**
- **Capability degradation:** Preventing Huawei from dominating 5G equipment markets globally, limiting Chinese telecommunications technology advantages
- **Containment:** Ensuring allied telecommunications networks exclude Chinese equipment that could enable espionage or disruption
- **Signaling:** Demonstrating U.S. willingness to accept economic costs to prevent Chinese technology dominance in strategic sectors

**Intensity:** Level 3-4 (Moderate to major coercion)—Entity List restrictions cutting off semiconductor and software access represent severe constraints; allied exclusion from major markets (U.S., Five Eyes, much of Europe) imposes tens of billions in lost revenues; however, Huawei retains market access in much of Asia, Africa, Middle East, creating partial rather than comprehensive restrictions.

### U.S. and Allied Responses: Mechanism and Effectiveness

**Export controls** placed Huawei on Entity List in May 2019, initially restricting U.S. technology sales. Huawei adapted by stockpiling components and shifting to non-U.S. suppliers. U.S. expanded controls in May 2020 through Foreign Direct Product Rule, prohibiting foreign semiconductor manufacturers (primarily TSMC) from producing chips for Huawei using U.S. equipment or technologies. This effectively cut Huawei's access to cutting-edge chips essential for 5G base stations and smartphones, as detailed in Chapter 4.

**Allied exclusion campaigns** achieved mixed success:
- **Five Eyes full alignment:** Australia, New Zealand banned Huawei; UK reversed permissive approach to full ban; Canada banned after extended deliberation
- **European fragmentation:** Germany, France restricted but didn't ban; Eastern European nations varied; Nordic countries favored Ericsson and Nokia for historical relationships
- **Asia/Africa/Middle East:** Continued Huawei deployments prioritizing cost and performance over Western security concerns

### Effectiveness Assessment (Five Criteria)

**Target Compliance:** Moderate. Huawei withdrew from markets mandating exclusion but continued operations elsewhere; company adapted to semiconductor restrictions through stockpiling, design modifications, and Chinese chip alternatives (though with performance compromises).

**Capability Degradation:** Moderate to high. Huawei's technological capabilities constrained by semiconductor access restrictions; market share declined in developed markets; revenues fell from $140 billion (2020) to $100 billion (2022) with smartphone business particularly impacted. However, Huawei retained capabilities in infrastructure equipment, 5G patents, and alternative markets.

**Cost Imposition:** High on Huawei (tens of billions in lost revenues, technological setbacks); moderate on China broadly (demonstrated vulnerabilities in semiconductor supply chain motivating increased indigenous development investment); moderate on U.S. and allies (lost Huawei equipment cost advantages, reduced competition potentially slowing innovation and increasing carrier deployment costs).

**Sustainability:** Moderate. Restrictions require sustained allied coordination facing commercial pressures and potential political changes; enforcement demands continuous adaptation as Huawei and suppliers seek circumvention; economic costs create constituencies favoring relaxation.

**Collateral Damage:** Moderate. Consumers and telecommunications carriers pay higher prices and face slower deployment from reduced competition; scientific collaboration constrained; global technology fragmentation accelerates; precedent for politicized technology markets creates uncertainty for multinational firms.

### Strategic Implications and 6G Competition

Huawei restrictions demonstrate that U.S. can impose significant costs on Chinese technology champions through export controls and allied coordination, but effectiveness depends on:

1. **Sustained allied unity:** Coordination across U.S., Europe, Five Eyes, Japan, South Korea essential—fragmentation limits effectiveness
2. **Comprehensive supply chain control:** U.S. semiconductor technology leverage enabled restrictions; Chinese indigenization efforts reduce future leverage
3. **Willingness to accept costs:** Reduced competition and higher prices represent tradeoffs for security
4. **Alternative vendor viability:** Ericsson and Nokia must remain competitive; if Western vendors fall behind technically, exclusion strategies face commercial and strategic obstacles

**6G competition** (see Section 3.3) represents next battleground where U.S. seeks to apply lessons from 5G experience: engage earlier in standards processes, coordinate allied positions from initial development, invest in Western vendor competitiveness, and potentially preemptively restrict Chinese participation in sensitive portions of 6G architecture. Whether this succeeds depends on sustained government support for standards engagement, Western firms' technical capabilities, and Chinese determination to maintain telecommunications technology leadership despite restrictions.

---

## Data Sources and Further Research

### Primary Sources

**Government Reports and Documents:**
- White House, *National Security Strategy* (2017, 2022)
- Department of Defense, *Annual Report to Congress: Military and Security Developments Involving the People's Republic of China*
- ODNI, *Annual Threat Assessment of the U.S. Intelligence Community*
- CISA, *Cybersecurity Advisories* and *Critical Infrastructure Alerts* (www.cisa.gov)
- FBI, *Internet Crime Complaint Center (IC3) Reports*
- DOJ, *Indictments and Press Releases* on cyber espionage cases
- CFIUS, *Annual Reports to Congress*
- Department of Commerce, *Bureau of Industry and Security Export Control Reports*

**Chinese Government Sources:**
- *Cybersecurity Law of the People's Republic of China* (2016)
- *Data Security Law* (2021)
- *Personal Information Protection Law* (2021)
- State Council, *Made in China 2025* plan documents
- Ministry of Industry and Information Technology, telecommunications and internet governance regulations
- CAC (Cyberspace Administration of China) policy documents

**Standards Bodies:**
- 3GPP specifications and meeting reports (www.3gpp.org)
- ITU Recommendations and Study Group documents
- ISO/IEC JTC 1 standards on information technology
- IEEE standards proceedings

### Private Sector and Think Tank Research

**Cybersecurity Firms:**
- Mandiant (now part of Google Cloud), APT threat reports
- CrowdStrike, *Global Threat Report*
- Recorded Future, threat intelligence analyses
- Microsoft Digital Defense Report
- Symantec/Broadcom, *Internet Security Threat Report*

**Policy Research Institutions:**
- CSIS, *Strategic Technologies Program* and *China Power Project*
- Council on Foreign Relations, *Net Politics* blog and technology governance reports
- Belfer Center, Harvard Kennedy School, technology and cyber policy papers
- Atlantic Council, *Digital Forensic Research Lab*
- CNAS (Center for New American Security), technology and national security reports
- ASPI (Australian Strategic Policy Institute), *International Cyber Policy Centre*
- MERICS (Mercator Institute for China Studies), digital policy analyses

### Academic Resources

**Key Publications:**
- Adam Segal, *The Hacked World Order: How Nations Fight, Trade, Maneuver, and Manipulate in the Digital Age* (2016)
- Chris Miller, *Chip War* (2022) — see Chapter 4 references
- Kai-Fu Lee, *AI Superpowers: China, Silicon Valley, and the New World Order* (2018)
- Bruce Schneier, *Data and Goliath: The Hidden Battles to Collect Your Data and Control Your World* (2015)
- Tim Maurer, *Cyber Mercenaries* (2018)
- Ben Buchanan, *The Cybersecurity Dilemma* (2017)

**Academic Journals:**
- *Journal of Cyber Policy*
- *Journal of Cybersecurity*
- *IEEE Security & Privacy*
- *Communications of the ACM*
- *China Quarterly* (for Chinese policy analysis)

### Datasets and Tracking Tools

**Technology and Standards:**
- FOSS Patents blog for patent analysis and standards tracking
- Darts-ip patent database
- 3GPP specifications database for standards contributions
- Analysys Mason telecommunications market reports

**Cyber Threat Intelligence:**
- MITRE ATT&CK framework for adversary tactics and techniques
- CISA Known Exploited Vulnerabilities catalog
- National Vulnerability Database (NVD)
- Threat intelligence platforms (subscription): Recorded Future, FireEye iSIGHT, CrowdStrike Falcon Intelligence

**Investment and Economic Data:**
- Rhodium Group, *China Investment Monitor*
- CFIUS annual reports to Congress
- Pitchbook and Crunchbase for venture capital and M&A tracking
- UN COMTRADE for technology trade flows

### News and Journalism

**Specialized Technology Coverage:**
- *The Wire China* — technology and cyber policy
- *Protocol* and *Platformer* — technology industry
- *Cybersecurity Dive* and *Threatpost*
- *South China Morning Post* technology section
- *Financial Times* technology coverage
- *Wall Street Journal* cybersecurity and China coverage

### Recommended Starting Points

For practitioners new to information domain competition, recommended reading sequence:

1. **Foundations:** Adam Segal's *The Hacked World Order* for conceptual framework
2. **Technical understanding:** CISA advisories and Mandiant APT reports for threat landscape
3. **Policy context:** CSIS Strategic Technologies Program reports for policy analysis
4. **Chinese perspectives:** MERICS reports and official Chinese government documents
5. **Current developments:** Subscribe to Lawfare blog Cyberlaw Podcast, Council on Foreign Relations Net Politics, and relevant threat intelligence firm newsletters

---


---

## Tabletop Exercise: Submarine Cable Sabotage and Digital Infrastructure Crisis

**Chapter:** 5 - Information, Standards, and Digital Infrastructure

**Duration:** 60-90 minutes

**Learning Objectives:**
- Analyze vulnerabilities in global digital infrastructure
- Evaluate information controls as tools of statecraft
- Understand trade-offs between connectivity and security
- Assess attribution challenges and response options to infrastructure attacks

### Scenario Overview

**Date: March 2028**

Multiple submarine fiber-optic cables connecting Taiwan to the global internet are simultaneously damaged in suspected sabotage. The cables, which carry 99% of Taiwan's international data traffic, suffer breaks at different points on the ocean floor. Taiwan's internet connectivity to the outside world drops by 80%.

Initial reports suggest the damage occurred near cable landing stations but deep underwater, making immediate repair impossible. Repair ships will require 4-6 weeks to fix all breaks. Commercial satellite capacity cannot fully compensate for the lost bandwidth.

Intelligence suggests Chinese fishing vessels and a survey ship were operating near the cable routes shortly before the breaks occurred. However, attribution is uncertain - breaks could be sabotage, accidents, or natural causes (underwater landslides, earthquakes).

Taiwan alleges deliberate Chinese sabotage as part of hybrid warfare strategy. China denies involvement and suggests Taiwan is fabricating claims to garner international sympathy. The crisis creates immediate impacts on Taiwan's economy, financial sector, and ability to coordinate with allies.

### Participant Roles

**Deputy National Security Advisor**
- Responsibilities: Coordinate U.S. response, manage escalation
- Interests: Supporting Taiwan, deterring Chinese aggression, maintaining crisis stability
- Constraints: Attribution uncertainty, escalation risks

**Deputy Secretary of State**
- Responsibilities: Diplomatic response, allied coordination, public messaging
- Interests: Building international support for Taiwan, avoiding military escalation
- Constraints: Weak international law on submarine cable protection

**Deputy Secretary of Defense**
- Responsibilities: Military posture, cyber operations, infrastructure protection
- Interests: Deterring further Chinese aggression, protecting U.S. cables
- Constraints: Limited military options for cables, attribution challenges

**Deputy Secretary of Homeland Security**
- Responsibilities: Critical infrastructure protection, domestic cable security
- Interests: Protecting U.S. internet infrastructure from similar attacks
- Constraints: Most cables privately owned, international waters

**CISA Director**
- Responsibilities: Cybersecurity, critical infrastructure resilience
- Interests: Ensuring U.S. digital infrastructure security
- Constraints: Limited jurisdiction over international infrastructure

**FCC Chairman**
- Responsibilities: Telecommunications regulation, spectrum allocation
- Interests: Maintaining global communications, satellite backup systems
- Constraints: Regulatory authority limited to U.S. territory

### Timeline and Injects

### Phase 1: Initial Response (Minutes 0-20)

**Inject 1: Economic and Security Impact**

Within 48 hours of cable damage:
- Taiwan stock exchange trading volume drops 60% (unable to handle international transactions)
- TSMC reports disruptions in coordinating with global customers and suppliers
- Taiwan's banks cannot process international wire transfers reliably
- U.S. companies with operations in Taiwan face communications blackouts
- Taiwan military reports degraded coordination capabilities

Taiwan requests:
1. Emergency satellite communications support
2. U.S. intelligence on who damaged cables
3. International condemnation and investigation
4. Protection for repair ships (fears Chinese interference)

**Key Questions:**
1. Without definitive attribution, what is appropriate U.S. response?
2. Should the U.S. provide military escort for cable repair ships if Taiwan requests?
3. What immediate steps can help Taiwan maintain critical communications?

### Phase 2: Attribution and Chinese Pressure (Minutes 20-45)

**Inject 2: Intelligence Assessment**

NSA/CIA provide classified assessment:
- **Likely:** Chinese state-sponsored sabotage (fishing vessels, survey ships operated near cables before breaks)
- **Possible:** Accidental damage from anchor dragging or fishing gear
- **Unlikely:** Natural causes (no seismic activity)
- **Confidence:** Medium (circumstantial evidence, no smoking gun)

Intelligence also reveals:
- China mapping global submarine cable networks using survey ships
- Chinese firms involved in cable manufacturing and repair (potential access/vulnerability)
- Russia previously conducted cable surveillance operations; potential cooperation with China

**Inject 3: Expanding Targeting**

New reports indicate:
- Undersea cable damage detected between Japan and U.S. (Guam) - minor disruption, suspicious timing
- Increased Chinese drone and surface vessel activity near cable routes in South China Sea
- Chinese state media publishes articles on "cable vulnerabilities" and how fragile global connectivity is

Chinese Foreign Ministry spokesman suggests Taiwan "provoked this crisis with reckless separatist rhetoric" and should bear consequences.

**Key Questions:**
1. At what point does cable sabotage constitute an act of war or trigger mutual defense obligations?
2. How do you deter future attacks when attribution is difficult to prove publicly?
3. Should the U.S. issue public warnings to China despite attribution uncertainty?

### Phase 3: Strategic Response and Escalation Control (Minutes 45-70)

**Inject 4: Escalation Options**

Military proposes:
- Increased naval patrols near critical cable routes
- Classified retaliatory cyber operations against Chinese infrastructure
- Public designation of cable sabotage as "armed attack" triggering Taiwan Relations Act obligations

State Department proposes:
- International investigation through UN or specialized agency
- Coalition statement condemning infrastructure attacks
- New international legal framework for cable protection

Industry proposes:
- Expedited satellite communication deployment
- Redundant cable routes avoiding Chinese-controlled waters
- Screening Chinese firms from cable repair/manufacturing roles

Taiwan urges strong response, warning that cable attacks are "testing" for broader infrastructure campaign or blockade.

**Inject 5: Collateral Damage**

The cable damage has global ripple effects:
- Internet latency increases across Asia-Pacific region
- Some cryptocurrency trading platforms experience disruptions
- Cloud services routing through Taiwan face degraded performance
- Several Southeast Asian countries experience partial outages

Countries with Chinese cable investments (Pakistan, Myanmar, several African nations) experience no disruptions, raising questions about whether they would be targeted or leverage.

**Decision Required:**
1. Public attribution and messaging strategy
2. Military, diplomatic, and economic response measures
3. Protection for cable repair operations and future infrastructure
4. Long-term cable security strategy
5. Deterrence strategy for future infrastructure attacks

**Key Questions:**
1. How do you respond to infrastructure attacks that fall below traditional "armed attack" threshold?
2. Should the U.S. establish "red lines" for critical infrastructure attacks?
3. How do you build resilient communications that cannot be disrupted by cable sabotage?
4. What is appropriate retaliation: cyber operations against Chinese infrastructure, economic sanctions, military posturing?

### Phase 4: Debrief (Minutes 70-90)

**Discussion Questions:**

1. **Infrastructure Vulnerability:** Why are submarine cables such attractive targets? What makes defending them difficult?

2. **Attribution Challenge:** How did uncertainty about who caused damage affect response options? What evidence would be sufficient for strong response?

3. **Escalation Control:** How do you respond forcefully without triggering military escalation or cyber warfare spiral?

4. **Gray Zone Conflict:** Infrastructure sabotage sits between peace and war. What frameworks should govern responses?

5. **Resilience vs. Deterrence:** Should strategy emphasize deterring attacks (threats of retaliation) or building resilience (redundancy, diversity)?

6. **International Cooperation:** How can international law and norms better protect critical infrastructure?

7. **Second-Order Effects:**
   - Impact on Taiwan's economic viability and security
   - Precedent for infrastructure attacks in future conflicts
   - Global internet fragmentation and balkanization risks
   - Private sector role in critical infrastructure protection

### Background Materials

**Key Authorities:**
- Taiwan Relations Act, 22 U.S.C. § 3301 et seq.
- Cybersecurity and Infrastructure Security Agency Act
- Communications Act authorities (FCC)
- Law of Armed Conflict (LOAC) and cyber operations

**Infrastructure Data:**
- 95%+ of intercontinental data travels via submarine cables
- ~500 submarine cables globally, carrying ~$10 trillion in financial transactions daily
- Taiwan connected by multiple cables (majority land in northern Taiwan)
- Average cable repair time: 2-6 weeks
- Cable routes: Concentration in South China Sea, vulnerable chokepoints

**Precedents:**
- 2006, 2008 cable cuts disrupted Middle East/Asia internet (causes unclear)
- 2013 Egyptian divers arrested attempting cable sabotage
- 2022 Svalbard cable damage (suspected Russian activity)
- Russia mapping NATO cables in North Atlantic

### Facilitator Notes

**Setup:**
- Show map of Asia-Pacific submarine cables
- Provide brief on cable technology and repair process
- Explain attribution challenges in underwater sabotage

**Time Management:**
- Phase 1: Focus on immediate crisis response
- Phase 2: Emphasize attribution uncertainty
- Phase 3: Force decisions on escalation and deterrence
- Phase 4: Extract lessons on infrastructure protection

**Common Pitfalls:**
- Assuming quick/easy attribution (underwater sabotage very difficult to attribute)
- Escalating to military confrontation without considering intermediate options
- Ignoring resilience/redundancy in favor of retaliation only
- Neglecting private sector role (most cables privately owned)

### Learning Outcomes

1. **Analyze critical infrastructure vulnerabilities** in networked digital systems
2. **Navigate attribution challenges** when evidence is limited or ambiguous
3. **Balance deterrence and resilience** in infrastructure protection strategy
4. **Understand gray-zone conflict** tactics below armed conflict threshold
5. **Coordinate government and private sector** for critical infrastructure security

### Further Reading

- Sechrist, Michael. "New Threats, Old Technology: Vulnerabilities in Undersea Cable Networks." *Belfer Center*, 2012
- Sechrist, Michael. "Cyberspace in Deep Water: Protecting Undersea Communication Cables." *Joint Force Quarterly*, 2010
- Bacas, Aude. "Submarine Cable Resilience." *Atlantic Council*, 2023

**Policy Documents:**
- CISA Critical Infrastructure: https://www.cisa.gov/critical-infrastructure
- International Cable Protection Committee: https://www.iscpc.org/


---

## References and Further Reading

Buchanan, Ben. *The Cybersecurity Dilemma: Hacking, Trust, and Fear Between Nations*. Oxford University Press, 2017.

CISA. "People's Republic of China State-Sponsored Cyber Actor Living Off the Land to Evade Detection." Cybersecurity Advisory AA23-144A. May 24, 2023.

Deibert, Ronald J. *Reset: Reclaiming the Internet for Civil Society*. House of Anansi Press, 2020.

Gady, Franz-Stefan, and Ven Bruusgaard, Kristin, editors. *The Cyber Operations Handbook*. Oxford University Press, 2024.

Gartzke, Erik, and Jon R. Lindsay. "Thermonuclear Cyberwar." *Journal of Cybersecurity* 3, no. 1 (2017): 37-48.

Goldsmith, Jack, and Tim Wu. *Who Controls the Internet? Illusions of a Borderless World*. Oxford University Press, 2006.

Lee, Kai-Fu. *AI Superpowers: China, Silicon Valley, and the New World Order*. Houghton Mifflin Harcourt, 2018.

Lindsay, Jon R., and Erik Gartzke, editors. *Cross-Domain Deterrence: Strategy in an Era of Complexity*. Oxford University Press, 2019.

Mandiant Intelligence. "APT1: Exposing One of China's Cyber Espionage Units." February 2013.

Maurer, Tim. *Cyber Mercenaries: The State, Hackers, and Power*. Cambridge University Press, 2018.

Mueller, Milton L. *Will the Internet Fragment? Sovereignty, Globalization and Cyberspace*. Polity, 2017.

Rid, Thomas. *Active Measures: The Secret History of Disinformation and Political Warfare*. Farrar, Straus and Giroux, 2020.

Segal, Adam. *The Hacked World Order: How Nations Fight, Trade, Maneuver, and Manipulate in the Digital Age*. PublicAffairs, 2016.

Schneier, Bruce. *Data and Goliath: The Hidden Battles to Collect Your Data and Control Your World*. W.W. Norton, 2015.

U.S. Department of Justice. "Seven International Cyber Defendants, Including 'Apt41' Actors, Charged In Connection With Computer Intrusion Campaigns Against More Than 100 Victims Globally." September 16, 2020.

U.S.-China Economic and Security Review Commission. *2023 Annual Report to Congress*. November 2023.

Weber, Steven, and Teri Takai, editors. *Technology and National Security*. MIT Press, 2023.

Zittrain, Jonathan. *The Future of the Internet—And How to Stop It*. Yale University Press, 2008.

---

*End of Chapter 5*
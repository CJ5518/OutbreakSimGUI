--Define the stuff that main.lua needs to render and deal with
--Defines the simple stuff, more complex options are in main.lua maybe

local module = {};

local function makeEntry(name, argName, paramType, helpText)
	if not module.entries then
		module.entries = {};
	end
	module.entries[#module.entries+1] = {name, argName, paramType, helpText}
end


makeEntry(
	"Stop time",
	"--stop",
	"number",
	"The maximum amount of time the simulation will simulate, in units of hours"
);

makeEntry(
	"No output writing",
	"-nowrite",
	"boolean",
	"Don't write output data files"
);

makeEntry(
	"Deterministic",
	"-deterministic",
	"boolean",
	"Use the deterministic simulation model (default is stochastic)"
)
makeEntry(
	"Road Factor (0 for no effect, 1 for 100% effect, can double traffic between locations)",
	"--roadFactor",
	"number",
	"Message"
)
makeEntry(
	"Water Factor (0 for no effect, 1 for 100% effect, can fully remove traffic between locations)",
	"--waterFactor",
	"number",
	"Message"
)
makeEntry(
	"Height Factor (0 for no effect, 1 for 100% effect, can double traffic between locations)",
	"--heightFactor",
	"number",
	"Message"
)

makeEntry(
	"Airports",
	"-airports",
	"boolean",
	"Use airports (default is no airports)"
)

makeEntry(
	"How many ticks per statistics update (best left at 1)",
	"-ticksPerStats",
	"number",
	"NA"
)



module.params = {
	"id",
	"ir",
	"rs",
	"sv",
	"vs",
	"ei",
	"se"
}

module.paramNames = {
	"Infected",
	"Dead",
	"Recovered",
	"Susceptible",
	"Vaccinated",
	"Exposed"
}

--A list of all valid the airport starting location codes, generated from the simulation
module.airportCodes = {"OCA","CSE","JCY","PMX","MHS","NIR","GCT","OTN","BZT","BYW","BDF","VRS","EVA","BCS","SPQ","TSS","QNY","BWL","CWS","DUF","SSW","FOB","PUL","CCD","AXB","REE","WDN","MXG","PSQ","ALV","AEQ","KHT","OLR","AHJ","TGE","ARX","AXF","AYZ","ZXT","FZL","HAE","AZJ","BCJ","ILL","HKV","JAM","PRN","BOF","BOK","BRG","BZS","YYS","YBW","YZZ","CFQ","YAV","CKR","CLC","CLG","TVS","RKZ","LYG","DOY","AAT","THQ","YZY","DWS","TAO","DDR","HQL","JDE","HLJ","NTG","XBR","YEB","YSA","EHT","HLI","CVR","GEC","NIC","YAG","YAM","YCC","YCH","YCL","YCW","YEN","YFC","YGP","YGR","YDG","YJT","YLY","YPS","YPN","YQG","YQI","YQM","YQX","YQY","YSJ","YSL","YSU","YVB","YVR","YXX","YYT","YZR","YZV","YZX","YDT","ZBF","ZGF","CZK","IUA","QLD","BUJ","BJA","ALG","QSF","GJL","AAE","CZL","QMH","TEE","BLJ","QDJ","CFK","CBH","BSK","TGR","ELU","DBC","DCR","PHM","DEQ","DHB","DHG","DLR","DPK","DQA","TBJ","MIR","NBE","TUN","GAF","GAE","DJE","SFA","TOE","MUC","STR","FMM","AGB","OBF","RBM","FDH","FKB","LHA","AUE","GBA","YEO","CWL","SWS","BRS","PLH","NQY","ACI","GCI","JER","EXT","FZO","EJN","ESP","FEL","IGS","RGR","FAL","FLE","JCA","FSN","GAB","JCU","MLN","GFD","FEZ","ERH","NDR","GMQ","AHU","TTU","GVE","GZI","HBQ","SQK","DBB","AAC","ALY","HBE","CAI","CCE","EGH","MUH","PSD","SKV","SEW","SPX","HEY","HGT","HIA","BEN","MJI","LAQ","TIP","LMQ","TOB","ZIS","WAX","HRC","RJI","KHA","TQR","JIC","JPN","JRA","JRB","AMK","BDX","EUE","KPT","RLA","FID","HUD","TWD","MVM","HCC","AHD","GCW","CKE","ROF","CNE","RSX","COP","IRB","GNF","CHZ","LTW","AHF","PCT","CTO","NRI","GTP","NLE","GCD","VLE","FPY","NTJ","MSD","SBO","JVI","UCE","GOL","KKT","PRW","EGP","BLD","MFH","ECA","FMU","OTS","ROL","CTK","WPO","ATE","QWG","ASQ","AAF","ABE","ABI","ABQ","ABR","ABY","ACB","ACK","ACT","ACV","ACY","ADG","ADT","ADM","ADS","ADW","AEL","AEX","AFF","WSG","AFN","AFO","AFW","AGC","AGO","AGS","AHC","AHH","AHN","AIA","AID","AIK","AIO","AIV","AIZ","AKO","AKC","ALB","ALI","ALM","ALN","ALO","ALS","ALW","ALX","AMA","AMN","AMW","ANB","AND","SLT","ANP","ANQ","ANW","ANY","AOH","AOO","APA","APC","APF","APG","APH","APN","APT","APV","ARA","ARB","ARG","WHT","AUZ","ART","ARV","BFT","ASE","SPZ","ASH","ASL","ASN","AST","ASX","ASY","ATL","ATS","ATW","ATY","AUG","AUM","AUN","AUO","AUS","AUW","AVL","AVO","AVP","AVW","AVX","AWM","AXG","AXN","AXS","AXV","AXX","AYE","AYS","TUH","AZO","BAB","BAD","BAF","CLU","BAM","BBB","BBD","BKG","BTN","BBW","BCB","BCE","BCT","BDE","BDG","BDL","BDR","WBU","BEC","BED","BEH","BFD","BFF","BFI","BFL","BFM","BFR","BGD","BGE","BGM","BGR","BHB","BHM","BID","BIE","BIF","BIH","BIL","BIS","BIX","BJC","BJI","BJJ","BKD","BKE","BFK","BKL","BKT","BKW","BKX","BLF","BLH","BLI","BLM","BLU","BLV","BMC","BMG","BMI","BML","BMT","BNA","BNG","BNL","BNO","BNW","BOI","BOS","BOW","HCA","BPI","WMH","BPT","BQK","BRD","BRL","BRO","BRY","BTF","BTL","BTM","TTO","BTP","BTR","BTV","BTY","BUB","BUF","BUM","BUR","BFP","BVO","MVW","BVX","BVY","BWC","BWD","BWG","BWI","WAH","BWM","BXA","BXK","BYG","BYH","BYI","BYS","BBC","BZN","XES","PLY","CAD","CAE","CIG","CAK","CAO","CAR","CBE","CBF","CBK","CBM","CCB","CCR","CCY","LLX","CDC","CDH","CDN","CDR","CDS","CDW","CEA","CEC","CEF","CEU","CEV","CEW","CEY","CEZ","CFD","TZC","CFT","CFV","CGE","CGF","CGI","CGS","CGX","CGZ","CHA","CHK","CHO","CHS","CIC","CID","CIN","CIR","CIU","CKA","CKB","GRM","CKM","CKN","CKV","CLE","CLI","CLK","CLL","CLM","CLR","CLS","CLT","CLW","CMH","CMI","CMX","CMY","CNH","CNK","CNM","CNO","CNU","CNW","CNY","COD","COE","COF","COI","COM","CON","COS","COT","COU","CPF","CPM","CPR","CPS","HCW","CRE","CRG","CRO","CRP","CLD","CRS","CRT","CRW","CRX","CSG","CSM","CSQ","CSV","CTB","CTY","CTZ","CUB","CUH","CVG","CKK","CVN","CVO","CVS","CWA","KIP","CWF","CWI","CXL","CXO","CSN","HAR","CYS","CZT","VEX","DAA","DAB","DAG","DAL","DAN","DAY","DBN","DBQ","DCA","DCU","DDC","DEC","DEH","DEN","DET","DFI","DFW","DGL","DGW","DHN","DHT","DIK","DKK","DLL","DLF","DLH","DLN","DLS","DMA","DMN","DMO","DNL","DNN","DNS","DNV","DOV","DPA","DPG","DRA","DRI","DRE","DRO","DRT","DSM","DSV","DTA","DTL","DTN","DSI","DTW","DUA","DUC","DUG","DUJ","DVL","DVN","NOT","NSL","DVT","DWF","DWH","DXR","DYL","DYS","MIF","CCG","ESO","WTR","ALE","BGT","EAN","EAR","EAT","EAU","EBS","ECG","ECP","ECS","EDE","ETS","EDW","EED","EEN","EFD","EFK","EFW","EGE","EGI","EGV","EKA","EKI","EKN","EKO","EKX","ELA","ELD","ELK","ELM","ELN","LYU","ELP","ELY","EMM","EMP","EMT","END","ENL","ENV","ENW","EOK","EPH","EDK","ERI","ERR","ERV","ESC","ESF","ESN","EST","ESW","ETB","ETN","EUF","EUG","EVM","EVV","EVW","EWB","EWK","EWN","EWR","EYW","WIB","RBK","FAF","FAM","FAR","FAT","FAY","FBG","FBL","FBR","FBY","FCH","FCM","FCS","FCY","FDK","FDR","FDY","FEP","FET","FFA","FFL","FFM","FFO","FFT","MSC","FRD","FHU","FKL","FKN","FLD","FLG","FLL","FLO","FLP","FLU","FLV","FLX","FME","FMH","FMN","FMY","FNL","FNT","FOD","FOE","FOK","FIL","FPR","FRG","FRH","FRI","FRM","FRR","FSD","FSI","FSK","FSM","FST","FSU","FMS","FTK","FTW","FTY","FUL","WFK","FWA","FXE","FXY","FYM","FYV","GAD","GAG","GAI","GBD","GBG","GBR","GCC","JDA","GCK","GCN","GCY","GDM","GDV","GDW","GED","GEG","GEY","GFA","GFK","GFL","GGE","GGG","GGW","GHM","GIF","GJT","MEJ","GKT","GLD","GLE","GLH","GLR","GLS","GLW","GMU","GNG","GNT","GNV","GOK","GON","FCA","GPT","GPZ","GQQ","GRB","GRD","GRE","GRF","GRI","GRK","GRN","GRR","GSB","GSH","GSO","GSP","GSW","GTF","GTG","GTR","GUC","GUP","GUS","GUY","GVL","GVT","GVW","GWO","GWS","GXY","GDC","PNX","GYR","GYY","HAB","HAF","HAI","HAO","HAX","HBG","HBR","HDE","HDN","HEE","MNZ","HEZ","HFD","HFF","HGR","HHR","HUJ","HIB","HIE","HIF","HII","HIO","HKA","HKS","HKY","HLB","HLC","HLG","HLM","HLN","HLR","HMN","HMT","HNB","HSH","HOB","HON","HOP","HOT","HOU","HPN","HPT","HPY","HQM","HES","HRL","HRO","HSB","HNC","THP","HSI","HSP","HST","HSV","HTH","HTL","HTO","HTS","HTW","HUA","HUL","HUM","HUT","HVE","HVN","HVR","HVS","HWD","HWO","WSH","HHH","HYA","HYR","HYS","HZL","JFN","IAB","IAG","IAH","ICL","ICT","IDA","IDI","IDP","XPR","IFA","IFP","IGM","IKK","ILE","ILG","ILM","ILN","IML","IMM","MDN","IMT","IND","INK","INL","INS","INT","INW","IOW","IPL","IPT","IRK","IRS","ISM","ISN","ISO","ISP","ISQ","ISW","ITH","AZA","IWD","ISS","IWS","JCI","IYK","SQA","FRY","JAC","JAN","JAS","JAX","JBR","JCT","JDN","JEF","JFK","JHW","GUF","JLN","JMS","JOT","USA","JKV","JST","JVL","JXN","KIC","KLS","DTH","BXS","RBF","TRH","LAA","LAF","LAL","LAM","LAN","LAR","LAS","LAW","LAX","LBB","LBE","LBF","LBL","LBT","LJN","LCH","LCI","LCK","LCQ","LDJ","LDM","LEB","LEE","LEM","LEW","LEX","LFI","LFK","LFT","LGA","LGB","LGC","LGD","LGF","LGU","LHC","LHV","LIY","LFN","LIC","LIT","LKP","LOW","LKV","CHL","LMS","LMT","LNA","LND","LNK","LNN","LNP","LNR","LNS","LOL","BBX","LOT","LOU","LOZ","LPC","LQK","LRD","LRF","LRJ","LRU","LSB","LSE","LSF","LSK","LSN","LSV","LTS","LUF","LUK","LUL","LVK","LVL","LVM","LVS","LWB","LWC","LWL","LWM","LWS","LWT","LWV","LXN","LXV","LYH","LYO","LZU","PCU","MLK","MAC","MAE","MAF","MAW","MBG","MBL","DXE","MBS","MBY","MCB","MCC","MCD","MCE","MCF","MCI","MCK","MCN","MCO","MCW","MDA","MDD","MDH","XMD","MDT","MDW","MDF","MXE","MEI","MEM","MER","MEV","MFD","MFE","MFI","MFR","MFV","MGC","MGE","MGJ","MGM","MGR","MGW","MGY","MHE","MHK","MHL","MHR","MHT","MHV","MIA","MIB","MIE","MIT","MIV","MJX","MKC","MKE","MKG","MKL","MRK","MLB","MLC","MLI","MLS","MLU","MMH","MMI","MML","MMS","MMT","MMU","MNM","MNN","MOB","MOD","MOT","RMY","MPJ","MPO","MPV","MPZ","MQB","MEO","CTH","MQY","MRB","MRC","MRF","MRN","MRY","MSL","MSN","MSO","MSP","MSS","MSV","MSY","MTC","MTH","MTJ","MTN","MTO","MTP","MTW","MUI","MUO","MUT","MVC","MVE","MVL","MVY","MWA","MWC","MWH","MWL","MWO","MXA","MXF","MYF","MYL","MYR","MYV","MZJ","MZZ","CTX","SXY","NBG","NHX","DGN","NEL","NEN","NEW","NFL","FWH","NGU","NGZ","NHK","NHZ","NIP","NJK","NKX","NLC","NPA","NQA","NQI","NQX","NRB","NRS","NSE","NTD","NTU","NUN","NUQ","NUW","YUM","NZY","NVN","COA","ODC","EYR","OAJ","OAK","OAR","OBE","OCF","OCH","OCW","OEA","OEO","OFF","OFK","OGA","OGB","OGD","OGS","OIC","OIL","OJC","OCN","OKC","ODW","OKK","OKM","OKS","WGO","OLD","OLF","OLM","OLS","OLV","OMA","OMK","ONL","ONO","ONP","ONT","OPF","NCO","ORD","ORF","ORH","ORL","ESD","OSC","OSH","OSU","OTH","OTM","OUN","OVE","OWA","OWB","OWD","OWK","OCE","OXC","OXD","OXR","STQ","OZA","OZR","YJS","RGO","BSQ","PXL","GLB","HBK","CWX","PAE","PAH","PAM","PJB","PAO","PBG","PBI","PVL","PCD","PDK","PDT","PDX","PEQ","PGA","PGD","PGR","PGV","PHD","PHF","ADR","PHK","PHL","PHN","PHP","PHT","PHX","PIA","PIB","PIE","PIH","PIM","PIR","PIT","PKB","PKD","PKF","PLB","PLK","PLN","PLR","PMB","PMD","PMH","PPM","PWY","PNC","PNE","PNN","PNS","POB","POC","POE","POF","POU","POY","PPA","PPF","LPO","PQI","PGL","PRB","PRC","PRO","PRX","PSC","PSF","PSK","PSM","PSN","PGO","PSP","PSX","PTB","PTK","PTN","PTT","PTV","PTW","PUB","PUC","PUW","PVC","PVD","PVF","PVU","PVW","PVZ","PWA","PWD","PWK","PWM","PWT","PYM","RAC","RAL","RAP","RBD","RBG","RBL","RBW","RCA","RCK","RCR","RCT","RDD","RDG","RDM","RDR","RDU","REO","RFD","RFG","RHI","RHV","RIC","RIL","RIV","RIW","RKD","RKP","RKS","RKW","RME","RMG","RNC","RND","RNO","RNT","ROA","ROC","ROG","ROW","ROX","RIE","RPX","WBR","RQO","RRL","RRT","RSL","RSN","RST","RSW","RTN","SRW","RUT","RED","RVS","RWF","RWI","RWL","RXE","RNZ","RZZ","AHM","BDY","SUO","MDJ","PRZ","IDH","SAA","SAC","SAD","SAF","SAN","SAR","SAT","SAV","MQT","SBA","SBD","SBM","SBN","SBP","SBS","SBX","SBY","SCB","SCH","SCK","SDF","SCF","SDM","SDY","SEA","SEE","SEF","SEG","SEM","SEP","SER","SDX","SFB","SFF","SFM","SFO","SFZ","SGF","SGH","UST","SGR","SGT","SGU","SHD","SHN","SHR","SHV","SIK","SIV","SJC","SJN","SJT","SKA","SKF","TSM","SKY","SLB","SLC","SLE","SLG","SLK","SLN","SLO","SLR","SMD","SME","SMF","SMN","SMO","SUM","SMX","SNA","SNK","SNL","SNS","SNY","SOP","SOW","SPA","SPF","SPG","SPI","SPS","SPW","SQI","SQL","SRQ","RUI","SSC","SSF","SSI","STC","STE","STJ","STK","STL","STP","STS","SUA","SUD","SUE","SUN","SUS","SUU","SUW","SUX","SVC","SVE","SVH","SVN","SWF","SWO","SWW","SYI","SYR","SYV","SZL","TBC","TAD","TBN","TBR","TCC","TCL","TCM","TCS","TDO","TDW","TDZ","TEB","TEX","THA","THM","THV","TIK","TIW","TIX","KNT","TLH","TLR","TMA","TMB","OTK","TNP","TNT","TNU","XSD","TOA","TOC","TOI","TOL","TOP","TOR","TPA","TPF","TPH","TPL","TRI","TKF","TRL","TRM","TSP","TTD","TTN","TUL","TUP","TUS","TVC","TVF","TVI","TVL","TWF","TXK","TYZ","TYR","TYS","BFG","NPH","RVR","UTH","PNU","ICS","UBS","UCY","UDD","UES","UGN","UIL","UIN","UIZ","IKB","UKI","UKT","ULM","ATO","UNU","SCE","UOS","UOX","UTM","HTV","NPT","UVA","RKH","VAD","LLY","VBG","VCT","VCV","VDI","VEL","VGT","VHN","VIH","VIS","VJI","VKS","VLA","VLD","VNC","VNY","VOK","VPS","VPZ","VQQ","VRB","VSF","VTN","VYS","GTY","SQV","PGC","WAL","WAY","WBW","WDG","WDR","WHP","WJF","WLD","WLW","WMC","WRB","WRI","WRL","WSD","WST","WVI","WVL","WWD","WWR","WYS","KYO","XNA","WBK","YIP","YKM","YKN","KYL","YNG","BXY","USJ","ZPH","ZZV","KFZ","TIA","BOJ","GOZ","PDV","ROU","SOF","SLS","SZR","TGV","VAR","ECN","LCA","PFO","AKT","DBV","LSZ","OSI","PUY","RJK","BWK","SPU","ZAG","ZAD","LEI","ODB","BIO","RGS","BCN","CDT","LCG","ECV","ILD","GRO","GRX","HSK","IBZ","QSA","RJL","MAD","AGP","MAH","PMI","CQM","REU","LEU","TEV","TOJ","VLC","VLL","VIT","SDR","ZAZ","AGF","BOD","EGC","CNG","PIS","MCU","LIG","NIT","TLS","PUF","LDE","ANG","PGX","ZAO","LBI","DCM","RDZ","BIC","OUI","IDY","CMR","DLE","MVV","OBS","LPY","AHZ","ETZ","ANE","BIA","CLY","FSC","AJA","PRP","SOZ","MFX","AUF","CMF","CFE","BOU","CVF","LYS","SYT","RNE","NCY","GNB","VAF","VHY","AUR","CHR","LYN","CEQ","EBU","CCF","MRS","NCE","PGF","CTT","BAE","MPL","BZR","AVN","GAT","MEN","SCP","EVX","XCR","TUF","CET","LVA","ORE","LBG","JDP","TNF","ORY","VIY","NVS","BES","DNR","LBY","LRT","LDV","LME","LAI","UIP","SBK","MXN","VNE","SNR","BSL","DIJ","EPL","BVE","ENC","BOR","SXB","VTL","TLN","FNI","LTT","MQC","FSP","PYR","AGQ","AXD","ATH","VOL","JKH","PKH","JIK","IOA","HER","KSO","KIT","EFL","KZS","KLX","KGS","AOK","CFU","KSJ","KVA","JKL","KZI","LRS","LXS","LRA","JMK","MLO","MJT","JNX","PAS","JTY","PVK","RHO","GPA","CHQ","JSI","SMI","JSY","SPJ","JTR","JSH","SKU","SKG","ZTH","BUD","DEB","MCQ","PEV","SOB","TZR","QAQ","CRV","BRI","FOG","TAR","LCC","PSR","BDS","SUF","CIY","CTA","LMP","PNL","PMO","REG","TPS","NSY","BLX","CDF","RAN","AHO","DCI","CAG","OLB","FNU","TTB","MXP","BGY","TRN","ALL","GOA","LIN","PMF","AOT","CUF","AVB","BZO","UDN","BLQ","TSF","FRL","VBS","TRS","RMI","VIC","VRN","AOI","VCE","LCV","SAY","CIA","FCO","QSR","EBA","NAP","PSA","FLR","GRS","PEG","LJU","MBX","POW","UHE","TLV","BEV","EIY","HFA","RPN","KSW","MTZ","VTM","MIP","SDV","GZM","MLA","MCM","HOH","LOR","GRZ","INN","KLU","LNZ","SZG","VIE","SMA","BGZ","CVU","FLW","GRW","HOR","TER","PDL","PIX","OPO","SJZ","BNX","OMO","SJJ","TZL","ARW","BCM","BAY","BBU","CND","CLJ","CSB","CRA","IAS","LRO","OMR","OTP","SBZ","SUJ","SCV","TCE","TGM","TSR","GVA","SIR","EML","ZIN","LUG","BRN","BXO","ZHI","ZRH","ZJI","ACH","SMV","GKD","ESB","ANK","ADA","UAB","AFY","AYT","GZT","KFS","KYA","MZH","VAS","ONQ","MLX","ASR","TJK","DNZ","NAV","CII","BZI","BDM","CKZ","ESK","ADB","IGL","USQ","KCO","YEI","DLM","TEQ","BXN","AOE","KZR","EZS","OGU","DIY","ERC","ERZ","KSY","TZX","SFQ","VAN","BAL","MSR","SXZ","NOP","KCM","AJI","ADF","MQM","GNY","IGD","NKT","YKO","HTY","ISE","EDO","BJV","GZP","SZF","LTH","BZY","KIV","GZA","OHD","SKP","GIB","DNF","MRA","UZC","BEG","IVG","BJY","KVO","INI","TGD","TIV","BTS","KSC","LUE","PZY","POV","SLD","DRU","UWA","LIZ","MGI","MHN","ACN","CJS","MAM","MXL","NOG","NLD","PDS","REX","TIJ","UAC","MXC","MAY","TZN","ATC","TBI","NMC","TYM","MPE","NBS","EPG","HBB","NRC","UCC","NLN","BZF","OAA","BIN","CCN","SBF","DAZ","FBD","GRG","KWH","OAI","JAA","KBL","MMZ","MZR","VCC","URN","OAS","SGA","TQN","UND","OBK","URY","HAS","RAE","AJF","TUI","SDG","BND","JYR","KER","BXR","HDR","XBJ","BJB","AFZ","TCX","KHY","ADU","ACP","PFQ","OMH","TBZ","IMQ","JSK","AMM","ADJ","OMF","DWN","BEY","KYE","BYB","FJR","KHS","OHS","BHW","BNP","CJL","CHB","DSK","LYP","GIL","ISB","OHT","LHE","XJM","MFG","MWD","ATG","PAJ","PEW","RAZ","KDU","SGI","SDT","SKT","TLB","WAF","IQA","TQD","BMN","BGW","OSM","DHK","EBL","KIK","RQW","ISU","ALP","DAM","DEZ","KAC","LTK","PMS","PFC","BHC","CWP","GRT","QJP","KNH","LZN","RMQ","MFK","HSZ","TPE","REH","RHT","NRT","MMJ","IBR","KIX","SHM","UKB","HIW","TJH","OBO","CTS","HKD","KUH","MMB","SHB","OKD","RBJ","WKJ","AXJ","IKI","UBJ","TSJ","OMJ","MBE","AKJ","OIR","RIS","FUK","OIT","KKJ","HSG","KMJ","NGS","NGO","NKM","FKJ","QGU","KMQ","OKI","FSZ","TOY","NTQ","HIJ","OKJ","IZO","YGJ","IWK","KCZ","MYJ","ITM","TTJ","TKS","TAK","IWJ","AOJ","GAJ","SDS","FKS","HHE","HNA","AXT","MSJ","KIJ","ONJ","SDJ","SYO","NJA","HAC","OIM","MYE","HND","OKO","MWX","KWJ","KUV","MPK","CHN","RSU","QUN","KAG","WJU","YNY","CJU","CHF","PUS","HIN","USN","ICN","SSN","OSN","GMP","SWU","QDY","KPO","TAE","HMY","CJJ","YEC","GRV","LPS","KEH","SAS","SFR","SOR","SQD","SQJ","SRF","SRU","SSU","SYL","SYN","SZN","SZP","KEA","BGG","RZV","TWC","TWH","BDA","DBS","ALA","BXH","BXJ","TDK","DMB","IKU","FRU","OSS","CIT","HSA","DZN","KZO","SZI","SCO","AKX","GYD","KVD","NAJ","GBB","ZTU","YLV","LWN","EVN","BUS","TBS","KHV","BVV","ITU","DEE","UUS","AEM","ETL","EDN","KVR","TLY","NEI","VVO","RZH","KWG","UKS","SIP","KHC","IFO","CWC","UDJ","KHE","NLV","ODS","VIN","EIK","GDZ","KRR","MCX","OGZ","IGT","AER","LHU","BNH","XWA","RTL","BPA","GMV","ASB","MYP","CRZ","DYU","TJU","LBD","KQT","AZN","FEG","NMA","MOK","NCU","UGC","NVI","BHK","KSQ","AFS","SKD","TMJ","TAS","OSW","UZR","yes","ATQ","AIP","KUU","VIF","DHM","IXJ","IXL","IXP","SXR","BJH","BHP","BJU","BIT","DAP","SIH","GKH","JIR","JUM","JKR","KTM","LDN","LUA","LTG","NGX","PPL","RJB","RHP","RUM","SYH","SKH","FEB","IMK","TPJ","TMI","BIR","FBS","RSJ","LKE","RCE","WSX","WEA","JBK","DTR","GWV","WZQ","MPB","UKN","YAJ","YEH","YLP","YNT","CDE","CIF","BPE","DSN","ERL","YIE","HET","HUO","ZBK","HLD","BAV","UCB","WUA","XIL","RLK","NZL","ZDM","SHF","FNJ","DSO","WOS","DNH","HXD","GOQ","GYU","HTT","INC","JGN","LHW","LNL","IQN","GXH","XNN","XIY","UYN","ZHY","LTI","BYN","HBU","HVD","ULG","ZAT","XMN","CZX","FOC","HGH","JUZ","LYI","NKG","JJN","RUG","RIZ","SZV","TXN","WEF","WHU","WUX","WUS","WNZ","YTY","YNZ","YIW","NGQ","BPX","DCY","GZG","JZH","KGT","LXA","LZY","LPF","XIC","ACX","AKU","ACF","BPL","IQM","FYN","HMI","KCA","KRL","KRY","KJI","NLT","RQA","QSZ","KHG","SXJ","TCG","TLQ","HTN","URC","YIN","YTW","AOG","CGQ","DTU","FYJ","HRB","JIL","JMU","JSJ","JXA","LDS","YUS","MDG","NDG","YSQ","TNH","YNJ"};

return module;
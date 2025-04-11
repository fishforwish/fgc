library(shellpipes)
varnames <- c("fgcstatusYes"
, "group_fgc"
, "bene" 
, "group_bene"
, "media"
, "group_media"
, "genderAware"
, "group_genderAware"
, "edu"
, "group_edu"
, "jobYes"
, "urRuralRural"
, "group_daughterPlan"
, "group_Persist"
) 

varlvlnames <- c("fgcstatus" 
, "group_fgc"
, "bene"
, "group_bene"
, "media"
, "group_media"
, "genderAware"
, "group_genderAware"
, "edu"
, "group_edu"
, "job"
, "urRural"
, "group_daughterPlan"
, "group_Persist"
) 


plotnames <- c("FGCed"
, "Group FGC"
, "Benefit"
, "Group Benefit"
, "Media"
, "Group Media"
, "Gender Awareness"
, "Group Gender Awareness"
, "Education"
, "Group Education"
, "Job"
, "Rural Residence"
, "Group Daughter Plan"
, "Group Persistence"
)  

rename_dat <- data.frame(variable=varnames, plotnames)

saveEnvironment()

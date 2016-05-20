library(ggplot2)

load(".futurefgc.norm.RData")
load(".daughterfgc.norm.RData")
load(".futurefgcDau.norm.RData")

combined_df <- rbind(futurefgc_df,daughterfgc_df
                    ,futurefgcDau_df
                    )

g1 <- (ggplot(combined_df,aes(x=model_cov,y=value,group=model_cov,color=covtype))
       + geom_line()
       + geom_point()
       + facet_grid(model~type,scale="free")
       + theme_bw()
       + geom_hline(yintercept = 0)
       + ggtitle("Mike is Awesome, I don't know what a good title")
)

print(g1)
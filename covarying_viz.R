library(ggplot2)
library(stringr)
library(dplyr)
library(tidytext)

rep_con_data <- readRDS("data/rep_con_data.rds")

covarying_viz <- function(rep_con_form){
  
  matched <-  rep_con_data %>%
    #filter(metric %in% c("obs.w1_2.in_c", "coll.strength")) %>%
    filter(construction.name == rep_con_form)
  
  require(showtext)
  showtext_auto()
  
  p <- ggplot(matched, aes(x=reorder_within(pair, strength, metric), y=strength)) +
    geom_bar(stat="identity", fill = "#7B90D2") +
    coord_flip() +
    facet_wrap(~ as.factor(metric), scales = "free",
               labeller = as_labeller(c("coll.strength" = "Collocation Strength (Fisher's Exact Test)",
                                        "delta.p.word.to.constr" = "Delta P (slot1 to slot2)",
                                        "delta.p.constr.to.word" = "Delta P (slot2 to slot1)",
                                        "obs.w1_2.in_c" = "Observed Frequency (Word Pair in Construction)"))) +
    scale_x_reordered() +
    theme(text = element_text(size=15))+
    xlab("Word Pair") +
    ggtitle(rep_con_form)
  
  return(p)
}
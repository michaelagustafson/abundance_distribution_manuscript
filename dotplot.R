### Dot and whisker of mean and 95% CI
library(dotwhisker)
library(tidyverse)
library(forcats)
library(svglite)
library(magick)

df <- read.csv("E:/Species Distribution Manuscript 2024/Round 1 Edits/dot plot  abund data.csv")

df$Variable <- factor(df$Variable, levels = unique(df$Variable))


pd <- position_dodge(0.78)

group_colors <- c("Willow Ptarmigan" = "#0072B2", "Rock Ptarmigan" = "#9B59A9", "Arctic ground squirrel" = "#E47A00")

dotplot <- ggplot(df, aes(x=Mean, y = Variable, group = forcats::fct_inorder(Species))) +
  #draws the means
  theme_classic(base_size = 40) +
  geom_point(position= pd, aes(color=Species), size = 6) +
  scale_colour_manual(values = group_colors)+
  #draws the CI error bars
  geom_errorbar(data=df, aes(xmin=LC, xmax=UC, 
                                color=Species), linewidth = 4, width=0, position=pd) +
  labs(x = "Standardized coefficient (95% CI)", y = "Parameter")+
  scale_y_discrete(labels = function(x) str_wrap(x, width = 10)) +  # Adjust the width as needed
  geom_vline(xintercept = 0, linetype = "dashed", color = "darkgrey", linewidth = 4) + # Add vertical line at x = 0
  theme(  legend.position = "none",        # Position legend at the bottom
                                               )  
dotplot


ggsave("E:/Species Distribution Manuscript 2024/Round 3 edits 26 May 2024/abund_dotplot.png", width = 17, height = 10, dpi = 300)


#det <- read.csv("E:/Species Distribution Manuscript 2024/Round 1 Edits/dot plot detection data.csv")

#det$Parameter <- factor(det$Parameter, levels = unique(det$Parameter))


#pd <- position_dodge(0.78)

#group_colors <- c("Willow Ptarmigan" = "#0072B2", "Rock Ptarmigan" = "#9B59A9", "Arctic ground squirrel" = "#E47A00")

#detplot <- ggplot(data = det, aes(x = Mean, y = fct_inorder(Parameter), group = forcats::fct_inorder(Species))) +
  theme_classic(base_size = 20) +
  geom_point(position = pd, aes(color = Species), size = 4) +
  scale_colour_manual(values = group_colors) +
  geom_errorbar(data = det, aes(xmin = LC, xmax = UC, color = Species), linewidth = 2, width = 0, position = pd) +
  labs(x = "Standardized coefficient (95% CI)", y = "Parameter") +
  geom_vline(xintercept = 0, linetype = "dashed", color = "darkgrey", linewidth = 2) +
  theme(
    legend.position = "bottom",        # Position legend at the bottom
    legend.box = "horizontal",         # Arrange legend items in a horizontal line
    legend.justification = "center",   # Center the legend horizontally
    legend.margin = margin(t = 10)    # Add margin between legend and x-axis title
  )
#detplot


#ggsave("E:/Species Distribution Manuscript 2024/Round 3 edits 26 May 2024/det_dotplot.png", width = 13, height = 10, dpi = 300)












# relaod and combine plots, add figure letters

dota <- image_read("E:/Species Distribution Manuscript 2024/Round 3 edits 26 May 2024/abund_dotplot.png")
#dotb <- image_read("E:/Species Distribution Manuscript 2024/Round 3 edits 26 May 2024/det_dotplot.png")


dota
dotb
image_info(dotb)



dotb_crop <- image_crop(dotb, "4300x3000+135" )
dotb_crop


dotc <- c(dota,dotb_crop)
dotd <- image_append(dotc)
dotd



# add letters to figures A and B

dote <- image_annotate(dotd, "A", location = "+100+50", color = "black", size = "150")
dote

dotf <- image_annotate(dote, "B", location = "+3800+50", color = "black", size = "150")
dotf


image_write(dotf, "E:/Species Distribution Manuscript 2024/Figures/abun_det_dotplots_26May.png", density = "300")

################

### Vertical append
image_info(dotb)

dotxcrop <- image_crop(dota, "3900x2800")
dotxcrop

dotz <- c(dotxcrop, dotb)


vert <- image_append(dotz, stack = TRUE)
vert


image_write(vert, "E:/Species Distribution Manuscript 2024/Figures/abun_det_dotplots_26May_vert.png", density = "300")




#############################


#### SEPARATING DETECTION INTO PANELS B AND C (CONTINUOUS AND CATEGORICAL)



panel_b <- read.csv("E:/Species Distribution Manuscript 2024/Round 3 edits 26 May 2024/panel b data.csv")
panel_c <- read.csv("E:/Species Distribution Manuscript 2024/Round 3 edits 26 May 2024/panel c data.csv")



######################## B ########################

panel_b$Parameter <- factor(panel_b$Parameter, levels = unique(panel_b$Parameter))


pd <- position_dodge(0.78)

group_colors <- c("Willow Ptarmigan" = "#0072B2", "Rock Ptarmigan" = "#9B59A9", "Arctic ground squirrel" = "#E47A00")

panel_b_plot <- ggplot(data = panel_b, aes(x = Mean, y = fct_inorder(Parameter), group = forcats::fct_inorder(Species))) +
  theme_classic(base_size = 40) +
  geom_point(position = pd, aes(color = Species), size = 6) +
  scale_colour_manual(values = group_colors) +
  geom_errorbar(data = panel_b, aes(xmin = LC, xmax = UC, color = Species), linewidth = 4, width = 0, position = pd) +
  labs(x = "Standardized coefficient (95% CI)", y = "Parameter") +
  scale_y_discrete(labels = function(x) str_wrap(x, width = 10)) +  # Adjust the width as needed
  geom_vline(xintercept = 0, linetype = "dashed", color = "darkgrey", linewidth = 4) +
  theme(
    legend.position = "none",        # Position legend at the bottom
    #legend.box = "horizontal",         # Arrange legend items in a horizontal line
    #legend.justification = "center",   # Center the legend horizontally
    #legend.margin = margin(t = 10),    # Add margin between legend and x-axis title
    #legend.text = element_text(size = 25),  # Adjust legend text size
    #legend.title = element_text(size = 30)  # Adjust legend title text size
  )
panel_b_plot

ggsave("E:/Species Distribution Manuscript 2024/Round 3 edits 26 May 2024/det_dotplot.png", width = 17, height = 10, dpi = 300)

############## C ###################

pc_result_df <- as.data.frame(apply(panel_c[, 3:5], 2, plogis))

pc_bind <- cbind(panel_c[, 1:2], pc_result_df)

c_plot <- ggplot(data = pc_bind, aes(x = Mean, y = fct_inorder(Parameter), group = forcats::fct_inorder(Species))) +
  theme_classic(base_size = 40) +
  geom_point(position = pd, aes(color = Species), size = 6) +
  scale_colour_manual(values = group_colors) +
  geom_errorbar(data = pc_bind, aes(xmin = LC, xmax = UC, color = Species), linewidth = 4, width = 0, position = pd) +
  labs(x = "Detection probability", y = "Parameter") +
  theme(
    legend.position = "bottom",        # Position legend at the bottom
    legend.box = "horizontal",         # Arrange legend items in a horizontal line
    legend.justification = "center",   # Center the legend horizontally
    legend.margin = margin(t = 8),    # Add margin between legend and x-axis title
    legend.text = element_text(size = 25),  # Adjust legend text size
    legend.title = element_text(size = 30)  # Adjust legend title text size
  )
c_plot

ggsave("E:/Species Distribution Manuscript 2024/Round 3 edits 26 May 2024/obs_dotplot.png", width = 17, height = 10, dpi = 300)


##################################################

pana <- image_read("E:/Species Distribution Manuscript 2024/Round 3 edits 26 May 2024/abund_dotplot.png")
panb <- image_read("E:/Species Distribution Manuscript 2024/Round 3 edits 26 May 2024/det_dotplot.png")
panc <- image_read("E:/Species Distribution Manuscript 2024/Round 3 edits 26 May 2024/obs_dotplot.png")


all_pans <- c(pana, panb, panc)
vert2 <- image_append(all_pans, stack = TRUE)

vert2



vert3 <- image_annotate(vert2, "A", location = "+100+50", color = "black", size = "200")
vert3

vert4 <- image_annotate(vert3, "B", location = "+100+3000", color = "black", size = "200")
vert4

vert5 <- image_annotate(vert4, "C", location = "+100+6000", color = "black", size = "200")
vert5

image_write(vert5, "E:/Species Distribution Manuscript 2024/Figures/panels_abc_dotplots_30May_vert.png", density = "300")


### Dot and whisker of mean and 95% CI
library(dotwhisker)
library(tidyverse)
library(forcats)
library(svglite)
library(magick)

######## PANEL A ############

#import data

df <- read.csv("E:/Species Distribution Manuscript 2024/Round 1 Edits/dot plot  abund data.csv")

# set parameters as factors
df$Variable <- factor(df$Variable, levels = unique(df$Variable))

#ggplot
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



#### SEPARATING DETECTION INTO PANELS B AND C (CONTINUOUS AND CATEGORICAL)

#import data

panel_b <- read.csv("E:/Species Distribution Manuscript 2024/Round 3 edits 26 May 2024/panel b data.csv")
panel_c <- read.csv("E:/Species Distribution Manuscript 2024/Round 3 edits 26 May 2024/panel c data.csv")



############### PANEL B ##################

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

############## PANEL C ###################

# apply plogis to mean and upper and lower ci
pc_result_df <- as.data.frame(apply(panel_c[, 3:5], 2, plogis))

# add label columns back to dataframe
pc_bind <- cbind(panel_c[, 1:2], pc_result_df)

#plot
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
##################################################

# combine figures into 1 image

#reupload saved images

pana <- image_read("E:/Species Distribution Manuscript 2024/Round 3 edits 26 May 2024/abund_dotplot.png")
panb <- image_read("E:/Species Distribution Manuscript 2024/Round 3 edits 26 May 2024/det_dotplot.png")
panc <- image_read("E:/Species Distribution Manuscript 2024/Round 3 edits 26 May 2024/obs_dotplot.png")

#list together
all_pans <- c(pana, panb, panc)

#append vertically
vert2 <- image_append(all_pans, stack = TRUE)

vert2

### add labels for each panel

vert3 <- image_annotate(vert2, "A", location = "+100+50", color = "black", size = "200")
vert3

vert4 <- image_annotate(vert3, "B", location = "+100+3000", color = "black", size = "200")
vert4

vert5 <- image_annotate(vert4, "C", location = "+100+6000", color = "black", size = "200")
vert5


# save
image_write(vert5, "E:/Species Distribution Manuscript 2024/Figures/panels_abc_dotplots_30May_vert.png", density = "300")


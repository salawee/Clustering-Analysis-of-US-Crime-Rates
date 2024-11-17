# Load necessary libraries
library(ggplot2)
library(cluster)
library(useful)
library(NbClust)
library(ggalt)

# Load the USArrests dataset
data("USArrests")
head(USArrests)

# Create a scatterplot matrix
pairs(USArrests, pch = 16, col = "blue", main = "Scatterplot Matrix - USArrests")

# Scale the data
arrestsScaled <- scale(USArrests)

# Measuring distance among observations
dist_arrestsScaled <- dist(arrestsScaled)

# k-means clustering
kmeans_model <- kmeans(arrestsScaled, centers = 4, nstart = 10)

# hierarchical clustering
hc <- hclust(dist_arrestsScaled)
cutree_clusters <- cutree(hc, k = 3)

# Perform DBSCAN clustering
dbscan_model <- dbscan(arrestsScaled, eps = 0.5, minPts = 5)

# Visualize the results
# K-means
fviz_cluster(kmeans_model, data = arrestsScaled, geom = "point", stand = FALSE, main = "K-means Clustering")

# Hierarchical Clustering
fviz_dend(hc, main = "Hierarchical Clustering Dendrogram")

# DBSCAN
fviz_cluster(dbscan_model, data = arrestsScaled, geom = "point", stand = FALSE, main = "DBSCAN Clustering")

# step 2: Measuring distance among observation 
dist_arrestsScaled = dist(arrestsScaled)
dist_arrestsScaled

# Set seed for reproducibility
set.seed(123)

# Perform k-means clustering
arrestsKM <- kmeans(arrestsScaled, 4, nstart = 10)
arrestsKM

# Display cluster centers and sizes
arrestsKM$centers
arrestsKM$size

# Plot the 2D data with clusters
p <- qplot(data = data.frame(arrestsScaled), x = UrbanPop, y = Murder, color = factor(arrestsKM$cluster))
g <- guide_legend("Cluster")
p + guides(color = g, size = g, shape = g)

# Perform K-means clustering
arrestsKM <- kmeans(USArrests[, c("UrbanPop", "Murder")], centers = 4, nstart = 25)
USArrests$Cluster <- factor(arrestsKM$cluster)

# 2D Plot: UrbanPop vs. Murder with points colored by clusters
ggplot(USArrests, aes(x = UrbanPop, y = Murder, color = Cluster)) +
  geom_point(alpha = 0.3) +
  geom_encircle(aes(x = UrbanPop, y = Murder, color = Cluster), 
                data = subset(USArrests, !is.na(Cluster)), 
                size = 2, expand = 0.1, alpha = 0.2, fill = NA) +
  labs(title = "K-means Clustering of USArrests",
       x = "UrbanPop", y = "Murder") +
  theme_minimal()


# Plot the "Within cluster Sum of square error" elbow plot
# Custom function for Within cluster Sum of square error 'elbow' plot
wssplot <- function(data, nc = 15) {
  par(mfrow = c(1, 2))
  
  wss <- numeric(nc)
  
  for (i in 1:nc) {
    kmeans_model <- kmeans(data, centers = i, nstart = 10)
    wss[i] <- kmeans_model$tot.withinss
  }
  
  # Plotting Within cluster sum of squares
  plot(1:nc, wss, type = "b", xlab = "Number of Clusters", ylab = "Within groups sum of squares")
  
  # Plotting Percentage of Variance Explained
  pctExp <- 1 - wss/sum(wss)
  plot(1:nc, pctExp, type = "b", xlab = "Number of Clusters", ylab = "Pct Explained")
  
  par(mfrow = c(1, 1))
}

# Now, let's use the wssplot function
wssplot(arrestsScaled, nc = 15)

# Use Hartigan's rule to find the optimal number of clusters
clusFit <- FitKMeans(arrestsScaled, max.clusters = 15, nstart = 20)
PlotHartigan(clusFit)

# Use NbClust to find the optimal number of clusters
NbClust(arrestsScaled, method = "kmeans")

# Explore the clusters
arrestsClustered <- data.frame(USArrests, cluster = arrestsKM$cluster)
head(arrestsClustered)

# Visualize in 3D using PCA
pc <- princomp(arrestsScaled, cor = TRUE, scores = TRUE)
plot3d(pc$scores[, 1:3], col = factor(arrestsKM$cluster), main = "k-means clusters")

# 3D Plot: PCA Visualization
pca_result <- prcomp(USArrests[, c("UrbanPop", "Murder")], scale. = TRUE)
pca_data <- as.data.frame(pca_result$x[, 1:3])
pca_data$Cluster <- USArrests$Cluster

# 3D Scatterplot
scatter3d(
  x = pca_data$PC1,
  y = pca_data$PC2,
  z = pca_data$PC3,
  color = as.numeric(pca_data$Cluster),
  pch = 16,
  cex = 2,
  type = "h",
  main = "3D PCA Visualization of K-means Clustering",
  xlab = "PC1",
  ylab = "PC2",
  zlab = "PC3"
)
legend("topright", legend = levels(USArrests$Cluster), col = 1:3, pch = 16, cex = 1.2, title = "Cluster")

# Check how well the clusters align with regions (Northeast, Midwest, South, West)
table(arrestsClustered$cluster, rownames(arrestsClustered))


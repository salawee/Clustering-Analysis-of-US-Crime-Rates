# 🗺️ Clustering Analysis of US Crime Rates

## 📌 Overview
This project focuses on clustering analysis of the `USArrests` dataset, which contains violent crime statistics (per 100,000 residents) for all 50 U.S. states in 1973. The dataset features four variables: **Murder**, **Assault**, **UrbanPop** (percent urban population), and **Rape**. The goal of the analysis is to identify patterns in crime and urbanization across U.S. states using multiple clustering techniques, including **K-means**, **Hierarchical Clustering**, and **DBSCAN**.

## 🗂️ Dataset
- **Dataset**: `USArrests` (available in R)
- **Number of Observations**: 50 (each representing a U.S. state)
- **Features**: 
  - **Numeric**: Murder, Assault, UrbanPop, Rape
  - **No Categorical Features** 

## 🧪 Clustering Techniques

### 1. Determining the K-Value

To determine the optimal number of clusters (k) for the K-means clustering, several techniques were used:

 **Elbow Method**: This method involves plotting the within-cluster sum of squares (WCSS) against the number of clusters. The point where the decrease in WCSS begins to slow down (i.e., the "elbow") is considered the optimal value for k.

<div align="center">
    <img src="https://github.com/user-attachments/assets/d2ebb77d-a480-4922-a4ae-b8054465776e" alt="Elbow Method" width="500"/>
</div>

 **Hartigan's Rule**: This rule helps to further verify the optimal number of clusters by calculating how much the within-cluster variation decreases when increasing the number of clusters. A significant decrease indicates a suitable number of clusters.

<div align="center">
    <img src="https://github.com/user-attachments/assets/daadfd36-ea90-4f2e-b2be-bdfd21838164" alt="Hartigan's Rule" width="500"/>
</div>

 **NbClust Package**: The NbClust package was used to evaluate multiple cluster validity indices. It provided a recommendation of k = 4 based on the data.

<div align="center">
    <img src="https://github.com/user-attachments/assets/d90bcd63-6093-4019-8f0b-3d2757856614" alt="NbClust Package Output" width="500"/>
</div>

The final choice for k was determined to be 4, based on the consistent findings across these methods.

### 2. K-Means Clustering
- **Optimal Number of Clusters**: Determined using the **Elbow Method**, **Hartigan’s Rule**, and **NbClust** package, resulting in an optimal k of 4.
- **Results**: The clusters provide insights into crime rates and urbanization levels in different states. Cluster analysis revealed:
  - **Cluster 1**: States with higher crime rates.
  - **Cluster 2**: States with lower crime rates.
  - **Cluster 3**: Mixed crime rates.
  - **Cluster 4**: States with relatively higher crime rates.

<div align="center">
    <img src="https://github.com/user-attachments/assets/5d9cab63-636f-4dcc-b06a-a2da8b0d60f2" alt="K-means Clustering Results" width="500"/>
</div>

### 3. Hierarchical Clustering
- **Approach**: Agglomerative, starting from individual points and combining them to form clusters.
- **Results**: Initially proposed 4 clusters, with further subdivisions revealing intricate relationships between states.

<div align="center">
    <img src="https://github.com/user-attachments/assets/ea69025f-50c9-47e3-b440-0f4604e1eb9f" alt="Hierarchical Clustering Dendrogram" width="500"/>
</div>

### 4. DBSCAN Clustering
- **Approach**: A density-based clustering method that identifies regions of high density and can capture clusters of arbitrary shapes.
- **Results**: The clusters from DBSCAN were similar to K-means, but better captured outliers and irregular cluster shapes.

<div align="center">
    <img src="https://github.com/user-attachments/assets/bd7a3883-9252-4431-8e04-5afb24c0a30c" alt="DBSCAN Clustering Results" width="500"/>
</div>

## 🔍 Key Findings
- **Cluster Characteristics**:
  - **Cluster 2** was consistently identified as a group with generally low crime rates.
  - **Clusters 1, 3, and 4** represent varying degrees of crime rates and urbanization, with distinct patterns evident from the centroid values.
- **Best Method**: The choice of clustering technique largely depends on the specific insights sought. 
  - **K-Means** provided clear centroids and easy-to-interpret groupings.
  - **Hierarchical Clustering** offered a more detailed relationship view.
  - **DBSCAN** was flexible in capturing irregular clusters and outliers.

## 📝 Conclusion
This clustering exercise highlighted the power of various clustering methods to identify distinct groups based on crime and urbanization metrics across the United States. Each clustering technique provided a different perspective:
- **K-Means** and **Hierarchical Clustering** captured well-defined groupings of states.
- **DBSCAN** added flexibility by identifying clusters without requiring the pre-specification of the number of clusters.

The findings are useful for understanding how crime and urbanization are interrelated and how they differ from state to state, offering a basis for future research or policy discussions.

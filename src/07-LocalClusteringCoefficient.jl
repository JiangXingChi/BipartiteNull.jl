using DataFrames,Graphs,Statistics

##计算局部聚类系数
"""
`LocalClusteringCoefficient(data::DataFrame)`\n
Calculate the local cluster coefficient of the bipartite network.\n
# Argument\n
* `data`:The adjacency matrix of a bipartite network.\n
# Return\n
* `agroup`:Local cluster coefficient of the species of rows.\n
* `bgroup`:Local cluster coefficient of the species of columns.\n
# Example\n
using BipartiteNull,DataFrames,Graphs;\n
data=ExampleData(6);\n
print(data);\n
agroup,bgroup=LocalClusteringCoefficient(data)
"""
function LocalClusteringCoefficient(data::DataFrame)
#  选择对二分网络邻接矩阵的转化网络模式
  omm_agroup,graph_agroup=Bipartite2Graph(data,"Col2Edge")
  omm_bgroup,graph_bgroup=Bipartite2Graph(data,"Row2Edge")
#  计算局部聚类系数
  agroup=Graphs.local_clustering_coefficient(graph_agroup)
  bgroup=Graphs.local_clustering_coefficient(graph_bgroup)
#  返回计算结构
  return(agroup,bgroup)
end

##计算局部聚类系数的平均数
"""
`MeanLocalClusteringCoefficient(data::DataFrame)`\n
Calculate the local cluster coefficient of the bipartite network.\n
# Argument\n
* `data`:The adjacency matrix of a bipartite network.\n
# Return\n
* `agroup`:Local cluster coefficient of the species of rows.\n
* `bgroup`:Local cluster coefficient of the species of columns.\n
# Example\n
using BipartiteNull,DataFrames,Graphs;\n
data=ExampleData(6);\n
print(data);\n
agroup,bgroup=MeanLocalClusteringCoefficient(data)
"""
function MeanLocalClusteringCoefficient(data::DataFrame)
#  选择对二分网络邻接矩阵的转化网络模式
  omm_agroup,graph_agroup=Bipartite2Graph(data,"Col2Edge")
  omm_bgroup,graph_bgroup=Bipartite2Graph(data,"Row2Edge")
#  计算局部聚类系数
  agroup=mean(Graphs.local_clustering_coefficient(graph_agroup))
  bgroup=mean(Graphs.local_clustering_coefficient(graph_bgroup))
#  返回计算结构
  return(agroup,bgroup)
end
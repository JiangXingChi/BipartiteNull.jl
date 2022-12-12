using DataFrames,Graphs,Statistics

"""
`BetweennessCentrality(data::DataFrame)`\n
Calculate the betweenness centrality of the bipartite network.\n
# Argument\n
* `data`:The adjacency matrix of a bipartite network.\n
# Return\n
* `all`:Betweenness centrality of all species.\n
* `agroup`:Betweenness centrality of the species of rows.\n
* `bgroup`:Betweenness centrality of the species of columns.\n
# Example\n
using BipartiteNull,DataFrames,Graphs;\n
data=ExampleData(1);\n
print(data);\n
all,agroup,bgroup=BetweennessCentrality(data)
"""
function BetweennessCentrality(data::DataFrame)
#  选择对二分网络邻接矩阵的转化网络模式
  omm_all,graph_all=Bipartite2Graph(data,"Splicing4Matrix")
  omm_agroup,graph_agroup=Bipartite2Graph(data,"Col2Edge")
  omm_bgroup,graph_bgroup=Bipartite2Graph(data,"Row2Edge")
#  利用Graphs计算
  all=Graphs.betweenness_centrality(graph_all)
  agroup=Graphs.betweenness_centrality(graph_agroup)
  bgroup=Graphs.betweenness_centrality(graph_bgroup)
#  对外返回
  return(all,agroup,bgroup)
end

"""
`ClosenessCentrality(data::DataFrame)`\n
Calculate the closeness centrality of the bipartite network.\n
# Argument\n
* `data`:The adjacency matrix of a bipartite network.\n
# Return\n
* `all`:Closeness centrality of all species.\n
* `agroup`:Closeness centrality of the species of rows.\n
* `bgroup`:Closeness centrality of the species of columns.\n
# Example\n
using BipartiteNull,DataFrames,Graphs;\n
data=ExampleData(1);\n
print(data);\n
all,agroup,bgroup=ClosenessCentrality(data)
"""
function ClosenessCentrality(data::DataFrame)
#  选择对二分网络邻接矩阵的转化网络模式
  omm_all,graph_all=Bipartite2Graph(data,"Splicing4Matrix")
  omm_agroup,graph_agroup=Bipartite2Graph(data,"Col2Edge")
  omm_bgroup,graph_bgroup=Bipartite2Graph(data,"Row2Edge")
#  利用Graphs计算
  all=Graphs.closeness_centrality(graph_all)
  agroup=Graphs.closeness_centrality(graph_agroup)
  bgroup=Graphs.closeness_centrality(graph_bgroup)
#  对外返回
  return(all,agroup,bgroup)
end

"""
`DegreeCentrality(data::DataFrame)`\n
Calculate the degree centrality of the bipartite network.\n
# Argument\n
* `data`:The adjacency matrix of a bipartite network.\n
# Return\n
* `all`:Degree centrality of all species.\n
* `agroup`:Degree centrality of the species of rows.\n
* `bgroup`:Degree centrality of the species of columns.\n
# Example\n
using BipartiteNull,DataFrames,Graphs;\n
data=ExampleData(1);\n
print(data);\n
all,agroup,bgroup=DegreeCentrality(data)
"""
function DegreeCentrality(data::DataFrame)
#  选择对二分网络邻接矩阵的转化网络模式
  omm_all,graph_all=Bipartite2Graph(data,"Splicing4Matrix")
  omm_agroup,graph_agroup=Bipartite2Graph(data,"Col2Edge")
  omm_bgroup,graph_bgroup=Bipartite2Graph(data,"Row2Edge")
#  利用Graphs计算
  all=Graphs.degree_centrality(graph_all)
  agroup=Graphs.degree_centrality(graph_agroup)
  bgroup=Graphs.degree_centrality(graph_bgroup)
#  对外返回
  return(all,agroup,bgroup)
end
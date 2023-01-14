using DataFrames,Graphs,Statistics,CategoricalArrays

##基于标签传播算法计算模块度
"""
`ModularityLabelPropagation(data::DataFrame)`\n
Calculate the modularity by label propagation.\n
# Argument\n
* `data`:The adjacency matrix of a bipartite network.\n
# Return\n
* `all`:Modularity of all species.\n
* `agroup`:Modularity of the species of rows.\n
* `bgroup`:Modularity of the species of columns.\n
# Example\n
using BipartiteNull,DataFrames,Graphs;\n
data=ExampleData(1);\n
print(data);\n
all,agroup,bgroup=ModularityLabelPropagation(data)
"""
function ModularityLabelPropagation(data::DataFrame)
#  选择对二分网络邻接矩阵的转化网络模式
  omm_all,graph_all=Bipartite2Graph(data,"Splicing4Matrix")
  omm_agroup,graph_agroup=Bipartite2Graph(data,"Col2Edge")
  omm_bgroup,graph_bgroup=Bipartite2Graph(data,"Row2Edge")
#  利用标签传播算法计算节点标签
  label_all=Graphs.label_propagation(graph_all)[1]
  label_agroup=Graphs.label_propagation(graph_agroup)[1]
  label_bgroup=Graphs.label_propagation(graph_bgroup)[1]
#  计算模块度
  all=Graphs.modularity(graph_all,label_all)
  agroup=Graphs.modularity(graph_agroup,label_agroup)
  bgroup=Graphs.modularity(graph_bgroup,label_bgroup)
#  返回数据
  return(all,agroup,bgroup)
end

##基于标签传播算法对二分网络进行分割
"""
`LabelPropagation(data::DataFrame)`\n
Mark the label by label propagation.\n
# Argument\n
* `data`:The adjacency matrix of a bipartite network.\n
* `maxiter`:Return after maxiter iterations if convergence has not completed.\n
# Return\n
* `newlabel`:Vertex and label information.\n
# Example\n
using BipartiteNull,DataFrames,Graphs;\n
data=ExampleData(1);\n
print(data);\n
newlabel=LabelPropagation(data)
"""
function LabelPropagation(data::DataFrame;maxiter=1000)
#  重整数据框
  newdata=Splicing4Matrix(data)
#  选择对二分网络邻接矩阵的转化网络模式
  omm_all,graph_all=Bipartite2Graph(data,"Splicing4Matrix")
#  利用标签传播算法计算节点标签
  label_all=Graphs.label_propagation(graph_all,maxiter)[1]
#  总结标签类别、标签数量
  ca=CategoricalArray(label_all)
  label_level=levels(ca)
  label_number=length(label_level)
#  创建数据框用于处理标签
  newlabel=copy(newdata)
  newlabel=newlabel[:,[1,2]]
  rename!(newlabel,[:Vertex,:Label])
  newlabel[:,2]=label_all
#  标签替换，将某类只有1个节点的标签全换成0，便于可视化着色
  for i in 1:label_number
    temp_label=label_level[i]
    if size(newlabel[newlabel.Label.==temp_label,:],1)==1
      replace!(newlabel.Label,temp_label=>0)
    end
  end
#  返回数据
  return(newlabel)
end